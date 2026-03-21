#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ff provenance validation =="
echo "This integrity check protects the preserved NewData4b -> PrevResults carry-forward."

graph_dir="qcsp-may29-1996/NewData4b-Batch/Graph"
prev_dir="data/sparc-archive/PrevResults"
count_dir="qcsp-may29-1996/NewData4b-Batch/Count"
orig_dir="qcsp-may29-1996/NewData4b-Batch/Graph/Orig"

required_paths=(
  "$graph_dir/ff1.ci"
  "$graph_dir/ff2.ci"
  "$graph_dir/ff3.ci"
  "$graph_dir/ff1.all"
  "$graph_dir/ff2.all"
  "$graph_dir/ff3.all"
  "$graph_dir/ff1.avg"
  "$graph_dir/ff2.avg"
  "$graph_dir/ff3.avg"
  "$orig_dir/ff1.raw"
  "$orig_dir/ff2.raw"
  "$orig_dir/ff3.raw"
  "$orig_dir/ff1.raw2"
  "$orig_dir/ff2.raw2"
  "$orig_dir/ff3.raw2"
  "$orig_dir/grab-avg"
  "$orig_dir/grab-ci"
)

for path in "${required_paths[@]}"; do
  if [[ ! -s "$path" ]]; then
    echo "Missing required ff provenance artifact: $path" >&2
    exit 1
  fi
done

for stem in ff1 ff2 ff3; do
  for suffix in ci all avg; do
    src="$graph_dir/$stem.$suffix"
    dst="$prev_dir/$stem.$suffix"
    if [[ ! -s "$dst" ]]; then
      echo "Missing PrevResults carry-forward artifact: $dst" >&2
      exit 1
    fi
    if ! cmp -s "$src" "$dst"; then
      echo "Carry-forward mismatch: $src != $dst" >&2
      exit 1
    fi
  done
done

for dist in 1 2 3; do
  count="$(find "$count_dir" -maxdepth 1 -type f -name "fcdr-dist${dist}-*" | wc -l | tr -d ' ')"
  if [[ "$count" -ne 70 ]]; then
    echo "Unexpected count-file total for dist${dist}: got $count, expected 70" >&2
    exit 1
  fi
done

echo "ff provenance validation passed."
