# qcsp3 ADT-Situation

Local guide to the generated direct-ADT situation workspace under `qcsp3`.

## Role

`qcsp3/ADT-Situation/` contains generated ADT situation files produced from
the maintained `qcsp3` source definitions and random seeds.

This is a working-state directory, not a canonical preserved-results archive.

## Naming Pattern

Situation files commonly look like:

- `Sit-quilici-i1-dist1-0805098560-50`
- `Sit-quilici-i1-dist1-0805098560-1000`

The pattern usually carries:

- situation family / source label,
- distribution label,
- random seed identity,
- and the noise level suffix.

## What These Files Mean

These are solver inputs or regenerated intermediate artifacts, not final
publication-level results. They are useful when you need to inspect:

- how much noise was injected,
- whether two maintained solver lines are building comparable situations,
- or where a bridge/integration mismatch begins before search starts.

## Relationship To Other Areas

- `qcsp3/ADT-Random/` holds the seed files paired with this directory.
- `tests/investigate-adt-batch-*.sh` uses this kind of material when tracing
  ADT bridge divergence.
- `data/csp-adt-batch/` remains the preserved historical ADT batch archive.

## Supported Status

These files have operational value for the maintained line, but the directory
is not itself treated as a canonical validated archive surface.

Think of it as:

- regenerable working data,
- useful for debugging and reproduction analysis,
- but secondary to the preserved result families under `data/`.

## Rule Of Thumb

If you want to inspect the generated ADT input state for `qcsp3`, come here.

If you want stable preserved batch results, use `data/csp-adt-batch/`.
