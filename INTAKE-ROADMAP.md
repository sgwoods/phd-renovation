# Intake Roadmap

This file turns the post-`1.0.0` intake lane into an explicit operating plan.

The big-picture goal is unchanged:

1. keep the integrated solver baseline trustworthy and recoverable,
2. preserve all potentially useful historical material,
3. and widen the long-term research platform deliberately rather than by
   accidental accumulation.

At this stage, the fastest way to damage that goal would be to let new finds
arrive without a stable review path.

So the next major lane is:

**ingestion, de-duplication, categorization, and promotion of newly found
material.**

## Why This Is The Next Main Effort

The repo now has:

- a published `1.0.0` baseline,
- a green supported validation spine,
- clear recovery/new-machine guidance,
- and explicit preservation policy.

What it does not yet have is a large-volume reviewed intake history.

That means the next risk is not "the code no longer runs."
The next risk is "useful new material appears faster than it can be
understood, and the project loses track of what is canonical, historical,
duplicative, or still pending."

## Intake Objectives

For the next phase, the intake lane should aim to:

1. preserve every potentially useful new find,
2. keep unreviewed material out of the supported baseline until its role is
   understood,
3. make duplicate/canonical decisions explicit,
4. strengthen provenance for historical result families and missing domains,
5. and keep the durable recovery baseline easy to recreate from a fresh clone.

## Operating Flow

Each intake batch should move through these stages:

1. `landed`
   Material arrives in `incoming/` under any convenient temporary name.

2. `indexed`
   The batch is recorded in `incoming/INDEX.md` with source, rough contents,
   and next action.

3. `reviewed`
   We identify what kinds of artifacts are present:
   - code
   - datasets
   - result/output trees
   - publications
   - notes
   - mixed archive bundles

4. `classified`
   The batch or its parts are labeled as:
   - supported baseline candidate
   - integrity-checkable archive
   - provenance-only
   - snapshot-specific
   - duplicate but valuable
   - duplicate and purely transient

5. `promoted`
   Material moves to the correct long-term home:
   - `data/`
   - `historical finds/`
   - a solver snapshot tree
   - or remains in `incoming/` if further review is still needed

6. `recorded`
   The relevant project records are updated:
   - `incoming/INDEX.md`
   - `DUPLICATES-REVIEW.md`
   - `REPOSITORY-STATUS.md`
   - `VALIDATION-MATRIX.md`
   - `RENOVATION.md`
   - and handbook/dashboard/public status outputs if the roadmap or scope changes

## Review Questions

Every non-trivial intake should answer these questions:

1. Is this the only known surviving copy?
2. Is it already represented somewhere else in the repo?
3. If it overlaps existing material, which copy is canonical for supported use?
4. Does it belong to the main solver line, a historical snapshot, `data/`, or
   `historical finds/`?
5. Is it executable, integrity-checkable, provenance-only, or still too
   unclear to classify safely?
6. Does it change any current project blockers, roadmap assumptions, or
   recovery confidence?

## Priority Order For Review

When large amounts of new material arrive, review in this order:

1. blocked-domain recovery leads
   Example: terrain / `QCSP-nov96` / `Lacie1`

2. publication and result-family anchors
   Old result trees, thesis-era reports, preserved graphs, and experiment
   summaries

3. code snapshots and generators
   Especially anything that explains missing workflows or result production

4. publications and notes that change interpretation
   Papers, working notes, comments, and methodological explanations

5. context-only archives
   Useful, but less urgent than material that changes the executable baseline

## What Counts As Success

The intake lane is succeeding when:

- `incoming/` stays understandable rather than becoming a dump,
- new finds are preserved quickly,
- canonical-vs-duplicate decisions are documented,
- the supported baseline stays bounded,
- and future recovery confidence rises rather than falls as more material is added.

## Current Read

Right now:

- the intake lane is ready,
- the policy and destination rules are documented,
- but there are no active indexed batches yet.

That is good news.
It means the process is being established before the next heavy intake wave,
rather than after the repo is already confused.

## Recommended Next Steps

1. Use this workflow on the first real post-`1.0.0` intake batch.
2. Update `incoming/INDEX.md` immediately when any new material lands.
3. Route duplicate/canonical decisions into `DUPLICATES-REVIEW.md`.
4. Promote high-value reviewed material into `data/`, `historical finds/`, or
   snapshot trees deliberately.
5. Keep `1.0.1` reserved for warning cleanup and maintenance hardening while
   the intake lane becomes the main discovery/review front.
