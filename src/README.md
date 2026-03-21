# src

This directory contains the modern interactive entry point for the renovated
project.

## Purpose

`src/main.lisp` is the supported "load the solver and start exploring"
workflow.

Use it when you want:

- a REPL with the primary integrated solver line loaded,
- the working directory set up for ADT and MPR runs,
- and the common `qcsp3:` entry points ready to call interactively.

## Supported Load Path

From the repository root:

```bash
sbcl --load "src/main.lisp"
```

That path:

1. registers the repo with ASDF,
2. loads `:qcsp3`,
3. points the default working directory at `qcsp3/`,
4. ensures the runtime ADT directories exist, and
5. leaves you at a REPL with the main interactive commands available.

## What This Is Not

- It is not the full validation spine. For that, use `tests/`.
- It is not the batch experiment workspace. For that, use `Q-Batch-SBCL/`.
- It is not how the historical comparison snapshots are normally loaded for
  regression coverage; those are exercised through the test suites.

## Typical Next Commands

After loading:

- `(qcsp3:qc 4)` for 4-Queens
- `(qcsp3:cqc 4)` for confused queens
- `(qcsp3:adt)` for direct ADT matching
- `(qcsp3:mpr)` for MPR
- `(qcsp3:memory-search)` for the two-phase memory-based path

## Relationship To The Repo

If `qcsp3/` is the main solver line and `tests/` is the validation gate,
`src/` is the simplest supported operator entry point.
