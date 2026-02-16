# Project: PhD Legacy Lisp Renovation (ACL to SBCL)
## Environment
- OS: macOS (M4 ARM64)
- Compiler: SBCL (Steel Bank Common Lisp)
- Entry Point: `src/main.lisp` (to be created)

## Renovation Rules
- Convert `.cl` to `.lisp`.
- Replace `excl:*` (Allegro) with `uiop:*` or `sb-ext:*`.
- Modernize `defsystem` to `ASDF`.
- Use `FiveAM` for all test suites.

## Build/Test Commands
- Build: `sbcl --load "renovate.lisp"`
- Test: `sbcl --non-interactive --load "tests/run.lisp"`