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

Three experiment series compare CSP search efficiency under increasing noise (50-1000 extraneous program statements), each with 20 noise levels and 10 random seeds:

| Series | Method | Description |
|--------|--------|-------------|
| ij2 | `memory-search` | Baseline: phase 1 uses BT only |
| ij3 | `memory-search` | Both phases use FC + DR + advance sort |
| ij4 | `adt` (direct) | Direct matching with FC + DR + advance sort |

```bash
bash Q-Batch-SBCL/ij2.sh    # ~5 minutes
bash Q-Batch-SBCL/ij3.sh    # ~2 minutes
bash Q-Batch-SBCL/ij4.sh    # ~10 seconds
```

Results are compared against the original Allegro CL runs (stored in `Q-Batch/`) using 95% confidence intervals. The CI bands overlap at every noise level for all three series, confirming algorithmic equivalence despite different random number generators (ACL's proprietary PRNG vs SBCL's Mersenne Twister).

```bash
python3 Q-Batch-SBCL/Graph/extract-data.py           # Extract CIs
python3 Q-Batch-SBCL/Graph/compare-all-overlay.py    # Generate plots (requires matplotlib)
```

Comparison plots are in `Q-Batch-SBCL/Graph/compare-*-overlay.png`.

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
```
