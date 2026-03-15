# qcsp-alex-sep16-1997

Sep 16, 1997 snapshot of the QCSP solver — the final version used for thesis
experiments. Extends the base CSP solver (csp/) with memory-based constraint
solving, ADT/MPR domains, and Quilici's constraint-ordered search.

Loaded via ASDF system `:qcsp-alex-sep16-1997` (defined in
`qcsp-alex-sep16-1997.asd` at the repository root).

## Core ASDF files (13)

| File | Role |
|------|------|
| `package.lisp` | Package definition (`:phd-qcsp-alex`) |
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
| `extras/` | 34 non-core .lisp files — data pipelines, experiment runners, variant implementations, test scripts |
| `artifacts/` | 15 historical output files — .res results, PostScript, traces, dated backups |
| `testdata/` | 520 thesis-era experiment data files (subdirectories by experiment) |
| `MyBatch/` | 111 old Allegro CL batch scripts (includes `old-batch/`) |
| `SteveBkps/` | 1 backup (`bt.lisp` from Dec 1995) |
| `ADT-Random/` | Generated seed files (gitignored, regenerable via `gen-seeds-alex.lisp`) |
| `ADT-Situation/` | Generated ADT situations (gitignored) |
| `MPR-Random/` | MPR domain random data |
| `MPR-Situation/` | MPR domain situation data |
