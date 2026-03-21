# Manual Helpers

This file explains the repo-root helper scripts that are still useful but are
not the primary supported workflow.

Use this when you are looking at the top-level `.lisp` files and want to know
which ones are historical/manual helpers versus which ones define the mainline
operator path.

## Supported Mainline Alternatives

If your goal is one of these tasks, prefer the supported mainline entry points:

| Task | Preferred path |
|---|---|
| Interactive solver use | `sbcl --load "src/main.lisp"` |
| Full confidence check | `tests/run.lisp` plus the `tests/validate-*.sh` spine |
| AO baseline validation | `tests/ao-run.lisp` / `tests/validate-ao.sh` |
| Thesis experiment replication | `Q-Batch-SBCL/` |

## Root Helper Scripts

### `run-test4.lisp`

Manual qcsp3 AO loader and runner for the legacy `test4` harness.

Use it when:

- you want to see the historical manual AO flow,
- you want the printed manual harness output,
- or you are comparing the manual path against the asserted AO baseline.

Preferred supported counterpart:

- `tests/ao-run.lisp`
- `tests/validate-ao.sh`

### `run-test4-may29.lisp`

Manual AO harness for the `qcsp-may29-1996` snapshot.

Use it for manual/historical comparison work, not as the main confidence gate.

### `run-test4-alex.lisp`

Manual AO harness for the alex snapshot.

This one is especially historical in flavor because alex reuses AO support from
`qcsp3/extras/` rather than carrying a self-contained AO tree of its own.

### `run-csp-tests.lisp`

Manual loader that runs a small base-snapshot smoke pass in `csp/`.

Useful for:

- quick manual comparison against the older base snapshot,
- historical orientation,
- checking the older loader style.

Preferred supported counterpart:

- `tests/run.lisp`

### `renovate.lisp`

Minimal bootstrap loader for `:phd-research`.

Useful for:

- historical renovation/bootstrap context,
- loading the earliest maintained solver line directly.

Preferred interactive counterpart:

- `src/main.lisp`

## Rule Of Thumb

These root helpers are worth keeping because they preserve historical usage and
manual comparison paths.

They are not the repo's primary operator surface.

If you are choosing where to start today:

1. use `src/main.lisp` for interactive work,
2. use `tests/` for confidence,
3. use `Q-Batch-SBCL/` for experiments,
4. use the root helpers only when you specifically want the historical/manual
   path.
