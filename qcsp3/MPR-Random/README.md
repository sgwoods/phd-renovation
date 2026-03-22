# qcsp3 MPR-Random

Local guide to the `qcsp3` snapshot's MPR random-seed workspace.

## Role

`qcsp3/MPR-Random/` stores seed files for generated MPR situations under the
maintained `qcsp3` line.

These are working-state artifacts used to regenerate comparable MPR situations
or to trace seed lineage during investigations.

## Naming Pattern

Files are typically named like:

- `Rnd0080215333`
- `Rnd3253070110`

The seed identity is usually mirrored into the related generated situation
files under `qcsp3/MPR-Situation/`.

## Relationship To Other Areas

- `qcsp3/MPR-Situation/` contains the generated MPR situations paired with
  these seeds.
- `qcsp3/mpr-simple.lisp` and `qcsp3/mpr-setup.lisp` define the maintained MPR
  domain behavior that consumes or regenerates this state.
- Historical preserved MPR-related materials live elsewhere in the snapshot
  trees and archives; this directory is the maintained-line working copy.

## Supported Status

This directory is part of the active solver workspace, but it is not a
first-class validated artifact family on its own.

Its value is mostly:

- operational reproducibility,
- seed-trace debugging,
- and explaining generated MPR input state.

## Rule Of Thumb

If you need the maintained MPR seeds for `qcsp3`, use this directory.

If you need publication/result provenance, start with the preserved data and
snapshot documentation first.
