# qcsp3 ADT-Batch

Local guide to the direct-ADT batch-style workspace under the primary solver
tree.

## Role

`qcsp3/ADT-Batch/` is a mixed preserved/generated workspace that captures
direct ADT batch-style runs under the `qcsp3` snapshot. It is **not** the
canonical preserved ADT batch archive for the project.

Use this directory as:

- a snapshot-local output/workspace area,
- a clue to how `qcsp3` direct ADT runs were staged,
- and a reference point when comparing the maintained line against preserved
  batch-style families.

## Canonical Versus Local

The project's canonical preserved ADT batch family lives in:

- `data/csp-adt-batch/`

That archive is integrity-checked by:

- `bash tests/validate-adt-batch.sh`

This `qcsp3/ADT-Batch/` directory is different:

- it belongs to the `qcsp3` snapshot tree,
- it is useful for provenance and comparison,
- but it is not the main source of truth for the preserved historical
  `ij1`-`ij4` ADT batch archive.

## Current Shape

The workspace currently contains many single-run outputs with names like:

- `Test-ij4-050.1`
- `Test-ij4-100.1`
- `Test-ij4-1000.99`

That naming pattern indicates:

- direct ADT family `ij4`,
- a noise level in the middle field,
- and a per-run/random suffix in the final field.

These are useful as a snapshot-local run record, but they should not be
treated as the authoritative batch archive without comparing them back to
`data/csp-adt-batch/`.

## Relationship To The Current Roadmap

The repo now treats the broader ADT batch family as:

- historically important,
- integrity-checkable,
- but snapshot-specific rather than a required reproduction target for the
  integrated `qcsp3` line.

That means this directory has go-forward value mainly for:

- provenance,
- bridge investigation,
- and snapshot comparison.

It is not part of the supported current validation spine.

## If You Are Investigating ADT Batch Again

Start with:

1. `ADT-BATCH-INTEGRATION.md`
2. `data/csp-adt-batch/README.md`
3. `tests/README.md`

Then use this directory only to answer snapshot-specific questions about
`qcsp3` output shape or naming.

## Rule Of Thumb

If you want the preserved historical ADT batch archive, go to `data/`.

If you want the `qcsp3` snapshot's own batch-style output workspace, use this
directory.
