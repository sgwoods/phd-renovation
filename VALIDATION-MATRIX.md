# Validation Matrix

This file tracks the historical domains and result families that matter to the
project's primary goal:

1. validate the integrated solver against the PhD-reported results,
2. validate it against other historically reported domains/results, and
3. converge on one gold-standard code line that can cover that validated scope.

`qcsp3/` is currently the leading candidate for that gold-standard line. It has
now cleared Milestone M1, but it has not yet earned that status across the
full historical surface.

## First Integration Milestone

The first explicit gate for `qcsp3/` is:

**Milestone M1: integrated validated baseline**

To satisfy M1, `qcsp3/` must:

1. stay green across the current validation spine,
2. remain the default executable path for the supported PhD `ij2`/`ij3`/`ij4`
   story,
3. include the asserted AO baseline as part of the supported integrated line,
4. carry an explicit documented relationship to the preserved `ff*` family,
   even if that family is still integrity-checkable rather than rerunnable
   through `qcsp3/`, and
5. document any remaining meaningful deltas versus the historical snapshots.

This is the first practical step toward one gold-standard code line. M1 is now
accepted, but it is not the final "everything historical is unified" finish line.

The current delta ledger for this milestone lives in `INTEGRATION-DELTAS.md`.
The short gate summary for this milestone lives in `M1-READINESS.md`.

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
| AO / `test4` baseline | root `run-test4*.lisp`, snapshot extras | Executable now | `tests/ao-run.lisp`, `tests/validate-ao.sh` | In scope for M1; qcsp3 and May29 now assert AO cases 1-3 across the reduction families plus `test4s` / `test4a`, while alex keeps its revise baseline |
| PhD `ij2` / `ij3` / `ij4` reported trend story | `data/acl-experiments/Graph/`, thesis plots, SBCL reruns | Executable now | `tests/validate-artifacts.sh`, `tests/validate-thesis-comparison.py`, `Q-Batch-SBCL/` | In scope for M1; central gate for the integrated line |
| Older `ff1` / `ff2` / `ff3` FCDR distribution family | `qcsp-may29-1996/NewData4b-Batch/`, `data/sparc-archive/PrevResults/` | Integrity-checkable now | `tests/validate-ff-provenance.sh` | In scope for M1 as a documented integrity-checked family |
| Early `exp-1` / `exp-2` / `exp-3` result families | `historical finds/yj-sun/Csp/testdata/Results/`, `data/sparc-archive/PrevResults/` | Integrity-checkable now | Crosswalk documented in `historical finds/yj-sun/Csp/RESULTS-CROSSWALK.md` | Not yet covered by the integrated line |
| ADT batch archives (`ij1`-`ij4` era before SBCL replication) | `data/csp-adt-batch/`, snapshot batch trees | Integrity-checkable now | `tests/validate-adt-batch.sh` | Preserved archive family now checkable; not yet under the integrated executable line |
| Earliest CSP batch families (`T1`-`T6`) | `data/csp-batch/`, `data/csp-save-results/` | Integrity-checkable now | `tests/validate-csp-batch.sh` | Preserved DREV-era archive now checkable; still outside the integrated executable line |
| MPR domain behavior | source snapshots and runtime-generated situation/random files | Executable now at solver level | `tests/run.lisp` MPR assertions | Covered at regression level, but not yet tied to a broader historical result family |
| Alex-specific DFA-related ADT behavior | `qcsp-alex-sep16-1997/` | Provenance-only for now | Diagnosed but not yet part of supported validation | Open research/integration item |
| QCSP-nov96 terrain domain | `data/lost-datasets.md`, `QCSP-nov96.dir`, `Lacie1` recovery lead | Provenance-only for now | No runnable path yet; `Lacie1` reportedly contains terrain data and generator but remains unsorted | Recovery lead identified, still outside M1 |

## Immediate Priorities

1. Keep the currently executable PhD-result path green.
2. Use the current matrix to guide the post-M1 documentation and integration
   work rather than widening the supported umbrella casually.
3. Finish shrinking the remaining routine validation-log noise so the
   validation spine stays a high-signal merge gate.
4. Move the next clearly supported family or workflow only when it helps the
   post-M1 integrated line more than it increases maintenance surface.
