# csp Snapshot

This directory is the earliest solver root in the repository and backs the
`:phd-research` ASDF system.

## Role

`csp/` contains the base constraint-satisfaction solver plus the original
queens, ADT, and MPR domains. It is the simplest runnable snapshot and a useful
reference point when comparing later qcsp-era extensions.

## Important Files

- `package.lisp`: package definition and exports.
- `bm.lisp`, `bt.lisp`, `ct.lisp`: core search and consistency algorithms.
- `queens.lisp`: deterministic queens entry points used heavily in tests.
- `adt-simple.lisp`, `adt-setup.lisp`: ADT matching constraints and data.
- `mpr-simple.lisp`, `mpr-setup.lisp`: MPR matching constraints and data.
- `utility.lisp`: shared counters, reporting, and global-state handling.
- `unify.lisp`: recovered historical helper preserved for completeness.

## Historical Loader Files

- `load.lisp`
- `compile.lisp`
- `adt-test.lisp`

These are legacy ACL-era helper entry points retained for historical context.
The supported modern load path is the ASDF system, typically via
`src/main.lisp` or the regression suites under `tests/`.

## Working-State Data Areas

The base snapshot also carries a small amount of working-state domain data:

- `ADT-Random/README.md`
- `MPR-Random/README.md`
- `MPR-Situation/README.md`

This is the earliest and sparsest version of the random/situation scaffolding
that becomes more explicit in the later `qcsp-*` trees.
