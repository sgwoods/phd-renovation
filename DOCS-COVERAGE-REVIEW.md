# Documentation Coverage Review

This file records the current state of documentation coverage across the repo:

1. what is already well explained,
2. what still needs insider knowledge,
3. and what the next documentation passes should target.

Use it as the documentation-focused counterpart to:

- `REPOSITORY-STATUS.md`
- `REPOSITORY-STRUCTURE-REVIEW.md`
- `WORKFLOWS.md`

## Current Read

Short answer:

**documentation coverage is now strong for the primary solver line, the
validation spine, the main preserved result families, and the major historical
snapshot workspaces.**

What remains thinner is no longer the core architecture. It is mostly:

- a few deeper archive/context subtrees,
- some historical/tooling side areas that are preserved but not central,
- and in-code/operator explanation depth inside specific Lisp files rather than
  top-level repo navigation.

## Coverage Levels

### Strong

These areas now explain themselves clearly either in place, from the top-level
docs, or both:

| Area | Current read |
|---|---|
| `README.md` | Strong top-level orientation for goals, workflows, and guide entry points. |
| `DEVELOPMENT.md` | Strong architecture and maintenance guide. |
| `WORKFLOWS.md` | Strong operator-facing map of what to run. |
| `tests/` | Strong validation-surface guidance. |
| `docs/` + `tools/` | Strong generated-doc/status build guidance. |
| `qcsp3/` | Strong coverage across solver role, mixed workspaces, AO layer, and generated data areas. |
| `csp/` | Strong enough for the earliest snapshot, including its lighter working-state scaffolding. |
| `qcsp-may29-1996/` | Stronger now, especially around AO support and working-state vs preserved batch/result trees. |
| `qcsp-alex-sep16-1997/` | Stronger now, especially around `MyBatch/`, `testdata/`, and working-state areas. |
| `data/` | Strong preserved-data catalog and archive/result-family orientation. |
| `incoming/` + `historical finds/` | Strong intake/review/provenance separation. |
| `docs/project-handbook.html` | Strong readable index for human review and onboarding. |

### Good But Still Mixed

These areas are understandable, but still rely on historical naming or mixed
contents that no amount of README text can fully hide:

| Area | Why it is still mixed |
|---|---|
| `Q-Batch-SBCL/` | It still mixes tracked experiment infrastructure, generated run outputs, extracted tables, and tracked overlay images. |
| `qcsp-may29-1996/NewData*` and `Q-Batch*` trees | Historically meaningful naming and embedded result trees remain inherently mixed with the source snapshot. |
| `qcsp-alex-sep16-1997/testdata/` | Better explained than before, but still a large preserved experiment/data tree with multiple subfamilies. |
| `historical finds/yj-sun/` | Valuable provenance, but still archive-heavy and not fully normalized into a simplified reading path. |

### Still Thin

These are the most likely next documentation targets if we keep going:

| Area | What feels thin |
|---|---|
| `qcsp-alex-sep16-1997/testdata/Results*` and sibling subtrees | The top-level `testdata/README.md` exists, but the deeper result-family subareas are still more cataloged than narrated. |
| `historical finds/Refine`, `historical finds/Unravel`, `historical finds/Unravel-changes` | These are classified as archive/context material, but their internal roles are still light. |
| Root helper scripts as a set | `MANUAL-HELPERS.md` helps, but the repo root still visually elevates them more than their current importance warrants. |
| In-code entry-point documentation in the historical snapshots | The repo-level docs are stronger than the remaining function-level guidance in some snapshot files. |

## What Improved In This Pass

The biggest change over the recent cycles is that the repo no longer relies on
tribal knowledge for:

1. intake versus historical-provenance flow,
2. snapshot-local AO layers,
3. snapshot-local batch/workspace trees,
4. working-state random/situation directories across the solver lineage,
5. and the generated handbook/public readable copy as the main human-friendly
   overview.

That is a real shift from "the docs exist if you know where to look" to "the
repo can orient a new reader from several likely entry points."

## Main Remaining Risks

The largest documentation risks now are subtle rather than catastrophic:

1. a reader may still overread preserved batch/result trees as supported active
   workflows just because they sit inside snapshot roots,
2. a reader may still overread root helper scripts as primary entry points,
3. and the large archive-heavy trees may still feel deeper than their
   supporting narrative.

Those are now "clarity polish" risks more than "the repo is unreadable" risks.

## Recommended Next Documentation Moves

If the project keeps investing in the `0.3.x` documentation lane, the best
next steps are:

1. deepen `qcsp-alex-sep16-1997/testdata/` result-family guidance,
2. add one small pass over the archive-only `historical finds/` subtrees that
   still feel opaque,
3. continue in-code docstrings/operator guidance in the most-used maintained
   solver files,
4. and only then consider whether the root helper scripts need structural
   relocation rather than more explanation.

## Maintenance Rule

Update this file whenever:

1. a previously confusing subtree gains a local guide,
2. the handbook adds a significant new coverage layer,
3. a mixed workspace becomes materially clearer or materially more confusing,
4. or the recommended next documentation targets change.
