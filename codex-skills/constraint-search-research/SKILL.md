---
name: constraint-search-research
description: Extend the Woods thesis renovation research, compare constraint and learned search methods, and design reproducible program-understanding experiments with historical baseline preservation.
---

# Constraint search research

Use this skill to refresh the literature, prioritize an algorithm, or execute a
research work package for the PhD renovation project. Locate the repository by
`phd-research.asd` and `VALIDATION-MATRIX.md`; do not assume an absolute machine path.
If used outside its repository, request or locate those inputs before making
project-specific claims.

## Load only what the task needs

- Start a literature update with [the brief](references/research-summary.md) and
  [source ledger](references/publications.md).
- Choose an implementation from [algorithm improvements](references/algorithm-improvements.md).
- Run or design a comparison using [the experiment plan](references/experiment-plan.md),
  including its correctness gates and demonstration specifications.
- For the implemented W0/W1 foundation, read
  [the benchmark contract](../../experiments/constraint-search/README.md).
  Use its independent checker and isolated runner before adding a backend. Current
  lanes include QCSP3, matched MRV/frozen-degree/weighted table-FC and optional CP-SAT; only QCSP3
  rejects higher-arity tables. Historical export supports four reviewed zero-noise
  ADT/MPR cases plus a controlled ADT near-plan family, not arbitrary callbacks.
  Read [the noise protocol](../../experiments/constraint-search/NOISE-EXPERIMENT.md)
  for generation, paired repetitions and traces. Seeds vary block placement and
  namespaces, not independent program families; do not inflate sample size with
  repetitions. Use `table-degree` to isolate frozen degree from failure updates
  before attributing gains specifically to feedback. Cross-check original top-level setup as
  well as callback search: ADT name matching depends on the initialized type catalog.
- For two-stage validation, read [the Memory-CSP audit](../../experiments/constraint-search/memory/README.md).
  Native historical anchors and controlled-input ADT composition are different
  execution paths: the latter must not claim native `memory-search` parity.
  Verify candidate recall and every candidate's completions, not just one witness.
- For E3/E5 demonstrations, read [the offline semantic/proposal contract](../../experiments/constraint-search/demos/README.md).
  Its 400-residue argument only covers the enforced divisibility DSL. Scripted
  proposals are not model measurements; keep recognition, semantic correctness
  and translation equivalence separate. Author distinct families before training
  a ranker; near-plan seeds are not a valid cross-family train/test split.
- Refresh current project status from `VALIDATION-MATRIX.md`, the working tree,
  and the tests actually run. Research prose is not a live status feed.

## Research workflow

Trace the requested concept to the thesis and actual solver before calling it new.
Memory-CSP is symbolic two-stage matching; it is not neural memory. Existing FC,
dynamic rearrangement, AC hooks, and backjumping must be included in comparisons.
The thesis also covers global hierarchical explanations, not just local matching.

Use primary papers, author repositories, proceedings, official solver documentation,
and competition results. Search direct follow-ons separately from independent
advances and analogies. Follow backward and forward citations around the matching,
LCG, graph, and neuro-symbolic work relevant to the question. Check online dates,
final venues, and preprint revisions; do not silently merge results across versions.
Record access date, reading depth, limitations, and a stable source ID in the ledger.
Never describe an abstract-only reading as a full-paper review or a selective scan
as an exhaustive state-of-the-art ranking.

## Experiment safeguards

Preserve historical defaults, counters, fixtures, and snapshot files. Add opt-in
strategies or adapters; characterize old behavior before changing it. Reject exports
that omit context-dependent or n-ary constraints, injectivity, or argument ordering.
Compare exact solution sets on small inputs before performance. A witness checker
does not prove UNSAT, completeness, optimality, or correctness of an LLM translation.

Persist materialized inputs, hashes, effective configurations, seeds, versions,
budgets, and status. Separate first solution, enumeration, and optimization; never
turn timeout into UNSAT. Count feature extraction, encoding, verification, model
inference, and training separately. Learned ranking may preserve completeness;
unverified pruning or a hard retrieval cutoff may not.

Keep new synthetic examples separate from recovered historical domains. Do not
rewrite goldens to make an optimization pass. Artifact fallback validation is not
a fresh experiment rerun. Do not run paid APIs, install heavyweight dependencies,
or publish results merely because a work package mentions them.

## Deliverables

For research, update the relevant references and root `RESEARCH-ROADMAP.md` only
as needed. For implementation, deliver the smallest gated package, its tests,
measured results or a candid negative result, and the remaining limitations.
Report which checks actually ran. Before touching README or generated project
surfaces, inspect their generators and isolate `PHD_PUBLIC_SITE_DIR` to avoid
unintended writes to the companion public repository.
