# ACL Experiment Results (1996)

Original experiment results from Allegro Common Lisp on a SPARC/Solaris
workstation (monarch). Moved from top-level `Q-Batch/`.

## Experiment Series

Three experiment series comparing CSP search strategies for program understanding:

| Series | Method | Description |
|--------|--------|-------------|
| ij2 | 2-Phase Memory-CSP | Backtracking phase 1, FCDR phase 2 (baseline) |
| ij3 | Memory-CSP + Heuristics | Both phases use FC + Dynamic Rearrangement + Advance Sort |
| ij4 | Direct ADT CSP | Direct constraint satisfaction with FC/DR/Advance Sort |

Each series tests 20 noise levels (50-1000 in steps of 50) with 10 random
seeds per level = 200 data points per series.

## Structure

```
acl-experiments/
├── ij2/            178 result files (some seeds failed on ACL)
├── ij3/            200 result files
├── ij4/            160 result files (5 groups x 32 seeds)
├── Graph/          Analysis data, gnuplot scripts, PostScript plots
│   ├── ij*-ci.dat  Confidence interval data (noise, mean TCC, CI bounds)
│   ├── ij*-raw.*   Raw aggregated data
│   ├── *.gp        Gnuplot scripts
│   ├── *.ps        PostScript plots
│   ├── Makefile    Build plots from data
│   ├── Bad/        Failed/invalid results
│   ├── Heuristic-Errs  Error log
│   └── Util/       C programs for data extraction
├── ij*.lisp        Experiment definition scripts (ACL format)
├── ij*.out         Console output logs
└── ij*.sh          Shell runner scripts
```

## Result File Format

Each result file (e.g., `ij2/ij2-250.3`) is whitespace-separated columns:

```
Size Mo/NC/AC/FC/DR Ident Dsize NCC TCC BT/V AP S Total NumS BJ ...
```

Key fields: **Size** (noise level), **NCC** (node consistency checks),
**TCC** (total constraint checks), **BT/V** (backtracks / nodes visited).

## Confidence Interval Format

Graph/ij\*-ci.dat files have 4 tab-separated columns:

```
noise_level  mean_TCC  CI_lower  CI_upper
```

95% confidence intervals computed from 10 seeds per noise level.

## Relationship to SBCL Results

The modern SBCL replications are in `Q-Batch-SBCL/` (result directories
gitignored). Comparison overlay plots are in:
- `Q-Batch-SBCL/Graph/compare-ij2-overlay.png`
- `Q-Batch-SBCL/Graph/compare-all-overlay.png`

## Duplicate Copy

`qcsp-may29-1996/Q-Batch/` is a byte-identical copy of this directory,
retained within the May 1996 snapshot for integrity. The canonical copy
is here in `data/acl-experiments/`.
