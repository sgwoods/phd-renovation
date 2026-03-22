# qcsp-may29-1996 ADT-Situation

Local guide to the generated direct-ADT situation workspace under the May29
snapshot.

## Role

`qcsp-may29-1996/ADT-Situation/` contains generated ADT situations for the
May29 solver line. These are working-state inputs or regenerated intermediates,
not a canonical results archive.

## Current Shape

Typical names look like:

- `Sit-h-i2-dist1-0805098560-100`
- `Sit-h-i2-dist1-0805098560-2000`

Those names usually encode:

- situation family,
- instance/distribution label,
- seed identity,
- and noise level.

## Important Distinction

This directory is the active May29 working-state location.

The nearby `ADT-SituationMar96/` directory is different: it preserves older
March 1996 ADT situation material and should be treated as a preserved
historical layer rather than the current May29 regeneration target.

## Relationship To Other Areas

- `qcsp-may29-1996/ADT-Random/` provides the seed files paired with this
  directory.
- `data/csp-adt-batch/` remains the canonical preserved ADT batch archive.
- `qcsp-may29-1996/NewData4b-Batch/` and related batch trees preserve summary
  outputs, not the same kind of input-state workspace found here.

## Rule Of Thumb

If you want May29 generated ADT input state, use this directory.

If you want preserved archival outputs, start with `data/` or the snapshot's
batch/result trees.
