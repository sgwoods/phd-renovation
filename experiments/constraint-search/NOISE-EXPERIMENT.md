# Controlled ADT near-plan experiment

This is a historical-derived test family, **not** a reproduction of the thesis's
random-noise distribution. Generator `adt-near-plan-v1` uses the reviewed
`quilici-i1` situation and full `quilici-t1` template. Original Lisp source and
goldens are unchanged.

## Cases and semantic contract

Twenty materialized cases live in `fixtures/noise/`:

- Fifteen positive cases: seeds 0-4 crossed with 0, 1 and 2 near-plan decoy blocks.
  Each block adds nine statements, with fresh operand/object names and one broken
  index dependency: `Increment` names a different index from `Zero`.
- Three negative cases: seed 0 at each noise level, also breaking that dependency
  in the original block. Every local candidate survives unary type filtering, but
  there is no complete match. These are designed near-miss negatives, not a claim
  of asymptotic hardness or random-CSP difficulty.
- One ambiguous case: seed 0, two decoys, with the first decoy's index dependency
  repaired. Exactly the original and repaired block must match.
- One renamed case: seed 0, two decoys, consistently renaming the original block's
  six program identifiers. Type names, operations and the literal `NULL` stay fixed;
  expected object mappings remain unchanged.

The versioned integer LCG shuffles whole-block positions. Seeds vary namespaces
and placement, not independent program families or arbitrary relation graphs.
Zero-noise seeds repeat the same semantic baseline. Do not treat repetitions or
these closely related seeds as independent samples of real-world programs.

Full solution sets are pinned before solving: one, zero or two known mappings.
The filtered products contain 4, 2,048 or 78,732 assignments, under the 100,000 cap.
Generation checks every one against original predicates and the declarative
model, then compares original callback search, the oracle and the original ADT
entry point using its `special` situation override. Inputs include the adjusted
line numbers and initialized type catalog. This path deliberately bypasses the
legacy random-noise generator, whose behavior is not being claimed here.

## Generate and validate

Run from the repository root:

```sh
python3 experiments/constraint-search/generate-noise.py
PHD_BENCH_CP_PYTHON="$PWD/experiments/constraint-search/.venv/bin/python" sbcl --non-interactive --load tests/constraint-search-suite.lisp
```

Default generation checks stored model/sidecar bytes without replacing them.
Use `--write` only after inspecting an intentional generator change. As with the
historical export gate, original entry points create normal ignored random-state
caches. Sidecars retain original/generated/prepared situations, template, domains,
type catalog, mappings, mutation/seed/level and source/instance hashes. Fresh
export and audit times go to stdout, not deterministic sidecar bytes.

## Paired campaign

Use the optional CP-SAT environment documented in [README](README.md). Stop other
project tests before measuring. These commands run sequentially, not concurrently:

```sh
python3 experiments/constraint-search/run.py --strategy comparison --repetitions 5 --mode all --cp-python experiments/constraint-search/.venv/bin/python experiments/constraint-search/fixtures/noise/*.sexp > experiments/constraint-search/results/noise-all.jsonl
python3 experiments/constraint-search/run.py --strategy comparison --repetitions 5 --mode first --cp-python experiments/constraint-search/.venv/bin/python experiments/constraint-search/fixtures/noise/*.sexp > experiments/constraint-search/results/noise-first.jsonl
python3 experiments/constraint-search/summarize-noise.py experiments/constraint-search/results/noise-all.jsonl experiments/constraint-search/results/noise-first.jsonl > experiments/constraint-search/results/noise-summary.json
```

There are 1,400 runs: 20 fixtures x seven configurations x five repetitions x two
modes. Strategy order rotates by repetition. Every run gets a fresh process,
10-second end-to-end wall limit and 5-second Lisp CPU / CP solver wall limit.
The collector retains errors/timeouts rather than selecting successful runs.
Summary generation rejects missing/duplicate repetitions, changed fixtures or
sidecars, invalid witnesses and solution-set disagreement. Repeated counts must
also be deterministic for completed cells.

First-witness SAT is not complete enumeration and has null full-set parity; the
summary instead checks its witness against the independently pinned mappings.
UNSAT must be complete. Completed all-solution runs require exact parity;
limited enumeration with valid witnesses remains incomplete, not a solved cell.
Medians are first
computed within an instance/configuration cell; repeated timings are not new
independent instances. Keep limits visible in cost summaries.

The benchmark starts from materialized tables. Its wall time includes loading,
imports and the independent oracle, but not original-situation export. Separate
generation logs expose export/audit cost. CP-SAT also records encoding, solve and
verification separately. A lower branch count across different engines is not a
CPU-speed claim; Lisp sub-millisecond solve measurements can hit timer resolution.

## Inspect a trace

```sh
sbcl --script experiments/constraint-search/trace-worker.lisp experiments/constraint-search/fixtures/noise/noise-s0-n2-negative.sexp wdeg
sbcl --script experiments/constraint-search/trace-worker.lisp experiments/constraint-search/fixtures/noise/noise-s0-n2-negative.sexp mrv
```

The bounded JSON trace includes variable choices with full current domains and
constraint weights, assignments, attributed failures and backtracks. Recording is
off during benchmarks. The trace worker verifies that recording did not change
solutions, node counts, constraint-test counts or final weights. A trace limit
truncates the recording, not search. Neither trace is a CP-SAT internal trace.

For the two-decoy negative, the weighted trace records three failures on
`19-SAME-NAME-P`, which links the `Zero` and `Increment` indices. Its weight rises
from 1 to 4. This is online symbolic feedback, not neural training; a comparison
with MRV mixes initial weighted degree and subsequent weight updates. A frozen
degree ablation is needed to isolate the value of failure feedback alone.
