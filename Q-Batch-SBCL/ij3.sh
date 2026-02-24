#!/bin/bash
# ij3.sh -- Run all ij3 experiments (memory-search + FC/DR/advance-sort)
# Usage: bash Q-Batch-SBCL/ij3.sh
# Must be run from project root directory.

set -e

echo "=== ij3: memory-search + FC/DR/advance-sort (20 noise levels x 10 seeds) ==="
echo "Start: $(date)"

for noise in 050 100 150 200 250 300 350 400 450 500 \
             550 600 650 700 750 800 850 900 950 1000; do
    echo "--- ij3-${noise} ---"
    sbcl --non-interactive --load "Q-Batch-SBCL/ij3-${noise}.lisp" \
         > "Q-Batch-SBCL/ij3-${noise}.out" 2>&1
    echo "    done (exit $?)"
done

echo "=== ij3 complete: $(date) ==="
