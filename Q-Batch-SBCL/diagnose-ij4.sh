#!/bin/bash
# diagnose-ij4.sh -- Run a single ADT experiment at noise=500 on qcsp3, alex,
#                     and may29 to confirm the domain-size / TCC divergence.
#
# Usage: bash Q-Batch-SBCL/diagnose-ij4.sh
# Must be run from the project root directory.
#
# Output files go to /tmp/diagnose-ij4/ (not committed).

set -e

OUTDIR="/tmp/diagnose-ij4"
mkdir -p "$OUTDIR"
NOISE=500

echo "=== diagnose-ij4: noise=$NOISE, seed=default ==="
echo "Output dir: $OUTDIR"
echo ""

# Generate temp Lisp files (--eval can't reference packages created at load time).
# Use output-file t to write to stdout (avoids path-mangling differences between systems).

printf '%s\n' \
  '(load "Q-Batch-SBCL/bootstrap.lisp")' \
  '(qcsp3:adt :situation-id "quilici-i1"' \
  '           :sit-noise 500' \
  '           :template-id "quilici-t1"' \
  '           :forward-checking t' \
  '           :dynamic-rearrangement t' \
  '           :advance-sort t' \
  '           :single-line-override t' \
  '           :random-ident "default"' \
  '           :output-file t)' \
  '(sb-ext:exit)' \
  > "$OUTDIR/run-qcsp3.lisp"

printf '%s\n' \
  '(load "Q-Batch-SBCL/bootstrap-may29.lisp")' \
  '(qcsp-may29:adt :situation-id "q-i1"' \
  '                :sit-noise 500' \
  '                :template-id "quilici-t1"' \
  '                :forward-checking t' \
  '                :dynamic-rearrangement t' \
  '                :advance-sort t' \
  '                :single-line-override t' \
  '                :random-ident "default"' \
  '                :output-file t)' \
  '(sb-ext:exit)' \
  > "$OUTDIR/run-may29.lisp"

printf '%s\n' \
  '(load "Q-Batch-SBCL/bootstrap-alex.lisp")' \
  '(qcsp-alex:adt :situation-id "quilici-i1"' \
  '               :sit-noise 500' \
  '               :template-id "quilici-t1"' \
  '               :forward-checking t' \
  '               :dynamic-rearrangement t' \
  '               :advance-sort t' \
  '               :single-line-override t' \
  '               :random-ident "default"' \
  '               :output-file t)' \
  '(sb-ext:exit)' \
  > "$OUTDIR/run-alex.lisp"

# --- qcsp3 ---
echo "--- Running qcsp3 ---"
sbcl --non-interactive --load "$OUTDIR/run-qcsp3.lisp" \
     > "$OUTDIR/qcsp3-console.log" 2>&1
echo "    done"

# --- may29 ---
echo "--- Running may29 ---"
sbcl --non-interactive --load "$OUTDIR/run-may29.lisp" \
     > "$OUTDIR/may29-console.log" 2>&1
echo "    done"

# --- alex ---
echo "--- Running alex ---"
sbcl --non-interactive --load "$OUTDIR/run-alex.lisp" \
     > "$OUTDIR/alex-console.log" 2>&1
echo "    done"

echo ""
echo "=== Results (noise=$NOISE, seed=default, FC+DR+advance-sort) ==="
echo ""

# Single-line output format (fields are whitespace-separated):
#   1: noise
#   2-6: mode (bt/ T/ NIL/ T/ T)  -- 5 tokens with slashes
#   7: seed
#   8: avg-domain-size
#   9: NCC
#  10: TCC
#  11-12: BT / Visited  (e.g. "11 / 12")
#
# Extract the data line from console output (contains "bt/" pattern).
# The may29 console also has a WARNING line; we skip it.

printf "%-8s  %12s  %6s  %8s  %6s  %s\n" "System" "DomainSize" "NCC" "TCC" "BT" "Visited"
printf "%-8s  %12s  %6s  %8s  %6s  %s\n" "------" "----------" "---" "---" "--" "-------"

for sys in qcsp3 may29 alex; do
    logfile="$OUTDIR/$sys-console.log"
    if [ ! -f "$logfile" ]; then
        printf "%-8s  %s\n" "$sys" "(no console log)"
        continue
    fi
    # Extract the single-line output (contains "bt/" which is the search mode marker)
    line=$(grep "bt/" "$logfile" | head -1)
    if [ -z "$line" ]; then
        printf "%-8s  %s\n" "$sys" "(no data line found)"
        continue
    fi
    # Parse fields: $1=noise $2=bt/ $3=T/ $4=NIL/ $5=T/ $6=T $7=seed
    #   $8=dsize $9=NCC $10=TCC $11=BT $12=/ $13=Visited
    dsize=$(echo "$line" | awk '{print $8}')
    ncc=$(echo "$line" | awk '{print $9}')
    tcc=$(echo "$line" | awk '{print $10}')
    bt=$(echo "$line" | awk '{print $11}')
    visited=$(echo "$line" | awk '{print $13}')
    printf "%-8s  %12s  %6s  %8s  %6s  %s\n" "$sys" "$dsize" "$ncc" "$tcc" "$bt" "$visited"
done

echo ""
echo "=== Interpretation ==="
echo ""
echo "If alex shows ~1.5x larger domains, ~4x more backtracks, and ~6-8x higher"
echo "TCC than qcsp3/may29, the root cause is confirmed: simplified ts-matches-type"
echo "in alex adt-simple.lisp (line 1296) skips detailed type-matching during node"
echo "consistency, allowing more domain values to survive."
echo ""
echo "See: qcsp-alex-sep16-1997/adt-simple.lisp:1312"
echo "     \"Modified here (commented all the following)\""
echo ""
echo "Full console logs: $OUTDIR/*-console.log"
