# qcsp3 MPR-Situation

Local guide to the generated MPR situation workspace under `qcsp3`.

## Role

`qcsp3/MPR-Situation/` contains generated MPR situation files for the
maintained solver line.

These files represent generated domain inputs or intermediate working state,
not canonical final result summaries.

## Current Shape

Many files are hidden dotfiles with extensions like:

- `.Sit-test-1-ddist-0080215333-0.g`
- `.Sit-test-1-ddist-0080215333-0.p`
- `.Sit-test-1-ddist-0080215333-0.r`
- `.Sit-test-1-ddist-0080215333-0.y`

That layout indicates a multi-file per-situation representation rather than a
single flat artifact.

## What These Files Are Good For

They are useful when you need to understand:

- the generated maintained-line MPR input state,
- whether a seed produced the expected family of situation files,
- or whether a mismatch begins before search/reporting rather than during the
  solver itself.

## Relationship To Other Areas

- `qcsp3/MPR-Random/` carries the seed files paired with this directory.
- `qcsp3/mpr-simple.lisp` and `qcsp3/mpr-setup.lisp` are the main maintained
  code entry points for this domain.
- This directory is a working-state area, not the canonical source of
  preserved publication results.

## Supported Status

This directory supports the maintained solver line, but it is not validated as
an independent archive family by the main test spine.

Treat it as:

- regenerable workspace state,
- useful for debugging and domain inspection,
- secondary to preserved archival result families.

## Rule Of Thumb

If you need to inspect generated MPR inputs inside the active `qcsp3` line,
come here.

If you are tracing publication/result provenance, use `data/` and the
historical snapshot docs first.
