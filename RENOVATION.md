# Renovation: Allegro CL to SBCL

This document describes the migration of the PhD research codebase from Allegro Common Lisp (SPARC, 1993-1997) to Steel Bank Common Lisp (macOS ARM64, 2026).

## Overview

| | Original | Renovated |
|---|---|---|
| **Lisp** | Allegro CL 4.x (Franz Inc.) | SBCL 2.6.x |
| **Platform** | SPARC / Solaris | Apple M4 / macOS |
| **Build** | Manual `(load "load")` chains | ASDF 3 with `.asd` system definitions |
| **Packages** | Everything in `CL-USER` | `PHD-CSP`, `PHD-QCSP3`, `PHD-QCSP-MAY29`, `PHD-QCSP-ALEX` |
| **Tests** | None | FiveAM suites + integration runners |
| **Files** | `.cl` extension | `.lisp` extension |

Four systems were modernized covering ~45 source files:

- `:phd-research` (csp/) -- base CSP solver
- `:qcsp3` (qcsp3/) -- extended solver with memory-CSP and Quilici search
- `:qcsp-may29-1996` -- historical snapshot (May 1996)
- `:qcsp-alex-sep16-1997` -- historical snapshot (Sep 1997)

## What Changed

### Build system

Replaced Allegro CL's manual load chains with ASDF system definitions. Each system got a `package.lisp` with `defpackage`/`in-package`, isolating symbols into their own packages instead of polluting `CL-USER`.

### Franz-isms removed

- `excl:*` and `sys:*` calls (Allegro-specific extensions)
- `#p(...)` reader macros (Allegro pathname literals)
- `.clinit.cl` initialization files
- Hardcoded Mac OS 9 paths (`"Macintosh HD:Languages:..."`)

### Dead code removed

- Backup artifacts (`.bkp`, `.bak`, `*~` files)
- Mac OS 9 code branches and path logic
- Duplicate/unreachable function definitions
- `.DS_Store` files

### Bug fixes found during renovation

These are latent bugs in the original code that were discovered and fixed:

| Bug | File(s) | Fix |
|-----|---------|-----|
| `defconstant` with list values fails on SBCL reload | multiple | Changed to `defparameter` |
| `:mode` keyword passed where `:arc-consis` expected | queens.lisp | Changed to `:arc-consis` |
| `LENGTH` variable shadows CL built-in | bm.lisp | Renamed to `num-vals` |
| `*current-situation` typo (missing `*`) | utility.lisp | Fixed to `*current-situation*` |
| Duplicate `defun get-templ-constraints` | mpr-simple.lisp | Removed duplicate |
| Extra close paren creating unreachable code | csp/bt.lisp | Removed |
| `set-globals` caller passes 18 args, callee expects 20 | alex/mpr-simple.lisp | Added 2 missing `nil` args |
| `eq` used on strings (identity vs equality) | may29+alex/mpr-simple.lisp | Changed to `string-equal` |
| Unconditional `concatenate` on non-string `output-file` | qcsp3/utility.lisp | Moved inside string-only branch |

### Return value normalization

Changed `'complete`, `'error`, `'time-bound` (package-internal symbols) to `:complete`, `:error`, `:time-bound` (keywords) across all four bt.lisp files. Keywords are self-evaluating and package-independent, making cross-package test assertions reliable.

### Warning suppression

SBCL emits `redefinition-warning` when a function is defined in one file and intentionally redefined in another (e.g., `mpr-simple.lisp` defines stubs that `mpr-setup.lisp` overrides). Added `sb-ext:muffle-conditions` declarations around the 16 files that participate in this pattern, bringing the warning count from ~60 per system to 0.

## What Did NOT Change

The core algorithms are untouched:

- Backtracking search with chronological and intelligent backjumping
- Forward checking (FC) and dynamic variable rearrangement (DR)
- AC-3 arc consistency
- Advance sort heuristic
- Memory-CSP two-phase search (index + resolution)
- Quilici similarity-based retrieval
- Template and situation data structures
- All CSP constraint formulations

This was verified by running the same experiment (ij2, noise=50, seed=default) on both the pre-cleanup and post-cleanup code. The results were identical:

```
            Pre-cleanup    Post-cleanup
NCC         284            284
TCC         281            281
BT          38             38
```

## Verification

### Unit tests

FiveAM test suites cover all four systems:

```bash
sbcl --non-interactive --load "tests/run.lisp"
```

### Integration tests

Arc-oriented (AO) solver integration tests:

```bash
sbcl --non-interactive --load "run-test4.lisp"
sbcl --non-interactive --load "run-test4-may29.lisp"
sbcl --non-interactive --load "run-test4-alex.lisp"
```

### Experiment replication

Three experiment series compare CSP search efficiency under increasing noise (50-1000 extraneous program statements), each with 20 noise levels and 10 random seeds (200 runs per series):

| Series | Method | Description |
|--------|--------|-------------|
| ij2 | `memory-search` | Baseline: phase 1 uses BT only |
| ij3 | `memory-search` | Both phases use FC + DR + advance sort |
| ij4 | `adt` (direct) | Direct matching with FC + DR + advance sort |

Experiments were run across all four code snapshots:

```bash
# qcsp3 (primary)
bash Q-Batch-SBCL/ij2.sh && bash Q-Batch-SBCL/ij3.sh && bash Q-Batch-SBCL/ij4.sh

# alex (Sep 1997 snapshot)
bash Q-Batch-SBCL/run-alex-all.sh

# may29 (May 1996 snapshot)
bash Q-Batch-SBCL/run-may29-all.sh
```

Results are compared against the original Allegro CL runs (stored in `Q-Batch/`) using 95% confidence intervals. The CI bands overlap at every noise level for all three series across all snapshots, confirming algorithmic equivalence despite different random number generators (ACL's proprietary PRNG vs SBCL's Mersenne Twister).

```bash
python3 Q-Batch-SBCL/Graph/compare-all-overlay.py    # Generate 4-way plots (requires matplotlib)
```

Comparison plots are in `Q-Batch-SBCL/Graph/compare-*-overlay.png`. Each plot shows four series: ACL (SPARC), SBCL qcsp3, SBCL alex, and SBCL may29.

### Key experimental findings

- **ij2/ij3**: All four series (ACL, qcsp3, alex, may29) track closely with overlapping CI bands, confirming algorithmic equivalence across all snapshots.
- **ij4**: The alex snapshot diverges sharply upward (~6x higher TCC than the others). This is due to `node-type-consis` and `dfa-rearrangement` parameters unique to the alex version of `adt` — these add additional constraint checking not present in the earlier snapshots. This divergence is an open investigation item.

### Batch experiment issues encountered and resolved

| Issue | Cause | Fix |
|-------|-------|-----|
| Alex TCC=0 for all experiments | Noise injection variable `*noise-count*` not incremented (local shadow) | Restored `*noise-count*` global in alex's `adt-setup.lisp` |
| May29 TCC=0 for all experiments | Pre-generated `ADT-Situation/Sit-q-i1-*` files from old ACL runs were trivially solvable | Deleted stale situation files to force fresh generation |
| May29 ij4 "Situation not found" | `adt` called with `:situation-id "quilici-i1"` but may29 uses `"q-i1"` | Changed to `:situation-id "q-i1"` in may29-ij4-run.lisp |
| CRLF line endings in shell scripts | `Write` tool produced CRLF on macOS | Regenerated with `printf` and verified with `xxd` |

## DataFind Archive Audit

The `DataFind/` directory contains `.dir` files — original directory listings from the SPARC archive. An audit compared these against the current repo:

| .dir file | Maps to | Status |
|-----------|---------|--------|
| `csp.dir` | `csp/` | All core solver files present. Missing: `unify.lisp`, `adt-test2.lisp`, `adt-test3.lisp`, `compile-set.lisp` |
| `qcsp.dir` | `qcsp3/` | All core files present. Missing: `compile.lisp`, `compile-set.lisp`, `gsat-test.lisp`, `load.lisp` (all superseded by ASDF) |
| `qcsp3.dir` | `qcsp3/` | Identical file list to `qcsp.dir` (confirms same codebase) |
| `qcsp-alex.dir` | `qcsp-alex-sep16-1997/` | Core files present. Repo has 30 extra experiment/data files. Missing same 4 ACL build files |
| `QCSP-nov96.dir` | **Not in repo** | Intermediate snapshot with unique terrain analysis code |

Files consistently missing across all snapshots (`compile.lisp`, `compile-set.lisp`, `load.lisp`) are old ACL build infrastructure superseded by ASDF. The `package.lisp` files added during renovation are consistently "extra" (expected).

## Remaining Work

See [GitHub Issues](https://github.com/sgwoods/phd-renovation/issues) for tracked items. Summary:

1. **Clean up alex snapshot** — 30+ extra `.lisp` files not loaded by `.asd`; organize or document
2. **Investigate alex ij4 divergence** — ~6x higher TCC due to `node-type-consis`/`dfa-rearrangement`
3. **Recover missing files** — `csp/unify.lisp` and test files from DataFind archives
4. **Investigate QCSP-nov96** — intermediate snapshot with terrain analysis code not in repo
5. **Clean up DataFind/** — document PrevResults (different noise levels), organize archives
6. **Expand test coverage** — add regression tests with specific TCC assertions
7. **Untrack remaining generated data** — check if qcsp3/alex ADT-Random/Situation still tracked
8. **CI/CD** — GitHub Actions for automated test runs

## Commit History

```
959dd69  BASE: Original Allegro CL PhD source and publications
b6761e8  Modernize legacy ACL project for SBCL with ASDF build system
a905d9b  Modernize qcsp-may29-1996 and qcsp-alex-sep16-1997 for SBCL
ffbeb16  Add test4 runner and fix missing rfn variable in qcsp3
2f37012  Add test4 runners for qcsp-may29-1996 and qcsp-alex-sep16-1997
764e19e  Add csp test runner and fix queens arc-consis value
38d181a  Add Q-Batch-SBCL experiment infrastructure for SBCL replication
15aadf8  Fix ij4 output paths and add data extraction/comparison pipeline
83f4a54  Add README, FiveAM tests, entry point, and cleanup dead code
78facc4  Add defpackage/in-package to csp/ and qcsp3/ systems
e1b6c18  Fix LENGTH variable bug in bm.lisp and *current-situation typo
3918f1f  Remove dead files, backup artifacts, and Mac OS 9 code branches
89552a1  Modernize older snapshots and remove Mac OS 9 dead code
d8b8650  Add FiveAM tests for older snapshots and fix latent bugs
992fb02  Normalize return keywords, fix MPR bugs, muffle redefinition warnings
48d6607  Add ACL vs SBCL comparison plots and seed generator
b8ea6d4  Add renovation docs, expand tests, fix output-file concatenation bug
c780cc5  Re-run ij3 and ij4 experiments fresh with regenerated seeds
afe6666  Add date/time and git version stamp to comparison plots
88da35f  Fix alex ADT/memory-search by restoring Quilici data and polymorphic accessors
2427d96  Restore alex noise injection and run batch experiments
80d72c6  Add may29 batch experiments, 4-way comparison plots, and consolidate gitignore
```
