# Validation Matrix

This file tracks the historical domains and result families that matter to the
project's primary goal:

1. validate the integrated solver against the PhD-reported results,
2. validate it against other historically reported domains/results, and
3. converge on one gold-standard code line that can cover that validated scope.

`qcsp3/` is currently the leading candidate for that gold-standard line, but it
has not yet earned that status across the full historical surface.

## Status Key

- `Executable now`: we have a supported runnable validation path today.
- `Integrity-checkable now`: the preserved artifacts can be checked or compared
  reliably, even if we do not yet have a clean modern rerun path.
- `Provenance-only for now`: the family is historically meaningful, but the
  executable or integrity story is not yet strong enough.

## Current Matrix

| Domain / result family | Historical source | Current validation status | Current executable/check path | Gold-standard target status |
|---|---|---|---|---|
| Core queens regressions | `csp/`, `qcsp3/`, `qcsp-may29-1996/`, `qcsp-alex-sep16-1997/` | Executable now | `tests/run.lisp` | Covered as reference baseline; should remain covered in the integrated line |
| Confused queens metrics | same four snapshots | Executable now | `tests/run.lisp` | Covered as deterministic regression anchor |
| AO / `test4` baseline | root `run-test4*.lisp`, snapshot extras | Executable now | `tests/ao-run.lisp`, `tests/validate-ao.sh` | Partially covered; broader AO scope still open |
| PhD `ij2` / `ij3` / `ij4` reported trend story | `data/acl-experiments/Graph/`, thesis plots, SBCL reruns | Executable now | `tests/validate-artifacts.sh`, `tests/validate-thesis-comparison.py`, `Q-Batch-SBCL/` | Covered for the current supported baseline; central gate for the integrated line |
| Older `ff1` / `ff2` / `ff3` FCDR distribution family | `qcsp-may29-1996/NewData4b-Batch/`, `data/sparc-archive/PrevResults/` | Integrity-checkable now | `tests/validate-ff-provenance.sh` | Not yet covered by the integrated line |
| Early `exp-1` / `exp-2` / `exp-3` result families | `historical finds/yj-sun/Csp/testdata/Results/`, `data/sparc-archive/PrevResults/` | Integrity-checkable now | Crosswalk documented in `historical finds/yj-sun/Csp/RESULTS-CROSSWALK.md` | Not yet covered by the integrated line |
| ADT batch archives (`ij1`-`ij4` era before SBCL replication) | `data/csp-adt-batch/`, snapshot batch trees | Provenance-only for now | Preserved data present, but no supported modern validation path | Open |
| Earliest CSP batch families (`T1`-`T6`) | `data/csp-batch/` | Provenance-only for now | Preserved data present | Open |
| MPR domain behavior | source snapshots and runtime-generated situation/random files | Executable now at solver level | `tests/run.lisp` MPR assertions | Covered at regression level, but not yet tied to a broader historical result family |
| Alex-specific DFA-related ADT behavior | `qcsp-alex-sep16-1997/` | Provenance-only for now | Diagnosed but not yet part of supported validation | Open research/integration item |
| QCSP-nov96 terrain domain | `data/lost-datasets.md`, `QCSP-nov96.dir` | Provenance-only for now | Lost source/data; no runnable path | Blocked by missing artifacts |

## Immediate Priorities

1. Keep the currently executable PhD-result path green.
2. Finish shrinking the remaining warning tail so the validation spine stays a
   high-signal merge gate.
3. Define the first explicit `qcsp3/` integration milestone for the
   gold-standard path: PhD baseline, AO baseline, and documented coverage or
   relationship for the preserved `ff*` family.
4. Keep moving families from `Provenance-only` to `Integrity-checkable` or
   `Executable now`.
