# qcsp3

Primary extended QCSP solver. Extends the base CSP solver (csp/) with
memory-based constraint solving, ADT/MPR domains, GSAT local search,
and Quilici's constraint-ordered search. This is the main system used
for experiments.

Loaded via ASDF system `:qcsp3` (defined in `qcsp3.asd` at the
repository root).

## Core ASDF files (13)

| File | Role |
|------|------|
| `package.lisp` | Package definition (`:phd-qcsp3`) |
| `bm.lisp` | BackMark search |
| `bt.lisp` | BackTrack search |
| `ct.lisp` | Constraint Techniques (AC-3) |
| `gsat.lisp` | GSAT local search |
| `utility.lisp` | Global state, utilities |
| `queens.lisp` | N-Queens domain |
| `mpr-simple.lisp` | MPR functionality |
| `mpr-setup.lisp` | MPR template/situation data |
| `quilici-search.lisp` | Constraint-ordered search |
| `adt-simple.lisp` | ADT functionality |
| `adt-setup.lisp` | ADT template/situation data |
| `memory-csp.lisp` | Memory-based CSP (index + resolution) |

## Subdirectories

| Directory | Contents |
|-----------|----------|
| `extras/` | 13 non-ASDF .lisp files — AO (arc-oriented) solver variants and test4 integration suite |
| `ADT-Batch/` | Generated ij4 experiment results (gitignored) |
| `ADT-Random/` | Generated seed files (gitignored) |
| `ADT-Situation/` | Generated ADT situations (gitignored) — Sit-quilici-i1-* |
| `MPR-Random/` | Generated MPR seed files (gitignored) |
| `MPR-Situation/` | Generated MPR situations (gitignored) |

## AO (arc-oriented) files in extras/

The `extras/` directory contains the arc-oriented constraint propagation
implementation, loaded by `run-test4.lisp` for integration testing.
Also used by `run-test4-alex.lisp` (alex lacks its own AO files).

| File | Role |
|------|------|
| `comment.lisp` | Comment/debug output functions |
| `compile-ao.lisp` | AO compilation flags |
| `ac-graph.lisp` | Arc consistency graph |
| `hierarchy.lisp` | Variable/constraint ordering hierarchy |
| `ao-ac3.lisp` | AO arc consistency (AC-3 variant) |
| `ao-ac-new.lisp` | AO arc consistency (new variant) |
| `ao-revise-fns.lisp` | AO revise helper functions |
| `ao-revise.lisp` | AO revise (stub) |
| `ao-revise-step.lisp` | AO revise step-by-step |
| `ao-revise-aggressive.lisp` | AO revise aggressive |
| `applyr.lisp` | Apply-reduce constraint propagation |
| `example-extend.lisp` | Extended example data for AO tests |
| `test4.lisp` | Test4 integration suite definitions |
