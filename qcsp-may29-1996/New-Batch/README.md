# May29 Batch Experiment Data

Historical batch experiment data embedded in the May 1996 snapshot.
This data is documented by but not moved to `data/` to preserve snapshot
integrity. See `data/README.md` for the full data catalog.

## Directories in qcsp-may29-1996/

### New-Batch/ (this directory, 755 files)

ACL-era experiments using the may29 codebase:
- `ij1/` -- BT-only baseline (result files)
- `ij3/` -- AC-3 + BT with heuristics (result files)
- `ij4/` -- Direct ADT matching (result files)
- `ij5/` -- Extended experiment series
- `Graph/`, `Graph0/` -- Analysis data and gnuplot scripts
- `at*.sh`, `ij*.sh` -- Shell runner scripts
- `ij*.lisp` -- ACL experiment scripts
- `ij*.out` -- Console output logs

### Other Batch Directories

| Directory | Files | Description |
|-----------|------:|-------------|
| Q-Batch/ | 676 | Canonical ACL experiments (identical to `data/acl-experiments/`) |
| Q-Batch-Freeze/ | 46 | Frozen snapshot of Q-Batch at a specific point |
| NewData4a-Batch/ | 73 | Extended series 4a experiments |
| NewData4b-Batch/ | 62 | Extended series 4b experiments |
| NewData5-Batch/ | 304 | Extended series 5 (G-fcdr distribution experiments) |
| NewData6-Batch/ | 324 | Extended series 6 experiments |
| ADT-Batch/ | 9 | ADT-specific batch scripts |
| ADT-SituationMar96/ | 203 | **COMPRESSED** (.gz) ADT situations from March 1996 |
| Keep/ | 1 | Preserved notes |
| artifacts/ | 2 | Miscellaneous artifacts |
