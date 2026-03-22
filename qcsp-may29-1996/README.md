# qcsp-may29-1996

May 29, 1996 snapshot of the QCSP solver. Extends the base CSP solver (csp/)
with memory-based constraint solving, ADT/MPR domains, Quilici's
constraint-ordered search, and arc-oriented (AO) constraint propagation.

Loaded via ASDF system `:qcsp-may29-1996` (defined in
`qcsp-may29-1996.asd` at the repository root).

This snapshot root mixes three kinds of material:

- source files that define the May 1996 solver snapshot,
- runtime-generated ADT/MPR working data, and
- preserved historical batch/result trees kept in place for provenance.

## Core ASDF files (13)

| File | Role |
|------|------|
| `package.lisp` | Package definition (`:phd-qcsp-may29`) |
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
| `artifacts/` | 2 historical text files (Q-Test-Interpretation, Q-Test-Results from Dec 1995) |
| `ADT-Batch/` | 9 ADT batch experiment results |
| `ADT-Random/` | Generated seed files (gitignored, regenerable) |
| `ADT-Situation/` | Generated ADT situations (gitignored) — 203 Sit-q-i1, 185 Sit-q-i2, 180 Sit-h-i2 |
| `ADT-SituationMar96/` | Older March 1996 ADT situations (.gz compressed) |
| `Keep/` | Archival — contains original `unify.lisp` (recovered to `csp/`) |
| `MPR-Random/` | Generated MPR seed files (gitignored) |
| `MPR-Situation/` | Generated MPR situations (gitignored) |
| `New-Batch/` | 756 batch experiment results |
| `NewData4a-Batch/` | 209 batch experiment results |
| `NewData4b-Batch/` | 313 batch experiment results for the preserved `ff1` / `ff2` / `ff3` family (see `NewData4b-Batch/README.md`) |
| `NewData5-Batch/` | 304 batch experiment results |
| `NewData6-Batch/` | 324 batch experiment results |
| `Q-Batch/` | 676 reviewed duplicate of `data/acl-experiments/`, preserved here for snapshot integrity |
| `Q-Batch-Freeze/` | 416 frozen Q-solver batch results |

## AO (arc-oriented) files in extras/

The `extras/` directory contains the arc-oriented constraint propagation
implementation, loaded by `run-test4-may29.lisp` for integration testing:

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

Local guide:

- `extras/README.md`

Working-state data guides:

- `ADT-Random/README.md`
- `ADT-Situation/README.md`
- `ADT-SituationMar96/README.md`
- `MPR-Random/README.md`
- `MPR-Situation/README.md`
