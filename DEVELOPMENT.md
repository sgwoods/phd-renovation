# Development Guide

Onboarding guide for AI assistants and developers working on this project.

## What This Project Is

A 1990s PhD research codebase (Common Lisp) that solves program understanding
as a constraint satisfaction problem. Given a program's abstract syntax, the
solver matches it against a library of programming plans (templates) to identify
algorithmic patterns like sorting, searching, or data structure operations.

The codebase was originally written in Allegro Common Lisp on SPARC/Solaris
(1993-1997) and has been renovated to run on SBCL (Steel Bank Common Lisp)
on modern hardware. The renovation preserved algorithmic equivalence — verified
by reproducing 1,800+ experiment runs with statistically matching results.

The broader project goal now goes beyond renovation: use the preserved
snapshots, tests, and result artifacts to converge on one gold-standard code
line that can reproduce the PhD results and absorb the historically reported
domains/results under a single validated umbrella.

Two top-level status artifacts now help answer broader repo questions quickly:

- `REPOSITORY-STATUS.md`: repo-wide indexing/integration/testing/publication
  status table
- `REPOSITORY-STRUCTURE-REVIEW.md`: filesystem clarity review and
  classification guide
- `docs/project-handbook.html`: generated full readable handbook that pulls the
  current core docs together into one indexed page

New material intake now has one dedicated landing zone:

- `incoming/`: single bucket for newly found relevant code, data,
  publications, and experiment artifacts before review and promotion

Different-Mac startup now also has one dedicated entry path:

- `scripts/start-codex-new-mac.sh`: dependency check, iCloud intake-path
  creation, optional Quicklisp install, and full validation-spine run

If multiple Python interpreters exist on macOS, set `PHD_PYTHON` if the
default `python3` does not provide `matplotlib`.

## Architecture

### Four ASDF Systems

The project contains four independent ASDF systems that share the same
architecture but represent different development stages:

| System | Package | Nickname | Directory | Files | Era |
|--------|---------|----------|-----------|------:|-----|
| `:phd-research` | `PHD-CSP` | `csp` | `csp/` | 14 | 1993-1994 |
| `:qcsp3` | `PHD-QCSP3` | `qcsp3` | `qcsp3/` | 13 | 1996 (primary) |
| `:qcsp-may29-1996` | `PHD-QCSP-MAY29` | `qcsp-may29` | `qcsp-may29-1996/` | 13 | May 1996 |
| `:qcsp-alex-sep16-1997` | `PHD-QCSP-ALEX` | `qcsp-alex` | `qcsp-alex-sep16-1997/` | 14 | Sep 1997 |

**`:qcsp3` is the primary system and the leading integration target.** The
others are historical snapshots kept for comparison, provenance, and regression
anchoring. All four load independently and cannot be loaded simultaneously
(they define overlapping function names in separate packages).

### Source File Roles

Each system has the same core files (loaded in this order via ASDF `:serial t`):

| File | Role |
|------|------|
| `package.lisp` | Package definition, all `defvar` declarations, exports |
| `bm.lisp` | BackMark search algorithm |
| `bt.lisp` | BackTrack search (main solver entry point) |
| `ct.lisp` | Constraint Techniques — AC-3 arc consistency |
| `gsat.lisp` | GSAT local search (qcsp3/may29/alex only) |
| `utility.lisp` | Output formatting, global state management, `set-globals` |
| `queens.lisp` | N-Queens problem domain — `q`, `qs`, `qc`, `cq`, `cqs`, `cqc` |
| `mpr-simple.lisp` | Model Pattern Recognition constraints |
| `mpr-setup.lisp` | MPR template/situation data and `save-situation` |
| `quilici-search.lisp` | Constraint-ordered search (qcsp3/may29/alex only) |
| `adt-simple.lisp` | Abstract Data Type recognition constraints |
| `adt-setup.lisp` | ADT template/situation data and `save-situation` |
| `memory-csp.lisp` | Two-phase memory-based search (qcsp3/may29/alex only) |

### Key Entry Points

```lisp
;; N-Queens (deterministic, good for testing)
(qcsp3:qc 4)          ; 4-Queens with AC-3 → :complete
(qcsp3:qc 8)          ; 8-Queens with AC-3 → :complete

;; ADT recognition (uses random seed for noise generation)
(qcsp3:adt :random-ident "unique")

;; MPR recognition
(qcsp3:mpr :random-ident "unique")

;; Two-phase memory-based search
(qcsp3:memory-search "quilici-t1-index" "quilici-t1"
  :sit-noise 0 :random-ident "unique")
```

### Domain-Switching Load Calls

**CRITICAL:** The `queens.lisp`, `adt-setup.lisp`, and `mpr-setup.lisp` files
contain runtime `(load ...)` calls that reload domain-specific function
definitions when switching between queens/ADT/MPR domains. These are NOT
dead code and MUST NOT be removed. They exist because the same function
names (e.g., constraint checkers) are redefined per domain.

### Cross-Package Symbol Comparison

All four systems use `(string-equal random-ident "unique")` instead of
`(eq random-ident 'unique)` because `'unique` resolves to different symbols
in different packages. Any new cross-package symbol comparisons should use
`string-equal` or compare via `symbol-name`.

### Package Exports

All four packages export:
```
q qs qc cq cqs cqc queens adt mpr bm backtracking ac-3
set-globals show-solution show-options comment1 *unix*
*constraint-cks* *node-consistency-checks*
*backtrack-nodes-created* *nodes-visited*
```

qcsp3/may29/alex additionally export:
```
adt-gsat memory-search quilici-search
```

## Build and Test Commands

```bash
# Load into REPL
sbcl --load "src/main.lisp"

# Run all FiveAM test suites (4 systems, 25 tests, ~90 assertions)
sbcl --non-interactive --load "tests/run.lisp"

# Run asserted AO coverage
sbcl --non-interactive --load "tests/ao-run.lisp"

# Run individual suites
sbcl --non-interactive --load "tests/csp-suite.lisp"
sbcl --non-interactive --load "tests/qcsp3-suite.lisp"
sbcl --non-interactive --load "tests/may29-suite.lisp"
sbcl --non-interactive --load "tests/alex-suite.lisp"

# Legacy/manual AO harnesses
sbcl --non-interactive --load "run-test4.lisp"
sbcl --non-interactive --load "run-test4-may29.lisp"
sbcl --non-interactive --load "run-test4-alex.lisp"

# Full supported validation spine
bash tests/validate-artifacts.sh
bash tests/validate-ff-provenance.sh
bash tests/validate-ao.sh

# Run experiments (takes hours — generates 200 data points each)
bash Q-Batch-SBCL/ij2.sh
bash Q-Batch-SBCL/ij3.sh
bash Q-Batch-SBCL/ij4.sh
bash Q-Batch-SBCL/run-may29-all.sh
bash Q-Batch-SBCL/run-alex-all.sh

# Generate comparison plots (requires matplotlib)
python3 Q-Batch-SBCL/Graph/compare-all-overlay.py   # reads ACL baselines from data/acl-experiments/Graph
```

### CI

GitHub Actions runs `tests/run.lisp`, the artifact validation smoke test
(`tests/validate-artifacts.sh`), the preserved `ff*` provenance check
(`tests/validate-ff-provenance.sh`), and the asserted AO regression validation
(`tests/validate-ao.sh`, backed by `tests/ao-run.lisp`) on every push to `main`
and on PRs.
See `.github/workflows/test.yml`.

### Test Architecture

Tests run in separate SBCL processes (one per suite) because the four systems
cannot coexist in a single Lisp image. `tests/run.lisp` orchestrates this.

`tests/` is the authoritative supported validation surface. The repo-root
`run-test4*.lisp` scripts remain useful historical/manual harnesses, but CI
and day-to-day confidence checks should flow through:

- `tests/run.lisp`
- `tests/ao-run.lisp`
- `tests/validate-artifacts.sh`
- `tests/validate-ff-provenance.sh`
- `tests/validate-ao.sh`
- `tests/validate-thesis-comparison.py`

Each suite:
1. Loads Quicklisp and FiveAM
2. Registers the project root with ASDF
3. Loads one ASDF system
4. Runs FiveAM tests with exact metric assertions
5. Exits with code 0 (pass) or 1 (fail)

### What the Tests Assert

- **Queens** (deterministic): exact TCC, backtrack count, nodes visited
- **ADT/MPR** (random seed `"unique"`): exact NCC, TCC upper-bound ceiling
- **Memory-search**: exact NCC, TCC upper-bound ceiling
- Return values: `:complete`, `consp` (for memory-search results)

## Project Layout

```
csp/                           Base CSP solver (14 source .lisp files)
  README.md                    Snapshot guide and file-role orientation
qcsp3/                         Extended solver (13 source files + extras/)
qcsp-may29-1996/               May 1996 snapshot (13 source + extras/ + batch data)
qcsp-alex-sep16-1997/          Sep 1997 snapshot (14 source + extras/ + testdata/)
data/                          Consolidated data directory (see data/README.md)
  sparc-archive/               Original SPARC archive listings (1993-1997)
  acl-experiments/             ACL-era ij2/ij3/ij4 experiment results
  csp-batch/                   Earliest batch experiments (T1-T6)
  csp-adt-batch/               ADT domain batch experiments
  csp-save-results/            DREV memorandum results (1993)
  csp-misc/                    C source, parsers, docs, utility scripts
  motors-releases/             MOTORS solver releases (.tar.Z, 1993)
  motors-backups/              MOTORS solver backups (.zoo, 1994)
  thesis/                      PhD thesis PDF
  lost-datasets.md             QCSP-nov96 terrain/TCSP recovery guide
Q-Batch-SBCL/                  SBCL experiment infrastructure
  README.md                    Experiment/workspace guide
  Graph/                       Analysis scripts and comparison plots
tests/                         FiveAM test suites
  README.md                    Validation entry points and coverage guide
  run.lisp                     Test orchestrator (runs all 4 suites)
  csp-suite.lisp               CSP tests (4 tests)
  qcsp3-suite.lisp             QCSP3 tests (8 tests)
  may29-suite.lisp             May29 tests (5 tests)
  alex-suite.lisp              Alex tests (5 tests)
  ao-run.lisp                  Asserted AO regression runner
  validate-artifacts.sh        Thesis artifact regeneration/validation
  validate-ff-provenance.sh    NewData4b/PrevResults integrity check
  validate-ao.sh               AO validation wrapper
  validate-thesis-comparison.py ACL-vs-SBCL thesis baseline check
src/main.lisp                  REPL entry point
*.asd                          ASDF system definitions (4 files)
run-test4*.lisp                Legacy/manual AO harnesses (3 files)
```

## Known Pitfalls

These are hard-won lessons from the ACL-to-SBCL renovation. Any AI assistant
working on this code should be aware of them.

### 1. defconstant with mutable values

SBCL enforces `defconstant` semantics strictly. If a constant is defined with
a list value, reloading the file fails because the new list is not `eql` to
the old one. Use `defparameter` instead for any non-numeric, non-character,
non-symbol constant.

### 2. Domain-switching (load ...) calls

The `(load ...)` calls in queens.lisp, adt-setup.lisp, and mpr-setup.lisp
are **runtime domain switches**, not build-time includes. They reload
constraint definitions when switching problem domains. Do not remove them
or convert them to ASDF dependencies.

### 3. *domain-loaded* gets overwritten

ASDF loads files in serial order. If queens.lisp sets `*domain-loaded*` to
`'queens`, then adt-simple.lisp (loaded later) overwrites it to `'adt`.
The runtime `(load ...)` calls reset it correctly when a domain is actually
invoked.

### 4. set-globals argument counts differ

`set-globals` takes different numbers of parameters across systems:
- csp/qcsp3: 16 parameters
- may29: 18 parameters
- alex: 20 parameters

Callers in queens.lisp were fixed to pass the correct count with nil
placeholders. If you modify `set-globals`, check all callers.

### 5. Cross-package symbol identity

`(eq random-ident 'unique)` fails across packages because `'unique` is
`PHD-QCSP3::UNIQUE` in one package but `KEYWORD:UNIQUE` or `CL-USER::UNIQUE`
in the caller. Always use `string-equal` for cross-package comparisons.

### 6. SBCL --eval accepts only single expressions

`sbcl --eval "(form1) (form2)"` fails with "Multiple expressions in --eval
option." Write a temporary .lisp file and use `--load` instead, or chain
multiple `--eval` flags.

### 7. Generated data directories must exist before tests

The solver writes to `ADT-Random/`, `ADT-Situation/`, `MPR-Random/`,
`MPR-Situation/` relative to the working directory. On CI (clean checkout),
these don't exist. Test suites use `(ensure-directories-exist "DIR/dummy")`
to create them. If you add a new test that writes data, include this call.

### 8. Alex ADT is limited

Alex's `adt-setup.lisp` has `*template-object-list*` commented out — it loads
template data from external files not included in the repository. Alex ADT
tests must explicitly pass `:situation-id "quilici-i1" :template-id "quilici-t1"`
to use the inline Quilici data. The alex ADT-Situation/ directory is permanently
empty.

### 9. Return values differ between systems

csp and qcsp3 bt.lisp return `:complete` (keyword). The original may29 and
alex bt.lisp returned `'complete` (package-internal symbol). This was
normalized to `:complete` during renovation, but tests use `string=` on
`symbol-name` as an extra safety net.

### 10. Stale .fasl files

SBCL compiles .lisp to .fasl. If you modify a source file but a stale .fasl
exists, SBCL may warn "object file is older than source." Delete `*.fasl` in
the source directories. They're in `.gitignore`.

## Current State (March 2026)

### What's Complete

- **ACL-to-SBCL migration**: All 4 systems compile and run cleanly on SBCL
- **Package isolation**: Each system in its own package with proper exports
- **ASDF build system**: 4 `.asd` files replacing manual load chains
- **FiveAM test suites**: 25 tests with TCC/NCC regression assertions
- **GitHub Actions CI**: Automated testing on push/PR
- **Experiment replication**: ij2/ij3/ij4 across qcsp3, may29, and alex
  with ACL-vs-SBCL comparison plots and automated thesis-trend validation
- **Integration tests**: Arc-oriented (AO) solver tests for qcsp3, may29, alex
- **Data consolidation**: All datasets cataloged in `data/` with READMEs
- **Warning cleanup**: 0 WARNING conditions across all systems (only
  intentional STYLE-WARNINGs from domain function redefinitions)
- **Bug fixes**: 8+ latent bugs found and fixed during renovation
- **Documentation**: README, RENOVATION.md, DEVELOPMENT.md, data/README.md

### What's Open

- **Issue #4**: QCSP-nov96 terrain CSP code — 3 source files completely lost
  from the working tree (`terrain-setup.lisp`, `terrain-simple.lisp`,
  `closure.lisp`). Recovery now has a concrete lead: a `Lacie1` historical
  drive reportedly containing terrain data and the generator. See
  `data/lost-datasets.md`.

### What Could Be Improved

See GitHub Issues for tracked items. Potential improvements:

1. **Suppress remaining STYLE-WARNINGs** — intentional domain-switching
   redefinitions still emit ~20 STYLE-WARNINGs per system load. Could be
   muffled with `sb-ext:muffle-conditions` in the redefinition sites.

2. **Add confused-queens metric assertions** — `cqc` (confused N-Queens)
   tests only assert `:complete`, not specific TCC/BT counts.

3. **Extend thesis-results comparison further back** — CI now checks the
   supported ACL `ij2`/`ij3`/`ij4` baselines against regenerated SBCL tables.
   A later improvement would tie the older `data/sparc-archive/PrevResults/ff*.ci`
   family to a documented modern mapping.

4. **Code documentation** — the core algorithms (backtracking, AC-3, memory-CSP)
   have minimal inline comments. Adding docstrings to key functions would
   help future understanding.

5. **Explore alex DFA features** — alex has `node-type-consis` and
   `dfa-rearrangement` parameters that default to nil. Enabling them in
   ij4 experiments might close the alex TCC divergence gap.

6. **Recover QCSP-nov96** — sort the `Lacie1` terrain/generator lead and any
   late-1996 backup media so the terrain domain can move from blocked archive
   lore toward a real validation family.

## File Modification Guidelines

- **Do not modify core algorithm files** (bm.lisp, bt.lisp, ct.lisp) unless
  fixing a verified bug. The renovation deliberately preserved algorithmic
  behavior.
- **Test after every change**: `sbcl --non-interactive --load "tests/run.lisp"`
- **Queens tests are deterministic** — if queens metrics change, something
  is wrong with the core search.
- **ADT/MPR NCC is deterministic** with `random-ident "unique"`. TCC varies
  due to random noise generation but should stay within the test ceilings.
- All test suites must pass before committing.

## Dependencies

- **SBCL** (any recent version, 2.4+)
- **Quicklisp** (for FiveAM test framework only — no other external deps)
- **Python 3 + matplotlib** (optional, for generating comparison plots)
- **Gnuplot** (optional, for legacy plot scripts)

The solver itself has zero external dependencies beyond Common Lisp.
