# CSP Batch Experiments (1993-1994)

Earliest batch experiments for the base MOTORS CSP solver, predating the
memory-CSP and Quilici search extensions. Moved from `csp/Batch/`.

## Structure

| Directory | Files | Description |
|-----------|------:|-------------|
| T1/ | 8 | Test series 1 — BT with Forward Checking |
| T2/ | 8 | Test series 2 — BT only |
| T3/ | 8 | Test series 3 — BackJumping |
| T4/ | 11 | Test series 4 — BackMarking |
| T5/ | 10 | Test series 5 — AC-3 + BT with FC/DR |
| T6/ | 60 | Test series 6 — Extended experiments |
| T6-old/ | 33 | Earlier version of T6 experiments |
| Sample/ | 6 | Sample experiment configurations |
| Graphical/ | 6 | Gnuplot data and PostScript output |

Each T-directory contains `.lisp` experiment scripts, `.out` console output,
and `.sh` shell runners.

## Provenance

From the original CSP solver on the SPARC workstation. The T1-T6 naming
corresponds to the 8 cases described in the DREV memorandum (Aug 1993).
See also `data/csp-save-results/` for the summarized results from these runs.

The preserved archive is uneven in ways that appear historical rather than
accidental: `T1` has a denser summary file than `T2`/`T3`, `T4` and `T5`
summary files are stubs, and the `t6-*.out` files in `data/csp-save-results/`
include a few row-count anomalies. `tests/validate-csp-batch.sh` treats those
quirks as part of the archive contract instead of trying to normalize them away.
