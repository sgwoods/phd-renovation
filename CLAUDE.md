# Project: PhD Legacy Lisp Renovation (ACL to SBCL)

## Environment
- OS: macOS (M4 ARM64)
- Compiler: SBCL (Steel Bank Common Lisp)
- Entry Point: `src/main.lisp` (loads `:qcsp3` and drops into REPL)

## ASDF Systems
- `:phd-research` — base CSP solver (`csp/`, 9 source files)
- `:qcsp3` — extended solver with memory-CSP (`qcsp3/`, 13 source files)
- `:qcsp-may29-1996` — historical snapshot (`qcsp-may29-1996/`)
- `:qcsp-alex-sep16-1997` — historical snapshot (`qcsp-alex-sep16-1997/`)

## Build/Test Commands
- REPL: `sbcl --load "src/main.lisp"`
- Build (csp only): `sbcl --load "renovate.lisp"`
- FiveAM tests (all 4 systems): `sbcl --non-interactive --load "tests/run.lisp"`
- Integration tests: `sbcl --non-interactive --load "run-test4.lisp"`
- Experiments: `bash Q-Batch-SBCL/ij2.sh` (also ij3.sh, ij4.sh)

## Renovation Rules
- Convert `.cl` to `.lisp`
- Replace `excl:*` (Allegro) with `uiop:*` or `sb-ext:*`
- Modernize `defsystem` to ASDF
- Use FiveAM for all test suites
- Keep all changes within the project directory
