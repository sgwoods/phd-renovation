# qcsp-may29-1996 MPR-Random

Local guide to the May29 snapshot's MPR random-seed workspace.

## Role

`qcsp-may29-1996/MPR-Random/` stores random-seed files used to generate or
replay MPR situations in the May29 snapshot.

These are snapshot-local working artifacts, not a standalone preserved result
family.

## Relationship To Other Areas

- `qcsp-may29-1996/MPR-Situation/` contains the paired generated MPR
  situations.
- `mpr-simple.lisp` and `mpr-setup.lisp` define the code that uses or
  regenerates this state.

## Rule Of Thumb

If you need seed-level reproducibility for May29 MPR generation, start here.
