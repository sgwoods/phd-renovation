# Preservation Policy

This project keeps **all potentially useful information**.

That includes:

- source code
- preserved datasets
- experiment outputs
- publications
- notes
- recovered archives
- overlapping or duplicate historical copies that still help explain lineage
- partially understood material that may become useful later

The default rule is:

**classify, preserve, and document - do not discard merely because something is
not yet integrated, fully understood, or immediately useful.**

## Why This Exists

This repo is not only a runnable solver codebase.
It is also a research-recovery and historical-provenance project.

That means material can be valuable for more than one reason:

- active execution or testing,
- integrity-checkable historical evidence,
- publication support,
- reconstruction of lost workflows,
- comparison against other snapshots,
- or future research questions that are not yet mature enough to act on.

## Preservation Classes

Every meaningful artifact should end up in one of these classes:

| Class | Meaning |
|---|---|
| `supported baseline` | Part of the actively supported solver, validation, or publication-validation flow |
| `integrity-checkable` | Preserved and checked against known historical artifacts, even if not rerun end-to-end |
| `provenance-only` | Valuable for lineage, context, or recovery, but not part of the supported baseline |
| `snapshot-specific` | Preserved as part of a historical branch of the solver story without requiring integration into the maintained line |
| `duplicate but valuable` | Overlaps a canonical copy but is retained for provenance, snapshot integrity, or historical explanation |
| `incoming / pending review` | Newly found material that has not yet been reviewed enough to classify safely |

## Intake Rule

If new material appears and its role is not yet clear:

1. keep it,
2. place it under `incoming/`,
3. record it in `incoming/INDEX.md`,
4. review it,
5. then promote or classify it deliberately.

Do not discard unreviewed material just because it looks messy, redundant, or
unclear at first glance.

## Duplicate Rule

Duplicate does **not** mean disposable.

If two trees overlap, the reviewed outcome should answer:

1. which copy is canonical for day-to-day supported work,
2. whether the other copy still matters for provenance or snapshot integrity,
3. and where that decision is documented.

Use `DUPLICATES-REVIEW.md` for those decisions.

## What May Still Be Ignored

This preservation-first rule does **not** require checking in every transient
machine-generated cache.

The repo may still ignore:

- reproducible random/situation workspaces,
- intermediate experiment run trees,
- compiled Lisp outputs like `*.fasl`,
- local environment noise such as `.DS_Store`, `.venv/`, and similar files.

Those are acceptable to ignore **only** when:

1. they are rebuildable from preserved inputs and tracked tooling, and
2. they are not the only surviving copy of potentially useful historical information.

## Current Compliance Read

The repo is currently aligned with this policy:

- major code, result, publication, and archive material is tracked,
- newly found material has a defined intake lane in `incoming/`,
- reviewed overlap decisions have a home in `DUPLICATES-REVIEW.md`,
- and the main ignored surfaces are rebuildable workspaces or local machine noise.

The remaining risk is operational, not conceptual:

- future finds must actually be routed through `incoming/`,
- and potentially useful local-only material must not be left outside git or
  outside documented companion repos.

## Maintenance Rule

Update this policy or the linked intake/duplicate/recovery docs whenever:

1. a new class of preserved artifact appears,
2. an ignore rule might hide historically useful material,
3. a new archive intake path is introduced,
4. or the project’s preservation boundary changes in a meaningful way.
