# qcsp-alex-sep16-1997 MyBatch

Local guide to the Alex snapshot's preserved batch orchestration tree.

## Role

`qcsp-alex-sep16-1997/MyBatch/` is a preserved Allegro-era batch runner
workspace. It is not part of the supported modern validation spine, but it is
valuable for provenance because it preserves how large experiment families were
scripted under the Alex snapshot.

Use it as:

- a historical runner/orchestration archive,
- a clue to how thesis-era or near-thesis-era batch work was staged,
- and a reference when comparing the later maintained experiment workspace to
  preserved historical tooling.

## Current Shape

The tree has two main layers:

- `batch-0.lisp` through `batch-23.lisp`
- `old-batch/` with older `batch-exe-*`, `exp-*`, and `run-exp-*` drivers

There are also a few shell/helper files such as:

- `run-batch`
- `run-batch-yk`
- `one-more`

This mix strongly suggests a preserved execution/control surface rather than a
single coherent modern workflow.

## Relationship To Other Areas

This directory is related to, but not the same as:

- `Q-Batch-SBCL/` for the supported modern experiment workspace,
- `historical finds/yj-sun/Csp/` for related recovered orchestration/provenance
  material,
- `qcsp-alex-sep16-1997/testdata/` for the preserved result/data side of the
  Alex snapshot.

## Supported Status

`MyBatch/` is currently treated as:

- preserved historical tooling,
- useful for provenance and reconstruction,
- but not part of the supported current build or validation gate.

The repo does **not** currently claim that these batch drivers can be rerun
cleanly on the maintained modern path.

## What This Directory Is Good For

This tree is especially useful for:

- understanding how experiment families were chunked,
- identifying old experiment naming conventions,
- tracing possible generator/runner lineage for preserved result trees,
- and supporting archive interpretation work.

## What This Directory Is Not

- It is not the canonical active experiment workspace.
- It is not the source of truth for supported current CI checks.
- It is not a maintained operator-facing workflow for day-to-day use.

## Rule Of Thumb

If the task is about preserved Alex-era batch orchestration, use this
directory.

If the task is about running supported experiments today, use `Q-Batch-SBCL/`
instead.
