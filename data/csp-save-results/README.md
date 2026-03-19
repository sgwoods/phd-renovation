# CSP Saved Results (Aug 1993)

Summarized results from the DREV (Defence Research Establishment Valcartier)
memorandum experiments. Moved from `csp/Save-Results/`.

## Experimental Design

Noise varied from 100 to 1000 (step 100), with 10 random seeds per noise
level. Random variable instantiation and constraint ordering.

## Search Strategies Tested

| Case | Method | Notes |
|-----:|--------|-------|
| 1 | BT + Forward Checking + Dynamic Rearrangement | |
| 2 | BT only | |
| 3 | BackJumping | |
| 4 | BackMarking | |
| 5-8 | AC-3 applied before search | Little/no search required |

## Files

- `data-1` through `data-5` -- Aggregated statistics per search strategy
- `t6-*.out` -- Console output from T6 experiments (most extensive series)

## Provenance

These are the earliest recorded experimental results in the project,
from the MOTORS CSP solver v1.0 era. The batch experiment scripts that
generated them are in `data/csp-batch/T1/` through `T6/`.
