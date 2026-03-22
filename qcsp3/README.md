# qcsp3

Primary integrated solver line and current operational center of the project.
This directory backs the `:qcsp3` ASDF system and is the leading candidate for
the eventual gold-standard codebase.

Loaded via ASDF system `:qcsp3` (defined in `qcsp3.asd` at the repository
root).

## Role

`qcsp3/` is where the supported post-M1 solver story comes together:

- the executable PhD-result baseline,
- the main ADT and MPR entry points,
- the two-phase memory-based search,
- the preserved Quilici-style search implementation,
- and the shared AO support used by the supported `test4` validation path.

If you are trying to understand the active integrated line rather than the
historical comparison snapshots, start here.

## Core ASDF Files

| File | Role |
|---|---|
| `package.lisp` | Package definition, exports, and shared special variables |
| `bm.lisp` | BackMark search |
| `bt.lisp` | BackTrack search |
| `ct.lisp` | Constraint Techniques (AC-3) |
| `gsat.lisp` | GSAT local search |
| `utility.lisp` | Global setup, counters, reporting, and output formatting |
| `queens.lisp` | Queens and confused-queens domains plus convenience wrappers |
| `mpr-simple.lisp` | MPR domain entry point |
| `mpr-setup.lisp` | MPR setup/data support |
| `quilici-search.lisp` | Constraint-ordered Quilici-style search |
| `adt-simple.lisp` | ADT domain entry point |
| `adt-setup.lisp` | ADT setup/data support |
| `memory-csp.lisp` | Two-phase memory-based search |

## Main Public Entry Points

| Entry point | Purpose |
|---|---|
| `qcsp3:q`, `qcsp3:qs`, `qcsp3:qc` | Standard queens variants |
| `qcsp3:cq`, `qcsp3:cqs`, `qcsp3:cqc` | Confused-queens variants |
| `qcsp3:adt` | Direct ADT matching |
| `qcsp3:mpr` | Model Pattern Recognition |
| `qcsp3:memory-search` | Two-phase memory-based search used in thesis experiments |
| `qcsp3:quilici-search` | Earlier Quilici-style ordered search path |
| `qcsp3:bm`, `qcsp3:backtracking`, `qcsp3:ac-3` | Core solver/search algorithms |
| `qcsp3:set-globals`, `qcsp3:show-options`, `qcsp3:show-solution` | Shared setup/reporting helpers |

Recent `0.3.x` work is also pushing more operator guidance into the code
itself. In a REPL you can inspect the active docstrings directly:

```lisp
(documentation 'qcsp3:backtracking 'function)
(documentation 'qcsp3:ac-3 'function)
(documentation 'qcsp3:memory-search 'function)
(documentation 'qcsp3:quilici-search 'function)
```

The most common interactive load path is still:

```bash
sbcl --load "src/main.lisp"
```

## Directory Mix

This directory contains three kinds of material:

1. source files that define the supported `qcsp3` solver line,
2. runtime-generated ADT/MPR working data, and
3. a small amount of preserved experiment/output material.

That means `qcsp3/` is mostly code, but not code-only.

## Subdirectories

| Directory | Current role |
|---|---|
| `extras/` | AO helper files and legacy `test4` support not loaded by ASDF |
| `ADT-Situation/` | Runtime-generated ADT situations |
| `ADT-Random/` | Runtime-generated ADT random-state files |
| `MPR-Situation/` | Runtime-generated MPR situations |
| `MPR-Random/` | Runtime-generated MPR random-state files |
| `ADT-Batch/` | Preserved/generated ADT batch-style output workspace tied to direct-matching runs |

Local guides now exist for the two mixed-use subareas that most often confuse
readers:

- `extras/README.md`
- `ADT-Batch/README.md`

## AO Support In `extras/`

The `extras/` directory is important, but it is not part of the ASDF system.
It contains the arc-oriented support files used by:

- `tests/ao-run.lisp`
- `run-test4.lisp`
- `run-test4-alex.lisp`

Key files:

| File | Role |
|---|---|
| `ac-graph.lisp` | AO graph representation |
| `hierarchy.lisp` | AO ordering hierarchy |
| `ao-ac3.lisp` | AO AC-3 variant |
| `ao-ac-new.lisp` | AO AC-new variant |
| `ao-revise-step.lisp` | Stepwise AO revise |
| `ao-revise-aggressive.lisp` | Aggressive AO revise |
| `applyr.lisp` | Relation application / propagation helpers |
| `example-extend.lisp` | Mutable example graph state used by `test4` |
| `test4.lisp` | Legacy AO harness definitions |

## Supported Validation Relationship

`qcsp3/` is covered by the main supported validation spine through:

- `tests/run.lisp`
- `tests/validate-artifacts.sh`
- `tests/validate-ao.sh`

In practice that means:

- queens, confused queens, ADT, MPR, and memory-search are regression-tested,
- the supported thesis `ij2` / `ij3` / `ij4` story depends on this tree,
- and the bounded AO baseline now asserts qcsp3 cases 1-3 plus the wrapper
  path under `tests/ao-qcsp3-suite.lisp`.

## What Is Not In This Directory

- Canonical preserved thesis-era baselines live under `data/`, not here.
- The modern batch experiment orchestration lives under `Q-Batch-SBCL/`, not
  here.
- Historical comparison snapshots live under `csp/`,
  `qcsp-may29-1996/`, and `qcsp-alex-sep16-1997/`.

## Practical Reading Order

If you are orienting quickly:

1. `package.lisp`
2. `queens.lisp`
3. `adt-simple.lisp`
4. `mpr-simple.lisp`
5. `memory-csp.lisp`
6. `utility.lisp`
7. `extras/` only if you are working on AO / `test4`
