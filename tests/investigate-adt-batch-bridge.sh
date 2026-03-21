#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ADT batch bridge investigation =="
echo "This runs the first narrow executable bridge case for the preserved ij2 family."

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

bridge_dir="$tmp_dir/csp-bridge"
mkdir -p "$bridge_dir/ADT-Random"

for path in csp/*.lisp; do
  ln -s "$ROOT_DIR/$path" "$bridge_dir/$(basename "$path")"
done

cp "$ROOT_DIR/qcsp-may29-1996/ADT-Random/Rnddefault" \
  "$bridge_dir/ADT-Random/Rnddefault"

output_file="$tmp_dir/ij2-050.1"
cache_dir="$tmp_dir/cache"
mkdir -p "$cache_dir"

PHD_ADT_BRIDGE_WORKDIR="$bridge_dir/" \
PHD_ADT_BRIDGE_OUTPUT="$output_file" \
XDG_CACHE_HOME="$cache_dir" \
sbcl --non-interactive --load "$ROOT_DIR/tests/run-adt-batch-bridge-ij2.lisp" \
  >/dev/null 2>&1

python3 - "$ROOT_DIR/data/csp-adt-batch/ij2/ij2-050.1" "$output_file" <<'PY'
from pathlib import Path
import sys

def normalize_tokens(path: Path) -> list[str]:
    text = path.read_text().strip().replace(" / ", "/")
    return text.split()

preserved = normalize_tokens(Path(sys.argv[1]))
produced = normalize_tokens(Path(sys.argv[2]))

if len(preserved) < 21 or len(produced) < 21:
    raise SystemExit("ADT bridge output does not have the expected single-line shape")

compare_indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 14, 15, 16, 17, 18, 19, 20]
mismatches = []
for index in compare_indexes:
    if preserved[index] != produced[index]:
        mismatches.append((index, preserved[index], produced[index]))

if mismatches:
    print("Bridge currently diverges from the preserved case.")
    print("Preserved line:", " ".join(preserved))
    print("Produced line: ", " ".join(produced))
    for index, expected, actual in mismatches:
        print(f"Mismatch at column {index}: expected {expected!r}, got {actual!r}")
else:
    print("Bridge case matched preserved non-timing metrics.")
    print("Produced line:", " ".join(produced))
PY

echo "ADT batch bridge investigation completed."
