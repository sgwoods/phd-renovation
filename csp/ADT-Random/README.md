# csp ADT-Random

Local guide to the base `csp` snapshot's direct-ADT random-seed workspace.

## Role

`csp/ADT-Random/` stores seed files used by the earliest tracked solver root
for direct ADT generation and replay.

These are:

- base-snapshot working-state artifacts,
- useful for lineage and comparison,
- but not a canonical preserved results family.

## Important Distinction

Unlike later snapshots, the tracked base `csp/` tree does **not** also carry a
full adjacent `ADT-Situation/` workspace. That difference is meaningful: the
earliest root preserves the seed side more clearly than the later regenerated
situation side.

## Relationship To Other Areas

- Later snapshots (`qcsp-may29-1996/`, `qcsp-alex-sep16-1997/`, `qcsp3/`)
  carry fuller ADT working-state layouts.
- `data/csp-adt-batch/` is the preserved canonical ADT batch archive.

## Rule Of Thumb

If you need the earliest tracked ADT seed lineage, start here.

If you need preserved batch outputs, use `data/`.
