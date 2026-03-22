# Hanoi-4 Status

This file records the repo's current position on `Hanoi-4`.

It exists to keep the plan honest: `Hanoi-4` is now treated as a documented
post-`1.0` research/repeatability lane rather than an implicit blocker for the
first gold-standard integrated solver release.

## Current Read

Short answer: **`Hanoi-4` is not currently an indexed, validated, or integrated
result family in this repository.**

As of March 22, 2026:

- no tracked `Hanoi-4` experiment family is indexed in the main validation
  matrix,
- no executable `Hanoi-4` validation harness is part of the supported gate,
- and no repo-local preserved artifact set has yet been promoted into the
  supported or integrity-checkable surface.

That does **not** make `Hanoi-4` unimportant. It means the repo should describe
the gap clearly instead of letting it act as an undefined `1.0` obligation.

## `1.0` Position

For the `1.0` integrated-line goal, the requirement is:

1. a clear statement of the current `Hanoi-4` situation,
2. a clear record of any known or newly ingested `Hanoi-4` artifacts,
3. a clear note that previous work may indicate repeatability variation, if
   and when the supporting references are actually ingested and indexed, and
4. an explicit statement that full behavioral understanding is deferred.

So `1.0` requires **clarity and bounded scope**, not a complete
`Hanoi-4` repeatability solution.

## `2.0` Position

For the eventual `2.0` research-readiness goal, the requirement becomes:

1. identify and ingest the historical `Hanoi-4` code, data, and result
   artifacts,
2. index any publications, notes, or result summaries that discuss the domain,
3. determine whether the historical `Hanoi-4` results are stably repeatable or
   whether they vary materially across runs, environments, or solver variants,
4. explain any observed repeatability variation with evidence, and
5. decide whether `Hanoi-4` should become executable, integrity-checkable, or
   remain a documented research-only family.

## Current Artifact / Reference Status

| Item | Current state |
|---|---|
| Indexed code | None currently indexed in the supported repo surface |
| Indexed datasets | None currently indexed in the supported repo surface |
| Indexed preserved outputs | None currently indexed in the supported repo surface |
| Indexed literature / notes | None currently indexed in the supported repo surface |
| Repeatability assessment | Not yet possible from the currently indexed material |

## Intake Rule

When `Hanoi-4` materials are found:

1. land them in `incoming/` first,
2. record them in `incoming/INDEX.md`,
3. review whether they are code, data, results, notes, or duplicate/archive
   overlap,
4. update this file with the concrete artifact and reference inventory, and
5. only then decide whether they belong in the integrated line, a preserved
   archive lane, or a research-only lane.

## Planning Rule

Until a real `Hanoi-4` artifact/reference set is ingested and reviewed, the
project should not treat `Hanoi-4` as a hidden blocker for `1.0`.

It should treat `Hanoi-4` as:

- **documented for `1.0`**, and
- **behaviorally unresolved for `2.0`**.
