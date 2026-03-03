#!/bin/bash
# ij4.sh -- Run all ij4 experiments (direct adt + FC/DR/advance-sort)
# Usage: bash Q-Batch-SBCL/ij4.sh
# Must be run from project root directory.

set -e

echo "=== ij4: direct adt + FC/DR/advance-sort (5 groups) ==="
echo "Start: $(date)"

for group in 1 2 3 4 5; do
    echo "--- ij4-${group} ---"
    sbcl --non-interactive --load "Q-Batch-SBCL/ij4-${group}.lisp" \
         > "Q-Batch-SBCL/ij4-${group}.out" 2>&1
    echo "    done (exit $?)"
done

echo "=== ij4 complete: $(date) ==="
