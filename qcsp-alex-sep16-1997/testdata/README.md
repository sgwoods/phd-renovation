# Alex Test Data (Sep 1997)

C program analysis results from yjzhang's research extension of the CSP
solver for program understanding. This directory is part of the September
1997 snapshot and is documented by but not moved to `data/`.

## Structure

| Directory | Files | Description |
|-----------|------:|-------------|
| Results/ | 326 | Main experiment results (subdirectories per program) |
| Static/ | 51 | Static analysis results |
| thesis-results/ | 20 | Results used in thesis writeup |
| data-c/ | 27 | C program data dependencies |
| data-d/ | 31 | D-variant data dependencies |
| data-y/ | 4 | Y-variant data dependencies |
| fmkfile/ | 8 | Makefile analysis results |
| Results-Loop/ | 40 | Loop analysis results |

Local guides:

- `Results/README.md`
- `Results-Loop/README.md`

## Reading Hints

- `Results/` is the broad preserved experiment-results tree.
- `Results-Loop/` is a specialized loop-analysis result family.
- `thesis-results/` is the publication-layout layer, not the broad raw archive.
- `data-c/`, `data-d/`, and `data-y/` are preserved dependency/input-side
  materials rather than the main result summaries.

## Top-Level Files

| File | Description |
|------|-------------|
| ave.res1 | Averaged experiment results |
| ave.res1.ps | PostScript plot of averaged results |
| dmax.c | C utility for computing max values |
| extract.C | C++ utility for data extraction |
| exp-step.1, exp-step.2 | Step-by-step experiment logs |
| incre-plan.res | Incremental planning results (15 KB) |
| new-plans.res | New planning results (64 KB) |
| special-exp-1.res, special-exp-2.res | Special experiment results (107-123 KB) |
| tscale-3c.result | Timing/scaling results |
| tscale-3c.result.ps | PostScript plot of timing results |

## Other Alex Data Directories

| Directory | Files | Description |
|-----------|------:|-------------|
| MyBatch/ | 28 | Batch experiment scripts (batch-0 through batch-24, run scripts) |
| artifacts/ | 15 | Misc results, template backups (.res, .ps, .lisp.bug, template.txt) |
| SteveBkps/ | 1 | Historical backup |

See `data/README.md` for the full project data catalog.
