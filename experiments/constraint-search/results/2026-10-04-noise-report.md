# Controlled noise and near-miss negatives

Date: 2026-10-04. This checkpoint adds **20 materialized historical-derived ADT
cases**, verified transformations, paired-run tooling and bounded search traces.
The planned 1,400-run, five-repeat timing campaign is **not complete**: under severe
host load, even a tiny CP-SAT startup exceeded its 10-second wall budget. No performance
ranking or general speedup is claimed here.

The bounded **single-pass correctness matrix completed 280/280 runs**: 20 cases x
seven configurations x two modes, with a 60-second outer wall allowance and the
unchanged 5-second solver allowance. All 140 enumeration runs have exact full-set
parity. All 140 first-witness runs returned a pinned valid witness or completely
established UNSAT; first-witness SAT is not mislabeled as exhaustive parity.
There were 238 SAT and 42 UNSAT records, no UNKNOWN or ERROR in this matrix.

Raw [enumeration records](2026-10-04-noise-all.jsonl),
[first-witness records](2026-10-04-noise-first.jsonl) and
[validated summary](2026-10-04-noise-summary.json) retain configurations, budgets,
source/input/sidecar hashes and costs. This used one repetition, **not five**.
No other project test suite overlapped the matrix, but the shared host was not a
controlled timing environment. Neither the stored single-run costs nor the summary
fields labeled median constitute a repeated latency study.

## What the examples demonstrate

Five seeds and three levels add 0, 1 or 2 nearly valid nine-statement plans around
the original plan. Each decoy breaks one `Zero`/`Increment` index dependency while
preserving unary-compatible statement shapes. Fifteen cases retain exactly the
original match. Three break the original too (UNSAT), one repairs a decoy (two
matches), and one consistently renames the original (same match).

| Decoy blocks | Statements | Raw nine-slot Cartesian product | After original unary filtering |
|---|---:|---:|---:|
| 0 | 9 | 387,420,489 | 4 |
| 1 | 18 | 198,359,290,368 | 2,048 |
| 2 | 27 | 7,625,597,484,987 | 78,732 |

The raw products are theoretical counts, **not** spaces we exhaustively searched.
Original type/statement filtering performs the first large reduction; relational
constraints and search then resolve the remaining candidates. Every assignment in
each filtered product is checked against original predicates and the declarative
model. Original callback search, the original top-level ADT override path and the
independent oracle must also agree with pinned expected mappings before export.

Seeds vary block position and identifiers, not independent program families.
Zero-noise seeds repeat the same semantic case. These are controlled near misses,
not a reproduction of the historical random-noise generator or evidence that all
large program-recognition instances are easy.

## An inspectable search difference

For `noise-s0-n2-negative`, both policies prove UNSAT:

| Matched table-FC policy | Nodes | Constraint tests | Failure updates |
|---|---:|---:|---:|
| MRV | 15 | 1,686 | 3 |
| Failure-weighted | 9 | 1,236 | 3 |

The [weighted trace](2026-10-04-noise-trace-wdeg.json) records three failures on
`19-SAME-NAME-P` (the index-link relation), increasing its weight from 1 to 4. The
[MRV trace](2026-10-04-noise-trace-mrv.json) provides the matched comparison. Each
trace records choices, current domains/weights, assignments, failures and
backtracks, and is verified not to alter solutions or search counters.

This is symbolic feedback accumulated during one solve, not neural training.
The difference combines initial constraint degree with failure feedback. It does
**not** show how much of the improvement comes specifically from updating weights;
a frozen-degree ablation is the next causal test. Fewer nodes or checks on this
fixture do not establish a wall-time improvement or a general winner.

Across the 20 full-enumeration cases, weighting used fewer constraint tests in
all 20; nodes were lower in 12, equal in five, and higher in three. For example,
the ambiguous case used 21 weighted nodes versus MRV's 20. These are correlated
controlled cases, not 20 independent programs, and no statistical generalization
is justified.

## Verification and host limitation

The extended FiveAM suite passed **2,264 checks**, with CP-SAT enabled and no skips.
Coverage includes exact sets for all 20 new cases under six Lisp configurations,
the original generated-model tests, regeneration/drift checks, pinned mappings,
bounded trace invariance, and CP-SAT on all 29 fixtures plus 100 ternary models.
All 90 core and 60 AO checks passed. Archive/provenance, isolated dashboard and
artifact validators passed; artifact validation used tracked-data fallback, not a
new historical batch reproduction. No legacy solver source or goldens changed.

An initial correctness run failed only its CP-SAT CLI startup assertion under the
10-second wall limit. Host load averages reached 278.32/202.46/112.35. A profiled
retry spent about 12.13 seconds importing `cp_model`, versus 0.054 seconds solving
the tiny ordered fixture. The later [60-second-budget probe](2026-10-04-noise-host-check.jsonl)
completed in 1.62 seconds, illustrating startup variability. The earlier
[timeout record](2026-10-04-noise-host-timeout.jsonl) remains UNKNOWN, never UNSAT.
The **test-only** CLI allowance is now 60 seconds; ordinary benchmark defaults
remain 10 seconds wall and 5 seconds solver budget.

The [generation log](2026-10-04-noise-generation.jsonl) separates export from full
predicate/oracle audit cost. It was collected during other validation, so those
times are diagnostic, not a controlled export benchmark. The trace runs likewise
support counter comparisons, not latency claims.

## Reproduce and advance

The [experiment protocol](../NOISE-EXPERIMENT.md) contains generation, validation,
single-process repetitions, summary validation and trace commands. Fixtures and
sidecars preserve original/generated/prepared statements, type catalog, domains,
expected mappings, generator version, source and input hashes. New scripts and
the skill remain repository-local; the virtual environment is ignored.

To reproduce this correctness matrix instead of the planned timing campaign, use
the protocol's runner commands with `--repetitions 1 --wall-seconds 60` for each
mode, then summarize with `--repetitions 1`. The environment remains SBCL 2.6.4,
Python 3.12.1 and OR-Tools 9.15.6755. HEAD was `2bdf7a8` with uncommitted changes;
the raw records identify actual code content with hashes, not HEAD alone.

On a quieter host, run the documented five-repeat campaign with both modes and
retain all limits/errors. Only then assess timings. Next compare MRV, frozen
degree and adaptive weighting without changing propagation. Memory-CSP index/full
recall and broader program families should precede learned retrieval or ranking.
No model API calls, training, publication, commits or pushes occurred in this step.
