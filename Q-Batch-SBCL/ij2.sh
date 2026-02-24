#!/bin/bash
# ij2.sh -- Run all ij2 experiments (memory-search baseline)
# Usage: bash Q-Batch-SBCL/ij2.sh
# Must be run from project root directory.

set -e

echo "=== ij2: memory-search baseline (20 noise levels x 10 seeds) ==="
echo "Start: $(date)"

for noise in 050 100 150 200 250 300 350 400 450 500 \
             550 600 650 700 750 800 850 900 950 1000; do
    echo "--- ij2-${noise} ---"
    sbcl --non-interactive --load "Q-Batch-SBCL/ij2-${noise}.lisp" \
         > "Q-Batch-SBCL/ij2-${noise}.out" 2>&1
    echo "    done (exit $?)"
done

echo "=== ij2 complete: $(date) ==="
