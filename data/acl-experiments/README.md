# ACL Experiment Results (1996)

This directory is the canonical preserved ACL/SPARC-era baseline for the
supported thesis-result validation path.

It contains the historical `ij2` / `ij3` / `ij4` experiment families used as
the reference side of the repo's modern ACL-vs-SBCL comparison checks.

## Why This Directory Matters

If the question is "what published result story does the repo actively
protect?", this directory is part of the answer.

The supported validation path:

1. regenerates SBCL `ij2` / `ij3` / `ij4` summaries in `Q-Batch-SBCL/Graph/`,
2. compares them against the preserved ACL baseline here,
3. and checks that the thesis-era trend story is still preserved.

That means this directory is not just archival context. It is one of the main
live reference baselines used by `tests/validate-artifacts.sh` and
`tests/validate-thesis-comparison.py`.

## Experiment Series

Three preserved experiment series compare CSP search strategies for program
understanding:

| Series | Method | Description |
|--------|--------|-------------|
| `ij2` | 2-phase Memory-CSP | Backtracking phase 1, FCDR phase 2 baseline |
| `ij3` | Memory-CSP + heuristics | Both phases use FC + dynamic rearrangement + advance sort |
| `ij4` | Direct ADT CSP | Direct constraint satisfaction with FC/DR/advance sort |

Each series tests 20 noise levels (`50`-`1000` in steps of `50`) with
10 random seeds per level, for 200 attempted data points per series.

## Structure

```text
acl-experiments/
├── ij2/            raw ACL result files
├── ij3/            raw ACL result files
├── ij4/            raw ACL result files
├── Graph/          preserved graph data, gnuplot scripts, PostScript plots
├── ij*.lisp        ACL-era experiment definition scripts
├── ij*.out         console output logs
└── ij*.sh          ACL-era shell runner scripts
```

## Canonical vs Preserved Duplicate

This is the canonical active copy of the ACL baseline.

`qcsp-may29-1996/Q-Batch/` is a reviewed duplicate retained only for snapshot
integrity. The supported modern validation path should read from
`data/acl-experiments/`, not from the embedded May29 duplicate.

## Result File Shape

Each raw result file (for example `ij2/ij2-250.3`) is a whitespace-separated
single-line summary. Important fields include:

- `Size`: noise level
- `Dsize`: average domain size
- `NCC`: node consistency checks
- `TCC`: total constraint checks
- `BT/V`: backtracks / nodes visited

The raw ACL files are historical artifacts; the supported modern comparison
path does not require every raw file to be perfect or complete. It uses the
preserved graph summaries and shared noise-level overlap to validate the thesis
story responsibly.

## Graph Layer

`Graph/` contains the preserved ACL analysis layer:

- `ij*-ci.dat`: confidence interval tables
- `ij*-raw.*`: older aggregated raw summaries
- `*.gp`: gnuplot scripts
- `*.ps`: PostScript output
- `Makefile`, `Bad/`, `Heuristic-Errs/`, `Util/`: historical support material

This preserved graph layer is the ACL side of the modern comparison against
`Q-Batch-SBCL/Graph/`.

## Relationship To The Modern SBCL Workspace

The modern experiment workspace lives in `Q-Batch-SBCL/`.

The normal supported flow is:

```bash
bash tests/validate-artifacts.sh
```

That path:

1. extracts fresh SBCL `ij2` / `ij3` / `ij4` summaries,
2. rebuilds the overlay plots,
3. compares those summaries to this ACL baseline,
4. and checks that the published efficiency ordering and trend shape still hold.

The repo validates historical trend preservation, not point-for-point numerical
identity across platforms.

## Rule Of Thumb

If you are working on the active thesis-result validation story, this directory
is a primary reference input.

If you are studying ACL-era runner mechanics, it is also a preserved source
tree, but not the place from which the modern repo executes experiments.
