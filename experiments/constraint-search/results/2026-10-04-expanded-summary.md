# Historical exports and modern exact comparison

Date: 2026-10-04. This extends the [earlier synthetic checkpoint](2026-10-04-summary.md),
without replacing that checkpoint or its older source hashes.

**Result: 63/63 runs completed with exact oracle parity** across nine fixtures and
seven configurations: QCSP3 BT, FC, FC+DR, FC+DR+advance-sort, experimental table-FC
MRV, experimental table-FC failure-weighted selection, and CP-SAT. There were 56
SAT and seven UNSAT records, no UNKNOWN or ERROR records. This establishes a small
correctness baseline, not a state-of-the-art performance ranking.

## Historical fidelity

| Export | Original situation / template | Unary-filtered assignments audited | Exact matches |
|---|---|---:|---:|
| adt-base | quilici-i1 / quilici-t1 | 4 | 1 |
| adt-index | quilici-i1 / quilici-t1-index | 2 | 1 |
| adt-two | q-i2 / quilici-t1 | 2,048 | 2 |
| mpr-base | test-1 / test1-w | 288 | 1 |

These are deterministic, zero-noise **historical-derived** exports. Sidecars retain
original and prepared inputs, templates, raw and unary-filtered domains, source
hashes, mappings and audit results. All assignments in the filtered products agree
between original predicates and normalized constraints. Original callback search,
original top-level entry points, converted QCSP3 and the oracle agree on solution
sets. Tests also pin expected object IDs independently of regenerated sidecars.

An important setup dependency emerged: ADT name matching needs the type catalog
normally initialized during situation generation. Exporting callbacks without it
made valid matches disappear. The exporter now preserves that catalog as well as
adjusted line numbers; top-level entry-point parity guards against repeating this
error. Historical n-ary and unreviewed predicates are rejected, not approximated.
The index fixture is a direct index-template solve, **not** yet Memory-CSP's
two-stage index/full-plan retrieval pipeline.

## What the ablation shows

The two new FC configurations share all code except variable selection. These are
their counters on the historical exports; counts across different engine families
are not interchangeable.

| Fixture | MRV nodes | Weighted nodes | MRV constraint tests | Weighted constraint tests | Weighted failure updates |
|---|---:|---:|---:|---:|---:|
| adt-base | 9 | 9 | 472 | 464 | 0 |
| adt-index | 4 | 4 | 70 | 65 | 0 |
| adt-two | 18 | 19 | 1,186 | 1,138 | 1 |
| mpr-base | 6 | 6 | 259 | 255 | 1 |

Weighting is **not a universal improvement**: adt-two uses one more node despite
fewer constraint tests. Where there are zero failure updates, any ordering change
comes from initial constraint degree, not learned failure feedback. All five
synthetic fixtures have identical node/test counts under the two policies. These
cases are too easy to measure the intended benefit of repeated failure feedback.

The policy is a documented dom/wdeg-style FC variant inspired by
[Boussemart et al. (2004)](https://www.cril.univ-artois.fr/~boussemart/home/publis.html),
not a literal paper replication or a modification of historical QCSP3 DR.
Weights are transient symbolic failure statistics, not neural model parameters.

CP-SAT returned the same full solution sets. Six of nine fixtures required zero
reported backend branches; the other three required five each. That is evidence
about this configured backend, not an isolated measurement of clause learning.
Its use of global distinctness and allowed tables follows the
[official solver interface](https://developers.google.com/optimization/cp/cp_solver).

Cold end-to-end median time across these nine cases was approximately 0.30-0.31
seconds for the Lisp configurations and 1.19 seconds for CP-SAT. Imports, process
startup and the Lisp oracle bridge dominate these tiny runs. Other validation was
running on the same machine, with no timing repetitions; these figures are
diagnostic only and support **no speedup or slowdown claim about solver quality**.

## Reproduction and checks

Raw data: [2026-10-04-expanded.jsonl](2026-10-04-expanded.jsonl).
SHA-256: `9c2aa89cfcef6997b275977029d9d6273ce8e3ee2bdd80623b0320ba4393e557`.
Follow the [benchmark instructions](../README.md) for setup and the exact command.

Environment: macOS 15.7.7 arm64, eight logical CPUs, Python 3.12.1, SBCL 2.6.4,
OR-Tools 9.15.6755. One backend worker, CP seed zero; 10-second outer wall budget,
5-second Lisp CPU or CP-SAT solver wall budget. No model inference or training.
Source HEAD was `2bdf7a8bf6cf23259ce2f49714087f41ec1e8497`, with uncommitted research
changes. Each record contains the actual source and fixture hashes; those hashes
were checked against the working files after the run. Optional packages live in an
ignored project-local virtual environment with pinned requirements, not in Git.

Passed in this implementation run:

- 1,972 FiveAM checks with the optional CP-SAT contract enabled and no skips;
  six Lisp configurations on 100 generated models, plus CP-SAT's Python helper on
  nine fixtures and 100 generated ternary models checked by the Lisp oracle.
- Historical export regeneration/drift gate, exact mapping pins, unsupported
  constraints, witness mutations, first-solution/zero-budget/process-error cases.
- All 90 existing core and 60 existing AO checks; no legacy source or goldens edited.
- ADT/CSP archive and ff provenance validators; artifact validation in tracked-data
  fallback mode, **not** a fresh historical batch reproduction.
- Release-dashboard validation with public-repository synchronization isolated,
  skill frontmatter validation, and tracked diff whitespace check.

GitHub Actions is configured to install the pinned backend and run the same suite;
remote CI has not run for these uncommitted changes. Everything remains local.

## Next decision

Proceed with the [bounded noise/hard-negative package](../../../codex-skills/constraint-search-research/references/experiment-plan.md):
materialized inputs, match-preserving and match-destroying transformations,
full-set correctness, paired repetitions, then a small domain/weight trace.
Only after that should we evaluate whether weighting earns integration into the
legacy engine, add stronger propagation, or introduce verified learned guidance.
