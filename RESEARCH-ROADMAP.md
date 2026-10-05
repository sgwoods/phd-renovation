# Constraint search research and experiment roadmap

Research snapshot: **2026-10-03**. This is a new research lane alongside historical
recovery, not a replacement for the M1 preservation and reproduction gates.

The shared benchmark now includes selected historical exports, experimental
failure-weighted ordering, CP-SAT and controlled near-plan noise/negative cases
(2026-10-04). Next, finish repeated timing on a quieter host and isolate failure
feedback from initial degree. Learned guidance should follow
only after the interface can distinguish a correct answer from a plausible one.

## Implemented foundation

[The runnable benchmark](experiments/constraint-search/README.md) now supplies a
versioned finite-model format, an independent checker and exhaustive oracle, an
adapter around unmodified QCSP3, and a bounded subprocess runner with JSONL results
and source/input hashes. It compares four existing strategies, two matched
experimental table-FC policies (MRV and failure-weighted), and optional CP-SAT.

The [controlled-noise report](experiments/constraint-search/results/2026-10-04-noise-report.md)
adds 20 cases with pinned outcomes and exhaustive original-predicate export audits,
plus inspectable MRV/weighted traces. A 280-run single-pass matrix passed across
seven configurations and both enumeration modes. The extended suite passed 2,264 checks with
CP-SAT enabled; the five-repeat timing campaign remains deferred because of host
load. The [earlier expanded report](experiments/constraint-search/results/2026-10-04-expanded-summary.md)
records exact parity for all 63 runs: nine fixtures under seven configurations.
Four exports are historical-derived, checked against original ADT/MPR entry points;
five fixtures remain explicitly synthetic. The new FiveAM suite passed 1,972 checks
with CP-SAT enabled, including 100 generated Lisp models and another 100 ternary
CP-SAT models. All 150 existing core/AO assertions also passed. W0/W1 remain partial
across the whole thesis: the legacy random-noise distribution and Memory-CSP
index/full equivalence are still unexported. The earlier [20-run report](experiments/constraint-search/results/2026-10-04-summary.md)
is retained as a separate source-hashed checkpoint.

## Research package

- [Short research summary](codex-skills/constraint-search-research/references/research-summary.md): direct successors, modern alternatives, and the relationship to modern AI.
- [Annotated publications](codex-skills/constraint-search-research/references/publications.md): 33 source records, publication/version caveats, and evidence depth.
- [Algorithm improvements](codex-skills/constraint-search-research/references/algorithm-improvements.md): prioritized changes, repository touchpoints, and falsifiable hypotheses.
- [Executable work plan](codex-skills/constraint-search-research/references/experiment-plan.md): gated work packages, benchmark protocol, and six illustrative examples.
- [Reusable research skill](codex-skills/constraint-search-research/SKILL.md): instructions for extending this work without losing provenance or weakening historical guarantees.

## Current state

The repository records an accepted M1 integrated baseline, with `qcsp3/` as the
supported line and three comparison snapshots. It is not yet an integrated
implementation of every historical result family. Queens, ADT, Memory-CSP, MPR,
and a bounded AO surface have regression paths. Older ADT/CSP batches and `ff*`
include artifact-integrity gates, which are not equivalent to solver reruns.
Terrain and Hanoi-4 remain outside the supported executable scope. See the
[validation matrix](VALIDATION-MATRIX.md) and
[recovery record](RECOVERY-AND-REPRODUCIBILITY.md).

The thesis includes local program-plan matching and hierarchical global
explanations. The code already exposes forward checking, dynamic rearrangement,
advance sorting, backjumping, and arc-consistency options. The research lane must
therefore compare improvements against these, not against naive backtracking alone.

## Recommended sequence

1. **Establish semantic parity:** materialized inputs, independent solution checker,
   tiny exhaustive oracle, and full-solution-set tests. Preserve the historical defaults.
2. **Measure classical improvements:** characterize existing AC/order options; add
   failure-weighted ordering, efficient supports, and global injectivity filtering.
3. **Compare modern engines:** CP-SAT first; graph matching and SMT for the cases
   whose structure or semantics justify them. Include translation and checking costs.
4. **Add AI under verification:** learned ranking, retrieval, and LLM-produced
   constraint models, with explicit fallback and held-out program families.
5. **Publish explanatory examples:** noise/search animation, Hall-set propagation,
   leap-year recognition, global explanations, adversarial AI suggestions, and
   separately labeled synthetic planning.

Initial A1/A4 implementations are now experimental, not promoted defaults. On the
two-match ADT case, weighting reduces checks but increases nodes; no universal
speedup is established. Full demonstrations and learned guidance remain **planned**.
OR-Tools 9.15.6755 and pinned dependencies are isolated in an ignored project-local
environment; CI is configured to install that backend. No paid model runs or model
training occurred. The next bounded work package is in the experiment plan.

Verification on 2026-10-03 passed 90 core and 60 AO assertions, archive/provenance
checks, and regenerated-document validation. Artifact validation passed using its
tracked-data fallback, not a fresh historical batch rerun. The skill validator
also passed. See the work plan for the detailed verification scope.

## Reuse

Ask: "Use `codex-skills/constraint-search-research/SKILL.md` to refresh the literature
and implement work package W0" (or name another package). The skill and its
references are versionable together in this repository; this location is not
automatically installed in the personal skill registry. Personal registration was
not applied: it requires approval for a persistent change outside this repository.
If approved later, link the whole skill folder to keep the research versioned here.
If copying instead, update the thesis links to the new repository location.
