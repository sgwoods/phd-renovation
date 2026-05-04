#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== Artifact validation =="
echo "This smoke test protects the thesis-result reproduction pipeline."

required_inputs=(
  "data/acl-experiments/Graph/ij2-ci.dat"
  "data/acl-experiments/Graph/ij3-ci.dat"
  "data/acl-experiments/Graph/ij4-ci.dat"
)

for path in "${required_inputs[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "Missing required artifact input: $path" >&2
    exit 1
  fi
done

MPL_TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/phd-renovation-mpl.XXXXXX")"
trap 'rm -rf "$MPL_TMP_DIR"' EXIT
export MPLCONFIGDIR="$MPL_TMP_DIR"

full_regen_inputs=(
  "Q-Batch-SBCL/ij2"
  "Q-Batch-SBCL/ij3"
  "qcsp3/ADT-Batch"
  "Q-Batch-SBCL/alex-ij2"
  "Q-Batch-SBCL/alex-ij3"
  "Q-Batch-SBCL/alex-ij4"
  "Q-Batch-SBCL/may29-ij2"
  "Q-Batch-SBCL/may29-ij3"
  "Q-Batch-SBCL/may29-ij4"
)

full_regen_mode=1
for path in "${full_regen_inputs[@]}"; do
  if [[ ! -e "$path" ]]; then
    full_regen_mode=0
    break
  fi
done

if [[ "$full_regen_mode" -eq 1 ]]; then
  echo "Mode: full regeneration from preserved experiment run trees."
  python3 Q-Batch-SBCL/Graph/extract-data.py
  python3 Q-Batch-SBCL/Graph/compare-all-overlay.py
  python3 Q-Batch-SBCL/Graph/compare-plots.py
else
  echo "Mode: fresh-clone portability fallback."
  echo "Ignored run-tree caches are absent, so this check validates the tracked graph tables and tracked overlay/report artifacts instead of re-extracting them."
fi

python3 tests/validate-thesis-comparison.py

required_outputs=(
  "Q-Batch-SBCL/Graph/ij2-ci.dat"
  "Q-Batch-SBCL/Graph/ij3-ci.dat"
  "Q-Batch-SBCL/Graph/ij4-ci.dat"
  "Q-Batch-SBCL/Graph/compare-ij2-overlay.png"
  "Q-Batch-SBCL/Graph/compare-ij3-overlay.png"
  "Q-Batch-SBCL/Graph/compare-ij4-overlay.png"
  "Q-Batch-SBCL/Graph/compare-all-overlay.png"
  "Q-Batch-SBCL/Graph/compare-ij2-ci.pdf"
  "Q-Batch-SBCL/Graph/compare-ij3-ci.pdf"
  "Q-Batch-SBCL/Graph/compare-ij4-ci.pdf"
  "Q-Batch-SBCL/Graph/compare-all.pdf"
)

for path in "${required_outputs[@]}"; do
  if [[ ! -s "$path" ]]; then
    echo "Expected artifact output missing or empty: $path" >&2
    exit 1
  fi
done

for path in \
  "Q-Batch-SBCL/Graph/ij2-ci.dat" \
  "Q-Batch-SBCL/Graph/ij3-ci.dat" \
  "Q-Batch-SBCL/Graph/ij4-ci.dat"
do
  line_count="$(wc -l < "$path")"
  if [[ "$line_count" -ne 20 ]]; then
    echo "Unexpected CI row count in $path: got $line_count, expected 20" >&2
    exit 1
  fi
done

echo "Artifact validation passed."
