# CSP ADT Batch Experiments (1994-1995)

ADT (Abstract Data Type) domain batch experiments for the base CSP solver.
Moved from `csp/ADT-Batch/`.

## Structure

| Directory | Files | Description |
|-----------|------:|-------------|
| ij1/ | 201 | BT-only baseline for ADT recognition |
| ij2/ | 201 | FCDR search for ADT recognition |
| ij3/ | 200 | AC-3 + BT for ADT recognition |
| ij4/ | 200 | AC-3 + FCDR for ADT recognition |
| Graphical/ | ~60 | Gnuplot scripts, data files, PostScript plots |

Top-level files include experiment scripts (ij\*.lisp), console output
(ij\*.out), and shell runners (ij\*.sh).

## Experiment Series

These are the earliest ADT experiments using the base CSP solver, before
the memory-CSP two-phase approach was developed. The ij1-ij4 naming here
refers to different search strategies applied to the same ADT domain:

1. **ij1** -- Backtracking only
2. **ij2** -- FCDR (Forward Checking with Dynamic Rearrangement)
3. **ij3** -- AC-3 preprocessing + Backtracking
4. **ij4** -- AC-3 preprocessing + FCDR

## Result File Format

Same whitespace-separated column format as `data/acl-experiments/`.
Each file contains one line per experiment run with TCC, NCC, BT, and
timing metrics.

## Note

The ij1-ij4 naming in this directory is NOT the same as the ij2/ij3/ij4
series in `data/acl-experiments/`. The ACL experiments (Q-Batch) use the
later memory-CSP methodology, while these use direct CSP search.

The preserved `Graphical/*.ci` summaries are historically uneven: `ij1`
keeps CC points through 500 statements but SEC points only through 450, and
`ij3` stops at 950. `tests/validate-adt-batch.sh` treats those truncations as
part of the preserved archive contract rather than as missing modern data.

## Integration Bridge

This family is now the **next deliberate post-M1 integration target**.

That does not mean it is already rerunnable through `qcsp3/`.
It means the repo now treats this preserved archive as the next bridge between
an integrity-checkable historical family and a future integrated executable
workflow.

The current bridge note lives in:

- `ADT-BATCH-INTEGRATION.md`
