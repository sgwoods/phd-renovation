# csp MPR-Random

Local guide to the base `csp` snapshot's MPR random-seed workspace.

## Role

`csp/MPR-Random/` stores seed files for generated MPR situations in the
earliest tracked solver root.

These files are:

- working-state reproducibility inputs,
- useful for understanding the earliest MPR generation lineage,
- not a standalone preserved publication/result family.

## Relationship To Other Areas

- `csp/MPR-Situation/` contains the paired generated MPR situation files.
- Later snapshots preserve similar directories with expanded solver behavior.

## Rule Of Thumb

If you need the base snapshot's MPR seed lineage, start here.
