# Constraint search benchmark

An executable slice of W0/W1 with initial W2/W3 comparisons. It includes the
**unmodified QCSP3 search engine**, matched experimental MRV/frozen-degree/failure-weighted
forward checking, and optional CP-SAT, checked against an exhaustive oracle.
Five synthetic fixtures and four reviewed zero-noise ADT/MPR exports are covered.
The [controlled near-plan family](NOISE-EXPERIMENT.md) adds 20 materialized ADT
noise/negative/ambiguous/renamed cases and optional bounded search traces.
The [two-stage audit](memory/README.md) covers two native Memory-CSP anchors plus
20 controlled ADT compositions. Hierarchical AO, legacy random-noise batches and
learned models are not covered by this benchmark.
See the [expanded result report](results/2026-10-04-expanded-summary.md).
The [five-repeat checkpoint](results/2026-10-05-ablation-report.md) records 1,600
valid runs. Timing observations are retained but host contention prevents a clean
latency claim. The [extension report](results/2026-10-05-extension-report.md)
adds the index/full audit and offline semantic/proposal demonstration.

## Run

Requirements: the repository's existing SBCL/ASDF installation, Python 3 standard
library, and Quicklisp/FiveAM for tests. Only the optional CP-SAT lane adds Python
packages; no model APIs are used.

```sh
sbcl --non-interactive --load tests/constraint-search-suite.lisp
python3 experiments/constraint-search/run.py
python3 experiments/constraint-search/run.py --strategy fcdr --mode first
python3 experiments/constraint-search/run.py --cpu-seconds 0 --strategy bt
python3 experiments/constraint-search/export.py
```

Install the optional backend into an ignored, project-local environment:

```sh
python3 -m venv experiments/constraint-search/.venv
experiments/constraint-search/.venv/bin/python -m pip install --only-binary=:all: -r experiments/constraint-search/requirements-cp-sat.lock.txt
PHD_BENCH_CP_PYTHON="$PWD/experiments/constraint-search/.venv/bin/python" sbcl --non-interactive --load tests/constraint-search-suite.lisp
python3 experiments/constraint-search/run.py --strategy comparison --cp-python experiments/constraint-search/.venv/bin/python experiments/constraint-search/fixtures/*.sexp experiments/constraint-search/fixtures/historical/*.sexp
```

`all` retains its original meaning: four legacy configurations. `comparison`
retains the original seven configurations and requires CP-SAT. `expanded` adds
`table-degree` for eight policies; `ablation` selects just the three table-FC
policies. All policies can also be selected individually. CI installs the pinned backend;
without `PHD_BENCH_CP_PYTHON`, local FiveAM runs explicitly skip its contract test.

Run from the repository root. The default runner executes five materialized
fixtures under four strategies, producing one JSON record per run on stdout.
Use shell redirection to retain a JSONL result artifact. Paths may also be supplied
explicitly. Each configuration starts a fresh worker process. A 10-second wall limit
covers process startup, loading, solving and verification; Lisp engines also receive
a 5-second CPU limit. For CP-SAT, the same `--cpu-seconds` CLI value sets the solver's
**wall-time** limit, recorded as `solver_time_budget_seconds`, not a CPU limit.
The outer runner kills its owned process group on timeout, including the Lisp
bridge used by CP-SAT. Zero budget deliberately yields UNKNOWN for a nontrivial
instance. Exit 1 means a harness/input/parity error; exit 0 does **not** mean every
instance was solved. Inspect status and termination in every record.

## Version 1 input contract

Files contain one data-only S-expression, never executable Lisp. This initial
Lisp-native wire format avoids adding a parser dependency to the historical
environment; results use JSONL for external analysis. `read-instance` binds
`*read-eval*` to NIL and rejects all `#` dispatch syntax and trailing forms. Inputs
are trusted local data, not an arbitrary untrusted-upload service.

```lisp
(:schema-version 1 :id "example" :provenance "new-synthetic"
 :variables (("source" ("a" "b")) ("target" ("a" "b")))
 :constraints ((:id "edge" :kind :table :scope ("source" "target")
                :tuples (("a" "b")))
               (:id "unique" :kind :all-different :scope ("source" "target"))))
```

- Variables and values are nonempty string IDs. Domains explicitly list allowed
  objects. Duplicate variable IDs, duplicate values, unknown fields, and duplicate
  fields are errors. Empty domains are legal and make the model UNSAT.
- A table is a set of **allowed ordered tuples**, in exactly the order of `:scope`.
  No listed tuples means false. Constraints are conjoined; scopes must name distinct
  declared variables. Tuples must have the right arity and domain membership.
- `:all-different` applies only to its explicit scope. There is no default global
  injectivity: historical exports explicitly encode the domain's implicit distinctness.
- The checker/oracle understand arbitrary finite table arities. The QCSP3 adapter
  only supports unary and binary tables; it rejects higher arities rather than
  silently flattening them. Unary tables filter domains; binary tables preserve
  direction; scoped distinctness becomes pairwise inequality for this baseline.
- Constraint IDs are unique within an instance. Provenance is one of `historical`,
  `historical-derived`, `new-synthetic`, or `real-source`. Every fixture supplied
  at the top level is `new-synthetic`; the `historical/` exports are
  `historical-derived`, not raw recovered thesis experiment outputs.
- A complete assignment is a list of `(variable value)` pairs, exactly one per
  variable. The empty model has one solution, the empty assignment, not zero.

## Guarantees and boundaries

`check-assignment` checks shape, domain membership and every declarative constraint.
It returns validity plus failure IDs. It does not call the solver's compiled pair
relations. `enumerate-instance` evaluates the Cartesian product without propagation,
up to 100,000 complete assignments. The oracle is intentionally simple, not fast.

QCSP3 results are compared against complete oracle solution sets, ignoring order
but rejecting duplicates. A mismatch or invalid witness produces ERROR, never a
performance result. When either search is incomplete, parity is null, not true.
SAT means a witness exists; UNSAT requires exhaustive backend completion; UNKNOWN
means neither has been established before a limit. `complete` is independent of
SAT: first-witness mode is normally SAT with incomplete enumeration. Large UNSAT
results without a completed oracle are solver-reported, not proof-certified.

The checker verifies the **supplied model**, not the correctness of a translation
from source code or a natural-language description. Tests explicitly demonstrate
how an incorrect model can have valid solutions that violate the intended model.

## Legacy adapter contract

The implementation of `qcsp3:backtracking` returns `T` for first witness,
`:complete` for exhausted search (with or without matches), and `:time-bound`
for a CPU limit. Its current docstring's solution-set/resumption description does
not match these executable exits. The adapter reads `qcsp3::*solution-set*` after
the call; it does not treat a truthy return as a mapping.

`show-solution` stores that global only when the output stream is non-NIL.
Therefore the adapter uses a broadcast stream rather than disabling output. It
dynamically isolates the QCSP3 special variables and resets the engine through
`set-globals`; it does not replace global domain callbacks or change solver source.
Use the subprocess runner for experiment isolation, not concurrent in-process
calls to other legacy domain code.

Strategies set all relevant switches explicitly: BT, FC, FC+existing DR, and
FC+existing DR+advance-sort. Backjumping, AC and scheduling checks are disabled in
this first adapter. This is the existing DR behavior, not a new textbook MRV
implementation. Empty models and empty unary-filtered domains are handled before
calling the legacy engine, which requires a nonempty initial state.

## Evidence recorded

Each normal record includes the input SHA-256, source commit, dirty-tree flag,
SHA-256 hashes of harness and QCSP3 source files, effective configuration, runtime
versions, machine/platform, single-worker setting, solutions, parity and termination.
The runner checks that the fixture did not change while the worker ran. Source
files must not be edited during a benchmark. Seeds are null for materialized
fixtures; the test generator is versioned in the FiveAM suite and uses seeds 0-99.

Wall time includes process/load/verification overhead. Solve and verification
ticks are separate and report their time unit. `adapter_pair_checks` counts calls
to the synthetic model callback, not historical ADT TCC; `nodes_visited` retains
the engine counter's meaning. Do not interpret these tiny cases or cold-start
times as a performance leaderboard. Peak memory, CPU model/RAM detail, phase-level
encoding costs, model inference, and a full benchmark matrix remain future work.

## Historical export gate

`export.py` regenerates four allowlisted cases in isolated processes and compares
them byte-for-byte with the stored fixtures/provenance; `--write` deliberately
updates them after review. The original entry points write normal ignored runtime
caches even in check mode; check mode does not change tracked exports or goldens.
The sidecars retain original/prepared situations, templates, raw/filtered domains,
type catalog, source hashes, expected solutions and exhaustive-audit counts.

ADT exports preserve adjusted line numbers, the `dist1` type catalog used by name
matching, original unary filtering and implicit injectivity. MPR preserves original
`:force nil` node-filter semantics. Binary predicate allowlists reject unreviewed
relations, `same-type-p` (a legacy stub), and higher-arity historical constraints.
This is not a general callback serializer. Every unary-filtered Cartesian
assignment is checked against original predicates, then original callback search,
original top-level domain entry points, the converted model and the oracle must
agree. Tests separately pin expected mappings and read serialized fixtures back.

## Experimental strategies

`table-mrv` and `table-wdeg` use the same new forward-checking engine, value order,
restoration and deterministic ties. Only variable selection changes. Weights start
at one on every solve; a direct failed constraint or the last constraint removing
the last domain value gets an increment. Selection minimizes domain size divided
by the summed weights of constraints involving at least two unassigned variables
(denominator at least one). Tables are evaluated once their scope is bound;
distinctness checks assigned values. This is a **dom/wdeg-style FC experiment**,
not MAC, a paper replication, or a change to QCSP3's historical DR implementation.
The source inspiration is [Boussemart et al., ECAI 2004](https://www.cril.univ-artois.fr/~boussemart/home/publis.html).

`table-degree` is the matched control: constraint weights remain one, including
after failures. Active degree still changes as variables are assigned. Compare it
with MRV to isolate degree ordering, and with weighted degree to isolate feedback.
`failure_events` counts failures separately from `weight_updates`; MRV retains
the previous ignored-weight telemetry, but never uses weights to choose variables.
The three policies share filtering, ties, value order and restoration.

Controlled-noise replay compares materialized input bytes and all semantic
sidecar fields. It deliberately preserves the original generation source hashes
instead of rewriting provenance whenever an unrelated runner changes. New run
records capture current execution source hashes independently. `--write` remains
an explicit regeneration operation; archived fixture/sidecar hashes are immutable.

CP-SAT uses globally shared integer object IDs, exact domains, allowed tables and
global distinctness. It runs one worker, seed zero, with all-solution enumeration
when requested. Witness checking uses original model data, independently of the
compiled solver model; complete result sets are compared to the Lisp oracle.
Status/enumeration semantics follow the [official CP-SAT guide](https://developers.google.com/optimization/cp/cp_solver).
Encoding, backend solve and post-solve verification times are recorded separately;
the outer wall time also includes imports and the Lisp validation/oracle bridge.
Backend branch/conflict counts are not interchangeable with QCSP3 node/TCC counts.

## Next gate

The tests enforce full-set equality on 100 generated models across seven Lisp
configurations; the optional CP-SAT contract adds 100 ternary generated models and
all 29 materialized fixtures. Shape/translation mutations, unsupported exports, mapping pins,
budget boundaries and process errors are also tested. FiveAM is a separate CI step;
the original four suites and all historical goldens are untouched.

Controlled near-plan fixtures now pin match-preserving and match-destroying
transformations; see the experiment's separate campaign protocol. The implemented
frozen-weight control isolates failure feedback from initial degree.
It ties adaptive weighting on nodes/checks throughout the current family; use
diverse feedback-sensitive families next. Bounded index/full equivalence now
passes, but arbitrary templates remain unsupported. These cases are not a leaderboard.
W0/W1 remain partial across the whole thesis until other historical input semantics
are exported and independently checked. Do not
change goldens or suppress unsupported constraints to make a backend pass.
