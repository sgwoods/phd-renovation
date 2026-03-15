#!/bin/bash
# run-may29-all.sh -- Run ij2/ij3/ij4 batch experiments through the may29 codebase
#
# Usage: bash Q-Batch-SBCL/run-may29-all.sh
# Must be run from the project root directory.

set -e

mkdir -p Q-Batch-SBCL/may29-ij2 Q-Batch-SBCL/may29-ij3 Q-Batch-SBCL/may29-ij4

NOISE_LEVELS="50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000"

echo "===== May29 ij2 (memory-search baseline) ====="
for noise in $NOISE_LEVELS; do
  echo "--- ij2 noise=$noise ---"
  sbcl --non-interactive \
       --eval "(defvar *may29-noise* $noise)" \
       --load "Q-Batch-SBCL/may29-ij2-run.lisp" 2>&1 | grep -E "^;;|Evaluation took"
done

echo ""
echo "===== May29 ij3 (memory-search + FC/DR/advance-sort) ====="
for noise in $NOISE_LEVELS; do
  echo "--- ij3 noise=$noise ---"
  sbcl --non-interactive \
       --eval "(defvar *may29-noise* $noise)" \
       --load "Q-Batch-SBCL/may29-ij3-run.lisp" 2>&1 | grep -E "^;;|Evaluation took"
done

echo ""
echo "===== May29 ij4 (direct ADT + FC/DR/advance-sort) ====="
for noise in $NOISE_LEVELS; do
  echo "--- ij4 noise=$noise ---"
  sbcl --non-interactive \
       --eval "(defvar *may29-noise* $noise)" \
       --load "Q-Batch-SBCL/may29-ij4-run.lisp" 2>&1 | grep -E "^;;|Evaluation took"
done

echo ""
echo "===== All may29 experiments complete ====="
