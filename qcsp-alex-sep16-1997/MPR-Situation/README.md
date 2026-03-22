# qcsp-alex-sep16-1997 MPR-Situation

Local guide to the Alex snapshot's generated MPR situation workspace.

## Role

`qcsp-alex-sep16-1997/MPR-Situation/` contains generated MPR situation files
for the Alex solver snapshot.

This is a working-state input area, not the main preserved results/archive
surface for the Alex tree.

## Current Shape

Like the other solver snapshots, this directory uses multi-part hidden
situation files such as:

- `.Sit-test-1-ddist-0145944017-0.g`
- `.Sit-test-1-ddist-0145944017-0.p`
- `.Sit-test-1-ddist-0145944017-0.r`
- `.Sit-test-1-ddist-0145944017-0.y`

## Relationship To Other Areas

- `qcsp-alex-sep16-1997/MPR-Random/` carries the paired seed lineage.
- `qcsp-alex-sep16-1997/testdata/` is the more important preserved
  publication/result-side area for this snapshot.

## Rule Of Thumb

If you need Alex generated MPR input state, use this directory.

If you need preserved experimental outputs, start with `testdata/`.
