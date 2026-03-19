#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== AO smoke validation =="
echo "This protects the legacy test4 runners without claiming full regression coverage."

run_and_check() {
  local name="$1"
  local script="$2"
  local out
  out="$(mktemp "${TMPDIR:-/tmp}/phd-renovation-ao.${name}.XXXXXX")"
  trap 'rm -f "$out"' RETURN

  sbcl --non-interactive --load "$script" >"$out" 2>&1

  case "$name" in
    qcsp3)
      grep -F "AO-ac3 (Step) Run Completed.  Constraint checks =   < 211 >" "$out" >/dev/null
      grep -F "AO-ac3 (Aggr) Run Completed.  Constraint checks =   < 35 >" "$out" >/dev/null
      grep -F "AO-ac-new (Step) Run Completed.  Constraint checks =   < 35 >" "$out" >/dev/null
      grep -F "AO-ac-new (Aggr) Run Completed.  Constraint checks =   < 35 >" "$out" >/dev/null
      grep -F ";; ===== All test4 tests completed. =====" "$out" >/dev/null
      ;;
    may29)
      grep -F "AO-ac3 (Step) Run Completed.  Constraint checks =   < 211 >" "$out" >/dev/null
      grep -F "AO-ac3 (Aggr) Run Completed.  Constraint checks =   < 35 >" "$out" >/dev/null
      grep -F "AO-ac-new (Step) Run Completed.  Constraint checks =   < 35 >" "$out" >/dev/null
      grep -F "AO-ac-new (Aggr) Run Completed.  Constraint checks =   < 35 >" "$out" >/dev/null
      grep -F ";; ===== All test4 tests completed (qcsp-may29-1996). =====" "$out" >/dev/null
      ;;
    alex)
      grep -F ";; testao1: AO-revise V1->V2" "$out" >/dev/null
      grep -F ";; testao2: AO-revise V0->V1" "$out" >/dev/null
      grep -F ";; testao3: AO-revise V2->V0" "$out" >/dev/null
      grep -F ";; ===== All test4 tests completed (qcsp-alex-sep16-1997). =====" "$out" >/dev/null
      ;;
  esac

  rm -f "$out"
  trap - RETURN
  echo "AO smoke passed: $name"
}

run_and_check "qcsp3" "run-test4.lisp"
run_and_check "may29" "run-test4-may29.lisp"
run_and_check "alex" "run-test4-alex.lisp"

echo "AO smoke validation passed."
