#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ADT batch qcsp3 old-dist1 bridge investigation =="
echo "This runs the first narrow executable ij2 bridge case through qcsp3 with a runtime-patched old-dist1-pre-quilici distribution."

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

bridge_dir="$tmp_dir/qcsp3-bridge"
mkdir -p "$bridge_dir/ADT-Random" "$bridge_dir/ADT-Situation" "$bridge_dir/ADT-Batch"

for path in qcsp3/*.lisp; do
  base="$(basename "$path" .lisp)"
  if [[ "$base" == "adt-setup" ]]; then
    cp "$ROOT_DIR/$path" "$bridge_dir/$base.lisp"
  else
    ln -s "$ROOT_DIR/$path" "$bridge_dir/$base.lisp"
  fi
done

python3 - "$bridge_dir/adt-setup.lisp" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
text = path.read_text()
old = """\t( \"old-dist1-pre-quilici\"\n\t  (\n\t   ((Decl   1) \n\t    (Zero   1) \n\t    (Assign 1) \n\t    (Print  1) \n\t    (Check  1) \n\t    (For    1) \n\t    (Block  1))\n\t   ((array 1) (int 2) (char 2) (real 1) (boolean 1) )\n\t   ((int 2)  (char 2) (real 1) (boolean 1) )\n\t   ))"""
new = """\t( \"old-dist1-pre-quilici\"\n\t  ( (Decl   1) \n\t    (Zero   1) \n\t    (Assign 1) \n\t    (Print  1) \n\t    (Check  1) \n\t    (For    1) \n\t    (Block  1))\n\t  ( (array 1) (int 2) (char 2) (real 1) (boolean 1) )\n\t  ( (int 2)  (char 2) (real 1) (boolean 1) ) )"""
if old not in text:
    raise SystemExit("old-dist1-pre-quilici stanza not found in temporary adt-setup.lisp")
path.write_text(text.replace(old, new, 1))
PY

for path in "$bridge_dir"/*.lisp; do
  base="$(basename "$path" .lisp)"
  if [[ ! -e "$bridge_dir/$base" ]]; then
    ln -s "$path" "$bridge_dir/$base"
  fi
done

random_source="${PHD_ADT_BRIDGE_RANDOM_SOURCE:-$ROOT_DIR/qcsp3/ADT-Random/Rnddefault}"
cp "$random_source" "$bridge_dir/ADT-Random/Rnddefault"
random_sha="$(shasum -a 256 "$random_source" | awk '{print substr($1,1,12)}')"

echo "Using Rnddefault source: $random_source"
echo "Rnddefault sha: $random_sha"

output_file="$tmp_dir/ij2-050.1"
produced_file="$bridge_dir/ADT-Batch/Test-$(basename "$output_file")"
cache_dir="$tmp_dir/cache"
mkdir -p "$cache_dir"

PHD_ADT_QCSP3_WORKDIR="$bridge_dir/" \
PHD_ADT_QCSP3_OUTPUT="$output_file" \
PHD_ADT_QCSP3_DIST_ID="old-dist1-pre-quilici" \
XDG_CACHE_HOME="$cache_dir" \
sbcl --non-interactive --load "$ROOT_DIR/tests/run-adt-batch-bridge-qcsp3-ij2.lisp" \
  >"$tmp_dir/old-dist1.log" 2>&1 || {
    cat "$tmp_dir/old-dist1.log"
    exit 1
  }

python3 - "$ROOT_DIR/data/csp-adt-batch/ij2/ij2-050.1" "$produced_file" <<'PY'
from pathlib import Path
import sys

def normalize_tokens(path: Path) -> list[str]:
    text = path.read_text().strip().replace(" / ", "/")
    tokens = text.split()
    if len(tokens) > 21 and "50" in tokens:
        tokens = tokens[tokens.index("50"):]
    return tokens

preserved = normalize_tokens(Path(sys.argv[1]))
produced = normalize_tokens(Path(sys.argv[2]))

if len(preserved) < 21 or len(produced) < 21:
    raise SystemExit("qcsp3 old-dist1 bridge output does not have the expected single-line shape")

compare_indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 14, 15, 16, 17, 18, 19, 20]
mismatches = []
for index in compare_indexes:
    if preserved[index] != produced[index]:
        mismatches.append((index, preserved[index], produced[index]))

if mismatches:
    print("qcsp3 old-dist1 bridge currently diverges from the preserved case.")
    print("Preserved line:", " ".join(preserved))
    print("Produced line: ", " ".join(produced))
    for index, expected, actual in mismatches:
        print(f"Mismatch at column {index}: expected {expected!r}, got {actual!r}")
else:
    print("qcsp3 old-dist1 bridge case matched preserved non-timing metrics.")
    print("Produced line:", " ".join(produced))
PY

echo "ADT batch qcsp3 old-dist1 bridge investigation completed."
