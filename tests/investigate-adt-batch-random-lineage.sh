#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ADT batch random-lineage investigation =="
echo "This compares the first ij2 bridge case against preserved output using"
echo "different surviving Rnddefault bundles from the historical snapshots."

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

bridge_dir="$tmp_dir/csp-bridge"
mkdir -p "$bridge_dir/ADT-Random"

for path in csp/*.lisp; do
  ln -s "$ROOT_DIR/$path" "$bridge_dir/$(basename "$path")"
done

preserved="$ROOT_DIR/data/csp-adt-batch/ij2/ij2-050.1"
summary_file="$tmp_dir/summary.tsv"
: >"$summary_file"

sources=(
  "may29|$ROOT_DIR/qcsp-may29-1996/ADT-Random/Rnddefault"
  "qcsp3|$ROOT_DIR/qcsp3/ADT-Random/Rnddefault"
  "alex|$ROOT_DIR/qcsp-alex-sep16-1997/ADT-Random/Rnddefault"
  "yj-sun|$ROOT_DIR/historical finds/yj-sun/Csp/ADT-Random/Rnddefault"
)

for entry in "${sources[@]}"; do
  IFS='|' read -r label source_path <<<"$entry"
  output_file="$tmp_dir/${label}-ij2-050.1"
  cache_dir="$tmp_dir/cache-$label"
  source_sha="$(shasum -a 256 "$source_path" | awk '{print substr($1,1,12)}')"
  mkdir -p "$cache_dir"

  cp "$source_path" "$bridge_dir/ADT-Random/Rnddefault"

  if PHD_ADT_BRIDGE_WORKDIR="$bridge_dir/" \
     PHD_ADT_BRIDGE_OUTPUT="$output_file" \
     XDG_CACHE_HOME="$cache_dir" \
     sbcl --non-interactive --load "$ROOT_DIR/tests/run-adt-batch-bridge-ij2.lisp" \
       >/dev/null 2>&1; then
    python3 - "$preserved" "$output_file" "$label" "$source_path" >>"$summary_file" <<'PY'
from pathlib import Path
import hashlib
import sys

def normalize_tokens(path: Path) -> list[str]:
    text = path.read_text().strip().replace(" / ", "/")
    return text.split()

preserved = normalize_tokens(Path(sys.argv[1]))
produced = normalize_tokens(Path(sys.argv[2]))
label = sys.argv[3]
source_path = Path(sys.argv[4])
compare_indexes = [7, 8, 9, 10, 17, 18]
mismatches = [
    f"{index}:{preserved[index]}!={produced[index]}"
    for index in compare_indexes
    if preserved[index] != produced[index]
]
sha = hashlib.sha256(source_path.read_bytes()).hexdigest()[:12]
print(
    "\t".join(
        [
            label,
            sha,
            str(len(mismatches)),
            str(
                abs(float(produced[7]) - float(preserved[7]))
                + abs(int(produced[8]) - int(preserved[8]))
                + abs(int(produced[9]) - int(preserved[9]))
                + abs(int(produced[10].split("/")[0]) - int(preserved[10].split("/")[0]))
                + abs(int(produced[10].split("/")[1]) - int(preserved[10].split("/")[1]))
                + abs(int(produced[17]) - int(preserved[17]))
                + abs(int(produced[18]) - int(preserved[18]))
            ),
            " | ".join(mismatches) if mismatches else "match",
            " ".join(produced),
        ]
    )
)
PY
  else
    printf '%s\t%s\t999\t999999\tbridge-run-failed\t<no output>\n' \
      "$label" "$source_sha" >>"$summary_file"
  fi
done

python3 - "$summary_file" <<'PY'
from pathlib import Path
import sys

rows = []
for line in Path(sys.argv[1]).read_text().splitlines():
    label, sha, mismatch_count, score, mismatch_text, produced = line.split("\t", 5)
    rows.append((int(mismatch_count), float(score), label, sha, mismatch_text, produced))

rows.sort()
for mismatch_count, score, label, sha, mismatch_text, produced in rows:
    print(f"{label}: {mismatch_count} tracked mismatches, distance score {score:g} (Rnddefault sha {sha})")
    print(f"  {mismatch_text}")
    print(f"  Produced: {produced}")

best = rows[0]
print()
print(f"Closest surviving default bundle: {best[2]} ({best[0]} mismatches, score {best[1]:g})")
PY

echo "ADT batch random-lineage investigation completed."
