# csp MPR-Situation

Local guide to the base `csp` snapshot's generated MPR situation workspace.

## Role

`csp/MPR-Situation/` contains generated MPR situation files for the earliest
tracked solver root.

This is working-state input data, not a canonical preserved results archive.

## Current Shape

Like later snapshots, this directory uses multi-part hidden situation files
such as:

- `.Sit-test-1-ddist-0007241891-0.g`
- `.Sit-test-1-ddist-0007241891-0.p`
- `.Sit-test-1-ddist-0007241891-0.r`
- `.Sit-test-1-ddist-0007241891-0.y`

There is also a nested `Keep/` area, which should be read as preserved local
holdover material rather than the primary active workspace surface.

## Relationship To Other Areas

- `csp/MPR-Random/` provides the paired seed lineage.
- Later snapshots (`qcsp-may29-1996/`, `qcsp-alex-sep16-1997/`, `qcsp3/`)
  carry parallel MPR working-state directories with more surrounding
  infrastructure.

## Rule Of Thumb

If you need to inspect the earliest tracked MPR input state, use this
directory.

If you need validated preserved results, use the archive/data guides instead.
