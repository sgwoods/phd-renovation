# Two-stage matching and verified demonstrations, 2026-10-05

## Memory-CSP

All 22 cases pass index-oracle equality, complete candidate recall, exact
per-candidate completion and duplicate-free union equality with direct matching.
The two native anchors also agree with the original `qcsp3:memory-search` entry
point. The 20 generated cases use an explicitly labeled composition of original
ADT calls because the native memory entry point cannot accept prepared situations.
They do not claim native Memory-CSP random-noise reproduction.

| Case | Index candidates | Full matches | Empty completion groups |
|---|---:|---:|---:|
| Historical `adt-base` | 1 | 1 | 0 |
| Historical `adt-two` | 3 | 2 | 1 |
| Two-decoy positive, seed 0 | 5 | 1 | 4 |
| Two-decoy negative, seed 0 | 5 | 0 | 5 |
| Two-decoy ambiguous, seed 0 | 5 | 2 | 3 |

Across the 22 related cases: 68 index candidates, 21 full mappings and 47 empty
completion groups. The exports audit 645,754 assignments against original
predicates across both templates. These totals are audit work, not independent
program-family sample sizes or a timing speedup.

The lesson is directly useful for modern retrieval: a retrieved candidate is not
a completed proof. Reordering all candidates can preserve exact fallback; dropping
candidates can lose valid matches. The audit does not yet measure a neural ranker.

[Raw source-hashed records](2026-10-05-memory-audit.jsonl) and
[reproduction contract](../memory/README.md).

## Pattern, Meaning, and Translation

Eight new DSL programs cover correct Gregorian logic, renamed/reordered logic,
factoring, a tautological clause, misleading identifiers, omitted century handling,
wrong dependencies and an unknown plan. Four are semantically correct and four
are not. Every case passes its pinned classification and a complete 400-residue
check; 1900, 2000, 2100 and 2400 are separate illustrative probes.

The small structural matcher recognizes reordered known patterns but misses a
factored equivalent. Conversely, it recognizes the incorrect divisible-by-four
plan without implying Gregorian correctness. Recognition and semantics are scored
separately.

A scripted proposer always suggests correct Gregorian logic. The translation
checker rejects that suggestion for all four incorrect source programs: silently
repairing a bug is not faithfully describing the original program. An exact solver
cannot fix an incorrect formalization merely by solving it correctly.

The complete-equivalence argument applies only to Boolean combinations of
divisibility by 4/100/400, whose period divides 400. Unsupported syntax and excessive
nesting are rejected. This is not a general C parser, SMT implementation, proof
about arbitrary code, or measured neural model.

[Offline interactive artifact](2026-10-05-leap-year.html),
[JSON evidence](2026-10-05-leap-year.json), and
[demonstration contract](../demos/README.md).
Browser visual/interaction QA remains open: local-file navigation was blocked,
and no workaround was attempted.

## Verification and Next Decisions

The research suite passed 2,621 FiveAM checks with CP-SAT enabled, including the
Python-backed Memory-CSP/DSL mutation contract. The original 90 core and 60 AO
assertions passed. Artifact, ff provenance, ADT/CSP archive, dashboard and skill
checks passed. Artifact validation used tracked fallback data, not a fresh
historical batch rerun. This is local validation; branch push alone does not
trigger the repository's main/PR CI workflow.

The [1,600-run ablation report](2026-10-05-ablation-report.md) establishes no extra
search-count benefit from adaptive weights on this family. The next local package
should author distinct feedback-sensitive plan families, freeze train/test groups
before generating variants, and compare a small learned ranker against random,
handcrafted and deliberately bad orders with exhaustive fallback. Do not train/test
on different noise seeds from the same plan and call that generalization.

External model trials need a named model/provider, a spending ceiling and approval
for the exact newly authored inputs to send. No training, model API calls or paid
inference occurred here. Quiet-host latency validation and broader historical
template coverage remain open. No public deployment or historical-default change
was made.
