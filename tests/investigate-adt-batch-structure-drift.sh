#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ADT batch structure-drift investigation =="
echo "This compares the generated ij2 situation profile and node-domain shape across maintained ADT sources."

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

random_source="${PHD_ADT_BRIDGE_RANDOM_SOURCE:-$ROOT_DIR/qcsp3/ADT-Random/Rnddefault}"
summary_file="$tmp_dir/summary.tsv"
: >"$summary_file"

cases=(
  "csp-dist1|phd-research|PHD-CSP|dist1"
  "qcsp3-dist1|qcsp3|PHD-QCSP3|dist1"
)

for entry in "${cases[@]}"; do
  IFS='|' read -r label system_name package_name dist_id <<<"$entry"
  workdir="$tmp_dir/$label"
  cache_dir="$tmp_dir/cache-$label"
  mkdir -p "$workdir/ADT-Random" "$cache_dir"
  cp "$random_source" "$workdir/ADT-Random/Rnddefault"

  PHD_ADT_SYSTEM="$system_name" \
  PHD_ADT_PACKAGE="$package_name" \
  PHD_ADT_DIST_ID="$dist_id" \
  PHD_ADT_RANDOM_IDENT="default" \
  PHD_ADT_WORKDIR="$workdir/" \
  XDG_CACHE_HOME="$cache_dir" \
  sbcl --non-interactive --load "$ROOT_DIR/tests/run-adt-batch-input-shape-generic.lisp" \
    >"$workdir/output.txt" 2>/dev/null

  python3 - "$label" "$workdir/output.txt" >>"$summary_file" <<'PY'
from pathlib import Path
import re
import sys

label = sys.argv[1]
text = Path(sys.argv[2]).read_text()

def value(name: str) -> str:
    match = re.search(rf"^[ \t]*{name}=(.*)$", text, re.MULTILINE)
    if not match:
        raise SystemExit(f"Missing {name} in {label}")
    return match.group(1).strip()

fields = [
    "system",
    "dist_id",
    "base_situation_size",
    "situation_size",
    "noise_size",
    "raw_avg_domain",
    "node_avg_domain",
    "node_checks",
    "stmt_counts",
    "noise_stmt_counts",
    "raw_domain_sizes",
    "node_domain_sizes",
    "node_domain_heads",
]

print("\t".join([label] + [value(field) for field in fields]))
PY
done

python3 - "$summary_file" <<'PY'
from pathlib import Path
import re
import sys

def parse_pair_list(text: str):
    return [(match.group(1), int(match.group(2))) for match in re.finditer(r'\("([^"]+)"\s+(\d+)\)', text)]

rows = []
for line in Path(sys.argv[1]).read_text().splitlines():
    (
        label,
        system_name,
        dist_id,
        base_situation_size,
        situation_size,
        noise_size,
        raw_avg_domain,
        node_avg_domain,
        node_checks,
        stmt_counts,
        noise_stmt_counts,
        raw_domain_sizes,
        node_domain_sizes,
        node_domain_heads,
    ) = line.split("\t")
    rows.append(
        {
            "label": label,
            "system": system_name,
            "dist_id": dist_id,
            "base_situation_size": int(base_situation_size),
            "situation_size": int(situation_size),
            "noise_size": int(noise_size),
            "raw_avg_domain": float(raw_avg_domain),
            "node_avg_domain": float(node_avg_domain),
            "node_checks": int(node_checks),
            "stmt_counts": parse_pair_list(stmt_counts),
            "noise_stmt_counts": parse_pair_list(noise_stmt_counts),
            "raw_domain_sizes": parse_pair_list(raw_domain_sizes),
            "node_domain_sizes": parse_pair_list(node_domain_sizes),
            "node_domain_heads": node_domain_heads,
        }
    )

for row in rows:
    print(f"{row['label']}: {row['system']} / {row['dist_id']}")
    print(
        f"  base={row['base_situation_size']} total={row['situation_size']} noise={row['noise_size']} "
        f"raw_avg_domain={row['raw_avg_domain']:.1f} node_avg_domain={row['node_avg_domain']:.1f} "
        f"node_checks={row['node_checks']}"
    )
    print(f"  noise_stmt_counts={row['noise_stmt_counts']}")
    print(f"  node_domain_sizes={row['node_domain_sizes']}")

baseline = rows[0]
compare = rows[1]

def to_dict(pairs):
    return {key: value for key, value in pairs}

baseline_noise = to_dict(baseline["noise_stmt_counts"])
compare_noise = to_dict(compare["noise_stmt_counts"])
all_noise_keys = sorted(set(baseline_noise) | set(compare_noise))
noise_delta = {
    key: compare_noise.get(key, 0) - baseline_noise.get(key, 0)
    for key in all_noise_keys
    if compare_noise.get(key, 0) != baseline_noise.get(key, 0)
}

baseline_domains = to_dict(baseline["node_domain_sizes"])
compare_domains = to_dict(compare["node_domain_sizes"])
all_domain_keys = sorted(set(baseline_domains) | set(compare_domains))
domain_delta = {
    key: compare_domains.get(key, 0) - baseline_domains.get(key, 0)
    for key in all_domain_keys
    if compare_domains.get(key, 0) != baseline_domains.get(key, 0)
}

print()
print("Cross-system delta (qcsp3 - csp):")
print(f"  situation_size_delta={compare['situation_size'] - baseline['situation_size']}")
print(f"  noise_size_delta={compare['noise_size'] - baseline['noise_size']}")
print(f"  node_avg_domain_delta={compare['node_avg_domain'] - baseline['node_avg_domain']:.1f}")
print(f"  node_checks_delta={compare['node_checks'] - baseline['node_checks']}")
print(f"  noise_stmt_count_delta={noise_delta}")
print(f"  node_domain_size_delta={domain_delta}")

if baseline["node_domain_heads"] != compare["node_domain_heads"]:
    print("  node_domain_heads differ between csp and qcsp3")
    print(f"    csp={baseline['node_domain_heads']}")
    print(f"    qcsp3={compare['node_domain_heads']}")
PY

echo "ADT batch structure-drift investigation completed."
