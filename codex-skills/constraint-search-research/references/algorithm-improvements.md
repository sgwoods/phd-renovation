# Candidate algorithm improvements

These are **proposals** except for the initial A0/A1/A4 experimental slices
(2026-10-04): reviewed exports, matched MRV/weighted table-FC and CP-SAT. No
competitive performance win is established. See the benchmark report. Priorities
reflect expected information value and implementation risk, not guaranteed speed.
Source IDs resolve in [the publication ledger](publications.md); work packages and
demonstrations are defined in [the experiment plan](experiment-plan.md).

## First characterize what already exists

| Surface | Observed capability | Before changing it |
|---|---|---|
| `qcsp3/bt.lisp`: `backtracking`, `forward-checking`, `dynamic-rearrangement`, `advance-sort` | Chronological search, FC, domain-based ordering, configurable backjumping | Capture exact solution sets, tie ordering, counter meanings and termination statuses. Do not assume the existing order is textbook MRV in every detail. |
| `qcsp3/ct.lisp`: `revise`, `ac-3`; `qcsp3/adt-simple.lisp`: `:arc-consis` | AC machinery and before/during/both options | Establish a tested maintaining-arc-consistency configuration; adding a switch is not evidence of stronger propagation. |
| `qcsp3/adt-simple.lisp`: `consistent-p` | Distinct program-object assignments and domain callbacks | Preserve implicit injectivity and constraint argument direction. Inspect partial-solution-dependent predicates before exporting binary tables. |
| `qcsp3/memory-csp.lisp`: `memory-search` | Index match followed by seeded full match, separately configured phases | Measure index cost, number of seeds, duplicate work and final match recall separately. |
| `tests/qcsp3-suite.lisp`, `tests/ao-run.lisp` | Small regressions and bounded hierarchical/AO coverage | Add complete expected assignments and adversarial fixtures; truthy return values and counter bounds alone are not cross-backend parity. |

The source snapshots remain reference implementations. New strategy implementations
should be opt-in on the integrated line or external adapters, not sweeping edits
across all four copies.

## Prioritized candidates

| Priority / ID | Change and research basis | Expected benefit and first test | Cost, risk and rejection criterion |
|---|---|---|---|
| P0 A0 | Shared declarative instance model and independent oracle; W0-W1, initial slice implemented | Five synthetic, four reviewed zero-noise ADT/MPR and 20 controlled near-plan cases now have checked exports/mappings; legacy random-noise and Memory-CSP exports remain | Reject unsupported predicates instead of approximating them. Any parity mismatch blocks timing claims. |
| P1 A1 | Failure-weighted variable selection, initially dom/wdeg; S07 | Separate `table-wdeg` FC engine, matched `table-mrv` comparator and bounded traces implemented; integration near historical DR remains a later decision | Controlled enumeration uses fewer checks but sometimes more nodes. Next isolate frozen degree from weight updates and finish repeated timing on a quieter host; do not promote from counters alone. |
| P1 A2 | Characterized MAC plus support residues, adjacency queues and bitsets; S11 | Reduce repeated calls in `forward-checking`/`revise`; noise ladder and sparse-versus-dense relation fixtures | Precomputing all compatibility tables can dominate time/memory. Cache keys must include relevant context or caching is unsound. |
| P1 A3 | Global `allDifferent` filtering; S06 | Injectivity Hall-set example E2, then ambiguous high-overlap ADT domains | More work per node may lose on loose instances. Preserve injective mappings exactly; this method existed in 1994. |
| P1 A4 | CP-SAT adapter with integer object IDs, allowed relations, global distinctness; S09, S16, S18 | Initial exact finite-table adapter implemented and oracle-checked, including ternary tables; Memory-CSP index/full comparisons remain | Encoding blowup and unexported context-dependent semantics remain risks. Count compilation and checking; do not claim every CP-SAT gain is from learning. |
| P2 A5 | Nogoods, restarts and conflict explanations; S08-S10 | Start by instrumenting an existing learning backend; repeated-conflict fixtures reveal reused failures | A native Lisp explanation engine is a larger project. Every learned constraint must be entailed; plain failed prefixes are safe but may be weak. |
| P2 A6 | Separator decomposition, context caching and proven symmetry reduction; S12 | Repeated motifs and hierarchical global explanations; compare width and separator size, not just node count | Sharing/injectivity can reconnect components. Cache complete boundary context. For enumeration, preserve all mappings or report quotient semantics separately. |
| P2 A7 | Structural index ordering, incremental matching and phase-result reuse | `memory-search` E1/E4: fewer redundant seed extensions; optionally reuse support tables across related plans | This is a project hypothesis. Include preprocessing amortization and cold starts. Keep exhaustive fallback so retrieval order cannot silently lose matches. |
| P2 A8 | Labeled subgraph matcher and code-property-graph query baseline; S15, S33 | Plan motifs over typed syntax/data-flow edges; compare structural matching against general CSP | Specify induced/non-induced behavior. Restrict comparison to faithfully expressible relations and retain a checker for extra predicates. |
| P2 A9 | SMT semantic checks and counterexample-guided refinement; S13, S32 | E3 leap-year predicates and bounded arithmetic behavior; infer or reject candidate templates using counterexamples | State integer/bit-vector and overflow semantics. Termination and unrestricted equivalence are not promised. |
| P2 A10 | Weighted global explanation via CP-SAT or a later MaxSAT/MIP adapter | E4 selects mutually compatible local matches, maximizes declared coverage/score and reports bound/gap | Changes a decision problem into optimization. Specify overlap rules and weights independently of solver; scores are not probabilities. |
| P3 A11 | Learned variable/value ranking or solver selection; S14, S20, S21 | Train initially from exact-solver traces; compare a simple linear/tree model before a GNN | Use family-held-out splits and charge inference/feature cost. Rankings never delete branches; benchmark a deliberately bad policy and exact fallback. |
| P3 A12 | Neural plan retrieval and LLM-to-constraint proposals; S19, S23, S24, S28 | E3/E5 compare direct answers, retrieval, and verified solver-backed answers | Translation errors survive solving. Measure retrieval recall and model agreement with trusted small-instance semantics, not just JSON validity. |
| P3 A13 | Constraint acquisition and learned reusable plan libraries; S22, S31, S32 | Grow beyond hand-authored templates using positive/negative programs and counterexamples | Candidate libraries can overfit or change meaning. Require held-out families and independently checked predicates before promotion. |

P0/P1 is the recommended first tranche. P2 expands the scientific story after
parity. P3 explores AI rather than presuming it will beat specialized exact solvers.
Huge neural pretraining, unrestricted source-code semantic equivalence, and a new
production LCG engine are not prerequisites for useful results here.

## Ablation rules

Start from fixed-order BT, FC, FC+existing DR, and FC+DR+advance-sort configurations;
also characterize the existing backjump and AC options. Change one factor at a
time before combining A1-A3. Report the full configuration, not just "optimized."
For CP-SAT, compare one-worker and parallel modes separately and pin its version;
backend options may not isolate every mechanism, so describe those comparisons as
system-level, not causal ablations.

Keep historical NCC/TCC counters in their original meaning. Modern propagation,
conflict, node, and inference counters are separate measures, not replacements
with the same name. Feature extraction, indexing and verifier time belong in
end-to-end totals. Publish negative results when stronger filtering or learned
guidance costs more than it saves.
