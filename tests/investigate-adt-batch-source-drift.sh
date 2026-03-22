#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ADT batch source-definition investigation =="
echo "This compares pre-search ADT shape across maintained source/dist variants."

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

random_source="${PHD_ADT_BRIDGE_RANDOM_SOURCE:-$ROOT_DIR/qcsp3/ADT-Random/Rnddefault}"
summary_file="$tmp_dir/summary.tsv"
: >"$summary_file"

cases=(
  "csp-dist1|phd-research|PHD-CSP|dist1"
  "qcsp3-dist1|qcsp3|PHD-QCSP3|dist1"
  "qcsp3-old-dist1|qcsp3|PHD-QCSP3|old-dist1-pre-quilici"
)

for entry in "${cases[@]}"; do
  IFS='|' read -r label system_name package_name dist_id <<<"$entry"
  workdir="$tmp_dir/$label"
  cache_dir="$tmp_dir/cache-$label"
  mkdir -p "$workdir/ADT-Random" "$cache_dir"
  cp "$random_source" "$workdir/ADT-Random/Rnddefault"

  if PHD_ADT_SYSTEM="$system_name" \
     PHD_ADT_PACKAGE="$package_name" \
     PHD_ADT_DIST_ID="$dist_id" \
     PHD_ADT_RANDOM_IDENT="default" \
     PHD_ADT_WORKDIR="$workdir/" \
     XDG_CACHE_HOME="$cache_dir" \
     sbcl --non-interactive --load "$ROOT_DIR/tests/run-adt-batch-input-shape-generic.lisp" \
       >"$workdir/output.txt" 2>/dev/null; then
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

print(
    "\t".join(
        [
            label,
            "ok",
            value("system"),
            value("dist_id"),
            value("situation_size"),
            value("raw_var_count"),
            value("raw_avg_domain"),
            value("node_avg_domain"),
            value("node_checks"),
            value("first_three_lines"),
            value("first_var_shape"),
        ]
    )
)
PY
  else
    printf '%s\tfailed\t%s\t%s\t-\t-\t-\t-\t-\t%s\t%s\n' \
      "$label" "$system_name" "$dist_id" "<run failed>" "<run failed>" >>"$summary_file"
  fi
done

python3 - "$summary_file" <<'PY'
from pathlib import Path
import sys

rows = []
for line in Path(sys.argv[1]).read_text().splitlines():
    label, status, system_name, dist_id, situation_size, raw_var_count, raw_avg_domain, node_avg_domain, node_checks, first_three_lines, first_var_shape = line.split("\t", 10)
    rows.append(
        {
            "label": label,
            "status": status,
            "system": system_name,
            "dist": dist_id,
            "situation_size": situation_size,
            "raw_var_count": raw_var_count,
            "raw_avg_domain": raw_avg_domain,
            "node_avg_domain": node_avg_domain,
            "node_checks": node_checks,
            "first_three_lines": first_three_lines,
            "first_var_shape": first_var_shape,
        }
    )

for row in rows:
    print(f"{row['label']}: {row['system']} / {row['dist']} ({row['status']})")
    if row["status"] == "ok":
        print(f"  situation_size={row['situation_size']} raw_var_count={row['raw_var_count']}")
        print(f"  raw_avg_domain={row['raw_avg_domain']} node_avg_domain={row['node_avg_domain']} node_checks={row['node_checks']}")
        print(f"  first_var_shape={row['first_var_shape']}")
    else:
        print("  probe failed before producing a comparable shape")

baseline = next(row for row in rows if row["label"] == "csp-dist1")
print()
for row in rows[1:]:
    if row["status"] != "ok":
        print(f"vs {baseline['label']} -> {row['label']}: probe failed")
        continue
    same_shape = row["first_var_shape"] == baseline["first_var_shape"]
    same_head = row["first_three_lines"] == baseline["first_three_lines"]
    print(
        f"vs {baseline['label']} -> {row['label']}: "
        f"same_head={str(same_head).lower()} same_first_var_shape={str(same_shape).lower()} "
        f"dsize_delta={float(row['node_avg_domain']) - float(baseline['node_avg_domain']):g} "
        f"ncc_delta={int(row['node_checks']) - int(baseline['node_checks'])}"
    )
PY

echo "ADT batch source-definition investigation completed."
