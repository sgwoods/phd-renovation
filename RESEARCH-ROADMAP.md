# Constraint search research and experiment roadmap

Research snapshot: **2026-10-03**; execution checkpoint: **2026-10-05**. This is a research lane alongside historical
recovery, not a replacement for the M1 preservation and reproduction gates.

The shared benchmark now includes selected historical exports, experimental
failure-weighted ordering, a frozen-degree control, CP-SAT and controlled near-plan
cases. The repeated campaign and bounded Memory-CSP audits are complete. The
ablation finds no additional search-count benefit from failure updates on this
family. Next, author distinct feedback-sensitive families before training a local
ranker; quiet-host timing and external-model approval remain separate gates.

## Implemented foundation

[The runnable benchmark](experiments/constraint-search/README.md) now supplies a
versioned finite-model format, an independent checker and exhaustive oracle, an
adapter around unmodified QCSP3, and a bounded subprocess runner with JSONL results
and source/input hashes. It compares four existing strategies, three matched
experimental table-FC policies (MRV, frozen degree and failure-weighted), and CP-SAT.

The [five-repeat ablation report](experiments/constraint-search/results/2026-10-05-ablation-report.md)
retains all 1,600 runs: 800 exact enumeration results and 800 first-witness or
exhaustive-UNSAT results, with no errors/timeouts. Frozen and adaptive degree tie
on nodes and checks in both modes. Host load was variable, so no clean latency
speedup is claimed. All earlier reports remain dated evidence, not current status.

The [extension report](experiments/constraint-search/results/2026-10-05-extension-report.md)
adds 22 index/full audits, including two native Memory-CSP anchors, and eight
restricted leap-year programs with semantic and translation checks. The offline
demo uses explicitly scripted proposals, not a neural model. Browser visual QA
remains open because local-file navigation was blocked. The expanded suite passes
2,621 checks with CP-SAT enabled, alongside all 150 original core/AO assertions.
W0/W1 remain partial across the thesis: arbitrary index/full template pairs,
the legacy random-noise distribution and other domains still need independent gates.
See the [approved sequence and next package](experiments/constraint-search/EXECUTION-2026-10-05.md).

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

Initial A1/A4 implementations remain experimental, not promoted defaults.
Degree ordering reduces enumeration checks on all 20 controlled cases but raises
first-witness checks on six. No universal speedup or failure-learning benefit is
established. E3/E5 now have a bounded offline slice; learned guidance and actual
neural evaluation remain **planned**.
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
