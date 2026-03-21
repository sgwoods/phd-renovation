# Integration Delta Ledger

This file records the remaining meaningful differences between `qcsp3/` and the
historical reference snapshots that matter for Milestone M1 and the eventual
gold-standard integrated solver line.

It is not a changelog of every historical quirk. It is the short list of
currently relevant deltas that future work should either:

1. accept and document,
2. reduce and validate, or
3. treat as an explicit blocker.

## How To Read This

- `Accept for M1`: documented and bounded; not a blocker for the first
  integrated validated baseline.
- `Reduce after M1`: real gap, but not a first-gate blocker once the boundary
  is explicit.
- `Blocker outside M1`: important, but outside the first integrated-baseline
  target because artifacts or coverage are still missing.

## Current Delta Table

| Delta area | `qcsp3/` position | Reference snapshot(s) | Why it matters | Current handling | M1 status |
|---|---|---|---|---|---|
| Supported PhD `ij2` / `ij3` / `ij4` baseline | `qcsp3/` is the default supported executable path | `csp/`, `qcsp-may29-1996/`, `qcsp-alex-sep16-1997/` | This is the central thesis-result story and the main modern validation gate. | CI regenerates the SBCL artifacts and checks ACL-vs-SBCL trend preservation through `tests/validate-artifacts.sh` and `tests/validate-thesis-comparison.py`. | Accept for M1 |
| Alex `ij4` divergence | `qcsp3/` and may29 track the supported direct-matching baseline; alex diverges sharply upward | `qcsp-alex-sep16-1997/` | This is the most visible solver-behavior difference among the maintained snapshots. | Root cause is documented: alex simplified `ts-matches-type`, likely expecting DFA-related options to compensate; `Q-Batch-SBCL/diagnose-ij4.sh` reproduces the effect. | Accept for M1, but keep documented |
| AO baseline breadth | `qcsp3/` has asserted AO coverage for the supported deterministic baseline | AO extras / `run-test4*.lisp` paths across snapshots | AO is part of the integrated story, but the full historical AO surface is broader than the current asserted case. | `tests/ao-run.lisp` and `tests/validate-ao.sh` now cover the supported case-1 graph reductions plus the legacy `test4s` / `test4a` wrappers; broader AO coverage remains explicitly open. | Reduce after M1 |
| `ff1` / `ff2` / `ff3` family | `qcsp3/` does not yet rerun this family directly | `qcsp-may29-1996/NewData4b-Batch/`, `data/sparc-archive/PrevResults/` | This family is historically important and explicitly in scope for M1. | The lineage and aggregation path are documented, and `tests/validate-ff-provenance.sh` integrity-checks the preserved carry-forward artifacts. | Accept for M1 as integrity-checked, not executable |
| Early `exp-1` / `exp-2` / `exp-3` families | not yet under the integrated executable umbrella | `historical finds/yj-sun/Csp/testdata/Results/`, `data/sparc-archive/PrevResults/` | These help explain earlier experiment/result layers, but they are not yet part of the supported modern rerun path. | Crosswalk documented in `historical finds/yj-sun/Csp/RESULTS-CROSSWALK.md`. | Reduce after M1 |
| ADT batch archives before the SBCL replication line | not yet under a modern executable path, but now structurally validated | `data/csp-adt-batch/`, historical batch trees | These likely contain useful historical coverage, but they are still archive-heavy and workflow-light. | `tests/validate-adt-batch.sh` now checks the preserved `ij1`-`ij4` raw grids and CI summary tables; the family is integrity-checkable rather than executable. | Reduce after M1 |
| Earliest CSP batch families (`T1`-`T6`) | not yet tied to the integrated executable line | `data/csp-batch/` | Historically meaningful, but currently outside the validated umbrella. | Preserved only. | Reduce after M1 |
| QCSP-nov96 terrain domain | missing from the runnable line, but with a new recovery lead | `QCSP-nov96.dir`, `data/lost-datasets.md`, `Lacie1` drive lead | This is the clearest missing historical domain, but source/data loss still prevents current integration. | Documented as outside M1, with `Lacie1` now recorded as the strongest recovery lead pending review. | Blocker outside M1 |
| Validation-log noise | `qcsp3/` baseline is now much quieter; the AO harness redefinition chatter is trimmed, leaving only small legacy leftovers like the alex `adt-setup` note | mostly alex setup and small historical harness leftovers | A noisy merge gate makes regressions harder to notice, even when behavior is correct. | The large alex/core STYLE-WARNING tail is cleared, and the AO/manual harness chatter has been reduced; what remains is mostly cosmetic but still worth trimming. | Reduce after M1 |

## What M1 Now Means In Practice

Milestone M1 is satisfied when:

1. `qcsp3/` remains the operational center of the supported thesis-result path,
2. the current validation spine stays green,
3. AO baseline support is asserted and honestly bounded,
4. the `ff*` family remains explicitly connected to the integrated line even if
   it is still integrity-check-only, and
5. the deltas above remain documented instead of being implicit lore.

So M1 does **not** mean "all historical families are unified already."
It means the repo has crossed from "best-supported candidate" to "first
explicitly integrated validated line."
