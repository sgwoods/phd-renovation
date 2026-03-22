# 1.0.0 Release Notes

## Summary

`1.0.0` marks the first stable integrated release of the PhD renovation
project.

This release establishes a clear, reproducible thesis-result baseline on
modern SBCL, classifies the major preserved historical families honestly, and
ships with synchronized status, handbook, dashboard, and public project pages.

## What This Release Guarantees

- `qcsp3/` is the operational center of the supported integrated solver line.
- The supported thesis `ij2` / `ij3` / `ij4` result story is executable from a
  fresh checkout.
- The bounded AO / `test4` baseline is asserted rather than smoke-only.
- The older `ff*`, ADT batch, and DREV-era `T1`-`T6` families are no longer
  vague archive material; they are documented and integrity-checkable where
  appropriate.
- The project’s supported scope, deferred lanes, and historical deltas are
  documented explicitly rather than left as implicit lore.

## Validation Gate

`1.0.0` is backed by the supported validation spine:

- `tests/run.lisp`
- `tests/validate-artifacts.sh`
- `tests/validate-ff-provenance.sh`
- `tests/validate-adt-batch.sh`
- `tests/validate-csp-batch.sh`
- `tests/validate-ao.sh`
- `tests/validate-dashboard.sh`

## Historical Coverage

### Executable now

- core queens regressions across the maintained snapshots
- confused-queens deterministic metrics
- bounded AO baseline
- PhD `ij2` / `ij3` / `ij4` trend-validation path
- solver-level MPR regression surface

### Integrity-checkable now

- `ff1` / `ff2` / `ff3`
- early `exp-1` / `exp-2` / `exp-3` crosswalked result families
- ADT batch archive (`ij1`-`ij4`)
- earliest DREV-era `T1`-`T6` family

### Snapshot-specific or deferred

- ADT batch remains a documented snapshot-specific family rather than a
  required `qcsp3` reproduction target
- terrain remains a deferred recovery lane
- `Hanoi-4` is documented for `1.0`, with full behavioral and repeatability
  understanding deferred to `2.0`
- alex DFA-option behavior remains a research-readiness lane rather than a
  `1.0` blocker

## Important Boundaries

`1.0.0` does **not** claim:

- complete recovery of all historical domains,
- full rerun support for every preserved archive family,
- or final closure on harder post-thesis research questions like terrain or
  `Hanoi-4` repeatability.

Instead, it claims a trustworthy supported baseline with explicit boundaries.

## Meaningful Remaining Deltas

- alex `ij4` still diverges in the documented way tied to its simplified
  `ts-matches-type` behavior
- ADT batch remains preserved and investigated, but not absorbed into the
  integrated line
- some legacy STYLE-WARNING noise remains outside the main release gate

## Documentation And Operator Improvements

This release also establishes:

- a generated project handbook,
- a generated release dashboard,
- a generated public project page and public handbook,
- a synchronized public status manifest,
- stronger local README coverage across the active solver line and historical
  snapshots,
- and a first-class release checklist for future tags.

## Suggested Announcement Line

`1.0.0` is the first release where the renovated solver line, thesis-result
validation path, preserved historical family classification, and public-facing
status/documentation story all line up cleanly enough to treat the project as
stable and trustworthy to build on.
