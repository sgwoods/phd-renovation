# qcsp3 ADT-Random

Local guide to the `qcsp3` snapshot's direct-ADT random-seed workspace.

## Role

`qcsp3/ADT-Random/` holds the random-state files used to generate or replay
direct ADT experiment situations under the maintained `qcsp3` line.

These files are:

- snapshot-local working data,
- important for experiment reproducibility and bridge investigation,
- but not the canonical preserved publication-result archive.

## Naming Pattern

Files are typically named like:

- `Rnd0805098560`
- `Rnd0145944017`

The numeric suffix is the seed identity carried through related situation and
batch outputs.

## Relationship To Other Areas

- `qcsp3/ADT-Situation/` contains the generated ADT situations built from
  these seeds.
- `Q-Batch-SBCL/` is the supported modern experiment workspace that consumes
  maintained solver behavior.
- `data/csp-adt-batch/` is the preserved canonical ADT batch archive; this
  directory is not a replacement for it.

## Supported Status

This directory is part of the maintained solver workspace and has go-forward
value, but it is not validated directly as a standalone artifact family in the
main test spine.

Its main roles are:

- supporting regenerable solver state,
- carrying seed lineage for investigations,
- and helping explain why two runs with the same domain settings may diverge.

## Rule Of Thumb

If you are tracing direct-ADT seed lineage inside `qcsp3`, start here.

If you are looking for preserved historical results, start in `data/` instead.
