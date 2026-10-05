# A practical research and demonstration plan

Status: **W0/W1 selected historical slice, initial W2/W3 and bounded E3/E5 implemented**, 2026-10-05.
The [benchmark contract](../../../experiments/constraint-search/README.md) documents
the checker, oracle, QCSP3 adapter, experimental weighted table-FC and CP-SAT lanes.
This is not full historical-domain parity or a performance leaderboard. The
[current execution record](../../../experiments/constraint-search/EXECUTION-2026-10-05.md)
tracks the approved five-step sequence and remaining gates.
Source IDs refer to [the publication ledger](publications.md).

The [expanded report](../../../experiments/constraint-search/results/2026-10-04-expanded-summary.md)
records 63/63 runs with exact parity and 1,972 passing FiveAM checks. Four reviewed
historical-derived cases preserve original ADT/MPR setup and have pinned mappings.
Input v1 is data-only S-expression; output is JSONL. Only the QCSP3 model adapter
rejects tables above arity two. Legacy defaults remain unchanged.

## Controlled noise package

The generator and semantic gates below are implemented as `adt-near-plan-v1`:
20 fixtures, with up to 78,732 exhaustively audited assignments per fixture.
See the [protocol](../../../experiments/constraint-search/NOISE-EXPERIMENT.md).
This structured-decoy distribution is new and must not be presented as the legacy
random generator or as independent program-family samples. Campaign evidence is
recorded separately from the earlier 63-run checkpoint.
The [noise checkpoint report](../../../experiments/constraint-search/results/2026-10-04-noise-report.md)
records 2,264 passing checks, 280 single-pass correctness runs and MRV/weighted
traces. The later [five-repeat ablation](../../../experiments/constraint-search/results/2026-10-05-ablation-report.md)
completes 1,600 runs across eight policies with no errors/timeouts. Frozen/adaptive
degree tie on nodes/checks on every case in both modes. Timings remain observations
under contention; quiet-host latency validation is still open. The
[extension report](../../../experiments/constraint-search/results/2026-10-05-extension-report.md)
records 22 index/full audits and eight restricted semantic/translation examples.

1. Materialize five fixed seeds at three small noise levels for the reviewed ADT
   template. Retain original/generated situations, generator version and hashes;
   calibrate sizes so the filtered Cartesian oracle stays at or below 100,000.
2. Add verified match-preserving decoys and renamings, and match-destroying relation
   mutations. Explicitly pin SAT, UNSAT and ambiguous cases; reject mutations that
   change unintended semantics. Do not call ordinary random noise a hard negative.
3. Run all eight configurations on identical exports, five repetitions per fixture
   in an otherwise idle environment. Separate first witness from enumeration and
   export/encoding from solving; report failures and paired costs, not just wins.
4. Add a small assignment/domain/weight trace for one failure-heavy instance. This
   starts E1, contrasting static MRV with failure feedback and CP-SAT, without
   presenting symbolic constraint weights as neural training.
5. Gate the next expansion on full-set parity, all original regressions and bounded
   runtime. Then export Memory-CSP index/full stages and test candidate recall before
   adding learned retrieval or ranking. Do not change deployment defaults.

**Next causal experiment:** the frozen `dom/degree` control is implemented and shows
that this family does not exercise a search-count benefit from weight updates.
Author distinct, multi-branch feedback-sensitive program families; freeze their
distribution before comparing all policies, including losses and ties. The bounded
Memory-CSP gate is now passed, but it covers only one index/full template pair.
Do not use the related noise seeds as held-out program families for learned ranking.

## Work packages and completion gates

| Package | Deliverable and suggested location | Dependencies | Completion gate |
|---|---|---|---|
| W0 Baseline contract | Document effective flags, result/counter semantics, and materialized fixtures under a new `experiments/constraint-search/`; add small mapping assertions to `tests/` | None | Current validation spine stays green; baseline commit and input hashes recorded; SAT, UNSAT, multiple-match, and timeout cases distinguished. No historical goldens changed. |
| W1 Trusted comparison harness | Versioned finite-model format, independent assignment checker, brute-force tiny oracle, subprocess runner and JSONL results | W0 | Exhaustive solution-set equality on at least 100 tiny generated cases, plus hand-checked cases; reject lossy exports; mutation tests detect missing injectivity, reversed edges, wrong domains and omitted constraints. |
| W2 Improved classical search | Opt-in A1-A3 strategies and matched-instance ablations; E1/E2 traces | W1 | Oracle parity for every strategy, domain restoration after backtracking, unchanged historical defaults/counters; measured overhead and speed both reported. A slowdown is a valid research outcome. |
| W3 Modern exact alternatives | CP-SAT adapter first, then graph or SMT adapter for appropriate subsets | W1; may run alongside W2 | Exact small-instance parity and independent witnesses; unsupported inputs explicitly rejected; benchmark cold encoding+solve+check, not only backend time. |
| W4 Meaningful expanded tasks | E3 leap-year cases and E4 global explanation fixtures, with provenance and explicit semantics | W1, W3 for modern comparison | Positive, negative, ambiguous and semantics-preserving transformations covered; restricted semantic oracle independently tested; global optimum checked exhaustively on tiny cases. |
| W5 Learned and generative guidance | Simple learned ranker, optional GNN/retriever/LLM adapters and fixed-budget evaluation | W1-W4; model/data approval before external calls | Frozen splits by base program and plan family; no test labels in prompts/training; every returned mapping checked; bad-policy fallback, translation mutants and OOD tests pass. |
| W6 Demonstration and publication | Six reproducible examples, small trace viewer or notebooks, raw results and an evidence-backed report | E1/E2 can follow W2; later examples follow W4/W5 | A fresh checkout can reproduce non-model examples; charts include budgets/failures; replayed AI traces are labeled; no fabricated speedups or silently cherry-picked runs. |

**Implemented slices:** W0/W1 selected cases, A1 in a separate matched FC engine,
and A4 CP-SAT. Efficient supports, global filtering and larger studies still remain.
Use separate small
commits for the contract, checker, strategy, adapter, and measured report. Review
the results before expanding the matrix or selecting a deployment default.

## Existing validation commands

Run from the repository root, with dependencies from `BOOTSTRAP-CHECKLIST.md`.
These commands exist today; they do not run the proposed modern benchmarks.

```sh
sbcl --non-interactive --load tests/run.lisp
bash tests/validate-artifacts.sh
bash tests/validate-ff-provenance.sh
bash tests/validate-adt-batch.sh
bash tests/validate-csp-batch.sh
bash tests/validate-ao.sh
PHD_PUBLIC_SITE_DIR=/tmp/phd-research-no-public-sync bash tests/validate-dashboard.sh
```

Ensure the chosen `PHD_PUBLIC_SITE_DIR` does not exist before using that isolation
pattern. Inspect generator behavior before any doc refresh. Artifact validation
can use tracked fallback tables when ignored run trees are absent; record that
mode. It does not establish that large historical batches ran again.

The research-authoring run on 2026-10-03 used SBCL 2.6.4 and passed all four FiveAM
suites: CSP 18, QCSP3 30, May29 21, Alex 21 checks, **90 total**. This statement is
about the existing baseline, not validation of a proposed improvement. Baseline
source revision inspected: `2bdf7a8` on `codex/fix-artifact-pipeline`.

The same run passed AO validation (28 QCSP3, 28 May29, 4 Alex checks), the three
archive/provenance checks, artifact validation in **fresh-clone fallback mode**,
and dashboard validation after regenerating the README-derived handbooks through
the full release-dashboard generator. The skill frontmatter validator passed with
system Python. No modern-solver experiment or model inference was run.

## Benchmark contract

Use stable object and slot IDs, explicit finite domains, typed ordered relations,
and explicit injectivity scopes. Include a provenance category (`historical`,
`historical-derived`, `new-synthetic`, `real-source`) and generator version. Keep
the original materialized input next to its normalized representation and hash
both. Identical random seeds across different generators are not identical inputs.

Do not export arbitrary Lisp callbacks as pairwise relations without proving that
their truth depends only on the exported arguments. N-ary and partial-solution
semantics need a faithful representation or an unsupported-input error. Distinguish
failure to parse, failure to encode, timeout and genuine unsatisfiability.

| Result field group | Required information |
|---|---|
| Identity | Schema version, run ID, source commit/dirty diff, fixture hash, generator version, seed, family and split |
| Method | Backend/model version, strategy flags, thread count, solver/model seed, termination mode and budgets |
| Environment | OS, CPU/RAM, Lisp/Python/library versions, accelerator if used, peak memory and timing method |
| Outcome | SAT/UNSAT/UNKNOWN/ERROR, reason, assignments or artifact hash, independent witness-check result, enumeration completeness, objective/bound/gap if applicable |
| Cost | Feature/index/encoding/solve/verification time, cold-start time, total wall/CPU time, historical counters separately from backend counters |
| AI provenance | Checkpoint or API model ID, prompt/response hashes, sampling settings, tokens, calls, monetary cost if any, train data split and training cost or "unknown" |

Check satisfiable witnesses independently. Establish tiny UNSAT cases by exhaustive
oracle; use proof checking where supported for larger certified claims. Otherwise
label UNSAT as solver-reported, not independently certified. Finding some valid
solutions proves neither complete enumeration nor optimality. An LLM-generated
formalization needs equivalence tests against the intended model, not just a
solution accepted by its own generated checker.

## Instance matrix and measurement

1. **Historical anchors:** the queens, confused-queens, ADT, MPR, Memory-CSP and
   bounded AO cases already covered. Materialize supported `ij2/ij3/ij4` inputs;
   retain each snapshot's noise semantics rather than normalizing them away.
2. **Controlled expansions:** vary template size, object count, relation density,
   constraint tightness, symmetry and separator width independently. Include
   satisfiable, unsatisfiable and many-solution instances. Planted noise alone
   underrepresents hard negatives and missing-plan failures.
3. **Program-oriented expansions:** small, licensed or newly authored code fragments
   with explicit syntax/data-flow extraction. Include renaming, independent
   statement reordering, dead code, near matches and incorrect dependencies.
4. **Generalization:** split by original program and plan family before generating
   variants. Hold out larger sizes and different noise distributions. Prevent
   transformed copies of one program from crossing train/test boundaries.

Proposed resource tiers: 10 seconds per smoke run, 60 seconds for standard runs,
300 seconds for explicitly chosen hard cases, initially one solver worker. These
are execution budgets, not expected durations or observed results. Apply budgets
to each run's end-to-end pipeline, including translation and checking. Put
multiworker throughput in a separate comparison. Begin with five fixed generated
seeds; expand to 30 paired seeds per selected cell after pilot costs are known.
Repeat timing on the same materialized input separately from varying instances.
For extremely short runs, batch repetitions without changing the input and report
startup separately.

Report solved counts, correctness, timeout rates, median and tail latency, and
paired differences or bootstrap intervals over instances. Show a runtime/cactus
plot including unsolved cases. Do not drop timeouts from a claimed average speedup.
Separate time-to-first-witness, all-solution enumeration, and optimization. Limit
enumeration explicitly: exponentially many output mappings can dominate even a
good solver. Never compare modern wall time directly to SPARC timing as an
algorithm-only speedup; rerun old and new algorithms on the same modern machine.

## Six illustrative examples

### E1 Finding a plan in a growing haystack

**Question:** Which structure makes a huge candidate space manageable?
Use a small ADT/Quilici template and materialized planted matches with increasing
irrelevant and misleading objects; separately increase template size. Compare BT,
FC, FC+DR+advance-sort, Memory-CSP, A1 and CP-SAT. Display slot domains, assignment
attempts and domain deletions as synchronized traces, plus an end-to-end cost plot.

**Oracle and gate:** full mapping sets on small cases, independent checks on large
witnesses, and explicitly UNSAT/ambiguous companions. Show that index search itself
has a cost. It is acceptable for the historical heuristic to win on some cases.

### E2 A deduction that local pairwise checks miss

**Question:** What does stronger propagation buy?
Three injective slots have domains `A={1,2}`, `B={1,2}`, `C={1,2,3}`. Pairwise arc
consistency alone leaves `C` unchanged, while global distinctness forces `C=3`.
With `C={1,2}`, the global constraint detects impossibility before branching.
Compare pairwise AC, global filtering and a learning backend on scaled variants.

**Oracle and gate:** enumerate the raw-domain Cartesian product
(12 assignments in the first case, 8 in the second), check
injectivity, and assert the exact valid sets: two and zero. Animate the Hall set,
not a fabricated timing advantage. Credit Regin 1994 [S06] as predating the thesis.

### E3 Leap-year recognition from Y2K to verified AI

**Implemented slice:** [eight DSL programs and an offline demonstration](../../../experiments/constraint-search/demos/README.md)
separate structural recognition, Gregorian semantics and proposal/source equivalence.
No arbitrary C parsing, SMT backend or actual model evaluation is implemented;
visual browser QA remains blocked by the local-file URL policy.

**Question:** Can a system distinguish a familiar-looking program from a correct one?
Create fresh, tiny C-like predicates for the Gregorian rule, the wrong "divisible
by four" rule, and reordered/renamed versions, linked historically to S05 rather
than mislabeled as its recovered corpus. Compare symbolic plan matching, structural
graph queries, LLM classification, and LLM-proposed models checked by an exact
solver. Render code-to-plan links and concrete counterexamples such as 1900/2100.

**Oracle and gate:** include 1900, 2000, 2100 and 2400, then exhaust a 400-year
cycle for a restricted language of Boolean combinations of divisibility by
4/100/400. Prove or enforce that restriction before extrapolating periodicity.
For arbitrary code, a 400-year test is not a proof; use bounded SMT with explicit
integer/overflow semantics or report test-only evidence. Score recognition of a
plan separately from semantic correctness. Include "none of the known plans."

### E4 Locally plausible, globally inconsistent

**Question:** Why are good local matches insufficient?
Create two or three recognizable motifs with competing role assignments and
shared objects. Specify which sharing is legal, which interpretations conflict,
and a declared coverage objective. Compare independent local matching with a
hierarchical/global CSP and a CP-SAT weighted selection model. Display a conflict
graph and the chosen coherent explanation, including ties.

**Oracle and gate:** enumerate all local-match subsets on tiny fixtures; compare
feasibility and optimum. Include a case where the highest-scoring individual
matches cannot coexist and one with several equally good explanations. Do not
claim the bounded current AO tests already implement this new program corpus.
This extends the thesis's global story; S12 supplies a separate decomposition lens.

### E5 A confident suggestion meets an exact checker

**Implemented slice:** the E3 checker rejects a scripted correct-rule proposal when
it is an incorrect translation of buggy source. These are interface/adversarial
tests, not neural measurements. A trained ranker requires a diverse frozen corpus;
external model calls require a named provider/model, exact sendable inputs and budget.

**Question:** When does learned guidance help, and where are its guarantees?
Train a simple ranker from solver traces before considering a GNN. Separately test
a model retrieving templates or proposing assignments/constraint models. Include
misleading identifiers, swapped dependencies, missing distinctness and held-out
plan families. Compare random ranking, hand-coded ranking, learned ranking, direct
model output, and model-plus-exact-solver with exhaustive fallback.

**Oracle and gate:** adversarial candidate mutations must be rejected, a deliberately
poor ranking must retain exact-solver completeness within unbounded search, and
budgeted runs may return UNKNOWN. Test a wrong translation that is internally
satisfiable to expose the difference between solving and formalizing. Show
accuracy/recall versus tokens and total runtime. A scripted proposal may illustrate
the interface but must never be presented as a measured neural model result.

### E6 Planning as a different kind of search

**Question:** How does choosing an action sequence compare with matching a plan?
Use a clearly named new `synthetic-hanoi-3peg` family, initially 3-8 disks, comparing
breadth-first search, an explicit heuristic search, SAT/SMT bounded planning and
optional model-proposed moves. Animate states and illegal-move rejection; report
both reaching the goal and optimality.

**Oracle and gate:** independently validate every move and the goal; for standard
three-peg Hanoi the minimum is `2^n - 1`, checked against BFS on these small cases.
Label this as a transfer illustration, not program understanding or recovery of
the unresolved historical Hanoi-4 domain. Do not infer what "Hanoi-4" means from
its name. Keep this lower-priority than E1-E5.

## Publication and operational boundaries

Keep fixtures, schemas, adapter source, small raw result tables and reproduction
commands in Git. Store large derived traces/models outside ordinary source history
with checksums and retrieval instructions. Record dataset and model licenses before
redistribution. New code extraction must state language coverage and limitations.

Use offline examples first. External model calls require an agreed cost ceiling and
permission to send the selected source data; avoid sending private historical code
by default. Public pages should link a reviewed report only after reproduction;
the research lane must not silently rewrite release status or claim unpublished
plans as completed project capabilities.
