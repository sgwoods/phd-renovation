# PhD Research: Program Understanding via Constraint Satisfaction

Modernized codebase from the PhD thesis *"A Method of Program Understanding using Constraint Satisfaction"* (Steven Woods, University of Waterloo, CS-96-33).

Originally developed in Allegro Common Lisp on SPARC, renovated for SBCL on modern hardware.

## What This Is

A constraint satisfaction approach to automated program understanding. Given a program's abstract syntax, the system matches it against a library of programming plans (templates) using CSP techniques to identify algorithmic patterns.

Three CSP solving strategies are implemented and compared:

- **MAP-CSP** (`adt`): Direct CSP matching with backtracking, forward checking, and dynamic rearrangement
- **Memory-CSP** (`memory-search`): Two-phase approach using a memory of previously solved problems to guide search
- **Quilici Search**: Memory-based retrieval with similarity metrics

## Project Goal

The renovation goal is not just to make the Lisp code run on modern hardware.
It is to rebuild the thesis code, data, experiments, and historical artifacts
into a reproducible research baseline that continuously validates the published
results and gives future work a trustworthy starting point.

Current focus: keep the supported thesis-validation path executable
end-to-end, tighten regression coverage around the known baselines, and map the
historical archives closely enough that any future extension can be tied back to
documented provenance. See `RENOVATION.md` for the active roadmap and current
position against that goal.

## Project Structure

```
csp/                        Base CSP solver (backtracking, AC-3, queens, ADT, MPR)
qcsp3/                      Extended solver (memory-CSP, GSAT, Quilici search)
qcsp-may29-1996/            Historical snapshot (May 1996, includes embedded batch data)
qcsp-alex-sep16-1997/       Historical snapshot (Sep 1997, with extended adt)
data/                       Consolidated data directory (see data/README.md)
  sparc-archive/            Original SPARC archive listings and thesis-era data
  acl-experiments/          Original ACL experiment results (ij2/ij3/ij4)
  csp-batch/                Earliest batch experiments (T1-T6, 1993-1994)
  csp-adt-batch/            ADT domain batch experiments (ij1-ij4)
  motors-releases/          MOTORS solver releases (.tar.Z, 1993)
  motors-backups/           MOTORS solver backups (.zoo, 1994)
  thesis/                   PhD thesis PDF
Q-Batch-SBCL/               Replicated experiments (SBCL, M4 Mac)
  Graph/                    4-way comparison plots (ACL vs qcsp3 vs alex vs may29)
tests/                      FiveAM test suites
src/                        Entry point
```

## Where To Look

- `qcsp3/` is the primary codebase for the supported thesis-validation
  baseline; `csp/`, `qcsp-may29-1996/`, and `qcsp-alex-sep16-1997/` are the
  comparison snapshots.
- `tests/` is the authoritative validation surface. It contains the Four
  FiveAM suites, the asserted AO runner, and the artifact/thesis-result
  validation scripts that CI uses.
- `Q-Batch-SBCL/` is the runnable SBCL experiment workspace. It holds the
  modern experiment drivers, generated run directories, and comparison plots.
- `data/` holds preserved ACL/SPARC-era baselines and archive material.
- `historical finds/` is archive intake and provenance work, not supported
  baseline code.

## ASDF Systems

| System | Directory | Description |
|--------|-----------|-------------|
| `:phd-research` | `csp/` | Base CSP solver with queens, ADT, MPR domains |
| `:qcsp3` | `qcsp3/` | Extended solver with memory-CSP and Quilici search |
| `:qcsp-may29-1996` | `qcsp-may29-1996/` | Historical snapshot (May 1996) |
| `:qcsp-alex-sep16-1997` | `qcsp-alex-sep16-1997/` | Historical snapshot (Sep 1997) |

## Quick Start

Requires [SBCL](http://www.sbcl.org/) and [Quicklisp](https://www.quicklisp.org/).

```bash
# Interactive REPL
sbcl --load "src/main.lisp"

# Run all FiveAM test suites (CSP, QCSP3, May29, Alex)
sbcl --non-interactive --load "tests/run.lisp"

# Run asserted AO regression coverage
sbcl --non-interactive --load "tests/ao-run.lisp"

# Run individual suites
sbcl --non-interactive --load "tests/csp-suite.lisp"
sbcl --non-interactive --load "tests/qcsp3-suite.lisp"
sbcl --non-interactive --load "tests/may29-suite.lisp"
sbcl --non-interactive --load "tests/alex-suite.lisp"

# Run the validation spine used by CI
bash tests/validate-artifacts.sh
bash tests/validate-ao.sh

# Run legacy/manual AO harnesses
sbcl --non-interactive --load "run-test4.lisp"
sbcl --non-interactive --load "run-test4-may29.lisp"
sbcl --non-interactive --load "run-test4-alex.lisp"

# Try it interactively
# (qc 4)              ;; 4-Queens
# (qc 8)              ;; 8-Queens
# (adt)               ;; ADT pattern recognition
# (memory-search)     ;; Two-phase memory-based search
```

## Experiments

Three experiment series evaluate CSP search efficiency under increasing noise (50-1000 extraneous program statements):

| Series | Method | Description |
|--------|--------|-------------|
| ij2 | `memory-search` | Baseline: phase 1 uses BT only |
| ij3 | `memory-search` | Both phases with FC/DR and advance sort |
| ij4 | `adt` (direct) | Direct matching with FC/DR and advance sort |

Each series: 20 noise levels x 10 random seeds = 200 runs per snapshot.

### Running experiments

```bash
# qcsp3 (primary system)
bash Q-Batch-SBCL/ij2.sh && bash Q-Batch-SBCL/ij3.sh && bash Q-Batch-SBCL/ij4.sh

# Historical snapshots
bash Q-Batch-SBCL/run-alex-all.sh      # alex (Sep 1997)
bash Q-Batch-SBCL/run-may29-all.sh     # may29 (May 1996)
```

### Generating comparison plots

```bash
python3 Q-Batch-SBCL/Graph/compare-all-overlay.py    # 4-way overlay plots (uses data/acl-experiments/Graph)
```

### Results

The supported SBCL baseline preserves the published ACL/SPARC experimental
story for `ij2`, `ij3`, and `ij4`: the regenerated CI curves stay highly
correlated with the thesis-era ACL curves, preserve the same efficiency
ordering, and remain within stable per-series ratio bands. Exact magnitudes are
not identical across platforms, so the repo validates historical trend
preservation rather than claiming point-for-point statistical identity.

Key findings:
- Direct CSP matching (ij4) is 10-100x more efficient than the two-phase memory approach (ij2) in constraint checks, but the memory approach provides adaptability benefits not captured by this metric.
- The alex snapshot shows significantly higher TCC in ij4 because its
  `ts-matches-type` logic was simplified relative to the earlier snapshots;
  the dormant DFA options may be the missing compensating mechanism.

Plots are in `Q-Batch-SBCL/Graph/compare-*-overlay.png`.

Directory guides:
- `csp/README.md`
- `Q-Batch-SBCL/README.md`
- `tests/README.md`
- `data/README.md`

## License

Academic research code. See `data/thesis/` for the thesis.
