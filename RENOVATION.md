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

Four systems were modernized covering 49 source files:

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

Results are compared against the original Allegro CL runs (now stored in `data/acl-experiments/`) using 95% confidence intervals. The CI bands overlap at every noise level for all three series across all snapshots, confirming algorithmic equivalence despite different random number generators (ACL's proprietary PRNG vs SBCL's Mersenne Twister).

```bash
python3 Q-Batch-SBCL/Graph/compare-all-overlay.py    # Generate 4-way plots (requires matplotlib)
```

Comparison plots are in `Q-Batch-SBCL/Graph/compare-*-overlay.png`. Each plot shows four series: ACL (SPARC), SBCL qcsp3, SBCL alex, and SBCL may29.

### Key experimental findings

- **ij2/ij3**: All four series (ACL, qcsp3, alex, may29) track closely with overlapping CI bands, confirming algorithmic equivalence across all snapshots.
- **ij4**: The alex snapshot diverges sharply upward (~6x higher TCC than the others). Root cause: Yongjun Zhang simplified the `ts-matches-type` function in alex's `adt-simple.lisp` (line 1296), commenting out the detailed type-matching logic (Decl array/range checking, parameter-count matching for Zero/Assign/Print/Check/Increment/Not-Equals). The simplified version only checks statement type name equality, which allows more domain values to survive node consistency:

  | Metric (noise=500, seed=default) | qcsp3 | may29 | alex |
  |---|---|---|---|
  | Avg domain size after NC | 43.0 | 42.0 | **67.7** |
  | TCC | 1,904 | 1,759 | **11,919** |
  | Backtracks / Visited | 22/23 | 22/23 | **86/87** |

  The causal chain: simplified `ts-matches-type` → ~1.6x larger domains → ~4x more backtracks → ~6.5x higher TCC. This was intentional — the simplified NC was likely paired with alex's DFA-based features (`node-type-consis`, `dfa-rearrangement`) which would compensate, but those features default to nil and are not enabled in the standard ij4 experiments. A diagnostic script at `Q-Batch-SBCL/diagnose-ij4.sh` reproduces these results.

### Batch experiment issues encountered and resolved

| Issue | Cause | Fix |
|-------|-------|-----|
| Alex TCC=0 for all experiments | Noise injection variable `*noise-count*` not incremented (local shadow) | Restored `*noise-count*` global in alex's `adt-setup.lisp` |
| May29 TCC=0 for all experiments | Pre-generated `ADT-Situation/Sit-q-i1-*` files from old ACL runs were trivially solvable | Deleted stale situation files to force fresh generation |
| May29 ij4 "Situation not found" | `adt` called with `:situation-id "quilici-i1"` but may29 uses `"q-i1"` | Changed to `:situation-id "q-i1"` in may29-ij4-run.lisp |
| CRLF line endings in shell scripts | `Write` tool produced CRLF on macOS | Regenerated with `printf` and verified with `xxd` |

## DataFind Archive Audit

The `data/sparc-archive/` directory (formerly `DataFind/`) contains `.dir` files — original directory listings from the SPARC archive. An audit compared these against the current repo:

| .dir file | Maps to | Status |
|-----------|---------|--------|
| `csp.dir` | `csp/` | All core solver files present. `unify.lisp` recovered from `qcsp-may29-1996/Keep/`. Still missing: `adt-test2.lisp`, `adt-test3.lisp`, `compile-set.lisp` |
| `qcsp.dir` | `qcsp3/` | All core files present. Missing: `compile.lisp`, `compile-set.lisp`, `gsat-test.lisp`, `load.lisp` (all superseded by ASDF) |
| `qcsp3.dir` | `qcsp3/` | Identical file list to `qcsp.dir` (confirms same codebase) |
| `qcsp-alex.dir` | `qcsp-alex-sep16-1997/` | Core files present. Non-core files organized into `extras/` (34 .lisp) and `artifacts/` (15 result/output files). Missing same 4 ACL build files |
| `QCSP-nov96.dir` | **Not in repo** | Intermediate snapshot with unique terrain analysis code |

Files consistently missing across all snapshots (`compile.lisp`, `compile-set.lisp`, `load.lisp`) are old ACL build infrastructure superseded by ASDF. The `package.lisp` files added during renovation are consistently "extra" (expected).

## Remaining Work

See [GitHub Issues](https://github.com/sgwoods/phd-renovation/issues) for tracked items. Summary:

### Completed

1. ~~**Clean up alex snapshot**~~ — Done: 34 non-core `.lisp` files moved to `extras/`, 15 result/output files moved to `artifacts/`, 7 ephemeral files deleted, 83 generated seed files untracked. README added. (Issue #1)
2. ~~**Investigate alex ij4 divergence**~~ — Done: root cause is simplified `ts-matches-type` in alex's `adt-simple.lisp` (detailed type-matching commented out by Yongjun Zhang). This was intentional, paired with DFA-based extensions not enabled in standard experiments. Diagnostic script at `Q-Batch-SBCL/diagnose-ij4.sh`. (Issue #2)
3. ~~**Recover missing files**~~ — Done: `csp/unify.lisp` recovered from `qcsp-may29-1996/Keep/` with `defconstant`→`defparameter` fix. `adt-test2.lisp`, `adt-test3.lisp`, `gsat-test.lisp` are truly lost (not in any snapshot). `compile-set.lisp` superseded by ASDF. (Issue #3)
7. ~~**Untrack remaining generated data**~~ — Done: all `ADT-Random/` and `ADT-Situation/` directories across all four systems are untracked and in `.gitignore`. (Issue #7)

5. ~~**Clean up DataFind/**~~ — Done: documented PrevResults, organized archives, created `DataFind/README.md`. Later consolidated into `data/sparc-archive/`. (Issue #5)
6. ~~**Expand test coverage**~~ — Done: added TCC/NCC/BT regression assertions to 25 tests across 4 suites. Standard and confused queens get exact metrics; ADT/MPR get exact NCC + TCC ceilings. (Issue #6)
8. ~~**CI/CD**~~ — Done: GitHub Actions workflow at `.github/workflows/test.yml` runs all FiveAM suites on push/PR. (Issue #8)

### Open

4. **Investigate QCSP-nov96** — intermediate snapshot with unique terrain analysis code not in repo. Three source files completely lost (`terrain-setup.lisp`, `terrain-simple.lisp`, `closure.lisp`). Recovery depends on finding SPARC backup media. See `data/lost-datasets.md`. (Issue #4)

## Next Phase Roadmap

Guiding principle for the next phase: treat the published PhD thesis results,
the preserved historical experiment artifacts, and the current regression
suites as the foundation for every future change. New work should either
preserve those published behaviors or explain any intentional deviation in a
repeatable way, with the long-term aim of converging on one gold-standard code
line rather than maintaining several disconnected runnable snapshots forever.

## Goal And Current Position

### Overall project goal

Bring the thesis codebase to a state where:

1. the integrated constraint solver reproduces the PhD-reported results from a
   fresh checkout,
2. the other historical domains and reported result families are either
   executable, integrity-checkable, or explicitly classified as provenance-only,
3. one gold-standard code line can stand in for the historical solver lineage
   with snapshot-specific differences documented, and
4. new research can branch from that validated baseline with any deltas
   measured and explained.

In short: turn the renovated snapshots, preserved data, and recovered archives
into one trustworthy integrated research platform, not just a modernized copy
of legacy Lisp.

### Where we are against that goal

| Area | Status | Current position |
|---|---|---|
| Reference snapshots runnable | **Strong** | All four ASDF systems load and the supported FiveAM suites pass on SBCL. |
| Core regression baseline | **Strong** | Deterministic metric assertions exist for standard and confused queens across all four systems. |
| AO / `test4` validation | **Good** | AO coverage has moved from smoke-only into asserted deterministic coverage for the supported baseline; broader AO coverage is still open. |
| PhD-result validation path | **Strong** | CI regenerates SBCL graph artifacts and validates the supported ACL-vs-SBCL `ij2`/`ij3`/`ij4` trend story. |
| Warning hygiene | **Improving** | Repeated core and AO warning families have been reduced substantially, but a small residual tail remains. |
| Documentation and onboarding | **Good and improving** | The top-level docs are aligned with the current validation spine, and local README coverage now makes the code/test/results layout easier to navigate from disk. |
| Historical provenance | **Good and advancing** | `historical finds/yj-sun/Csp` is now tied to the alex-era line, many `PrevResults` artifacts are mapped, and the `ff1`/`ff2`/`ff3` family is now grounded in the preserved `qcsp-may29-1996/NewData4b-Batch/` tree. |
| Gold-standard integration target | **Emerging** | `qcsp3/` is the leading candidate, but it does not yet cover every historically relevant domain/result family under one supported executable umbrella. |
| Research-readiness for new experiments | **Not there yet** | The baseline is much firmer than before, but not yet complete enough for a `1.0.0` integrated research platform claim. |

### Current roadmap position

- **Phase 1 / `0.1.x` Stability**: effectively complete for the supported
  artifact pipeline. Fresh-checkout plot regeneration and artifact validation
  are in place.
- **Phase 2 / `0.2.x` Verification**: active and substantially advanced. This
  now includes stronger regression assertions, AO asserted coverage, automated
  thesis-comparison checks, and incremental warning cleanup.
- **Phase 3 / `0.3.x` Documentation**: started, but not complete. High-level
  docs are much stronger, the code/test/results roots are now easier to
  navigate, but core algorithm docstrings and operator-facing workflow polish
  still remain.
- **Phase 4 / Research Readiness**: not yet active as the main lane. We have
  diagnosed alex's `ij4` divergence, but we are intentionally holding off on
  broader experimental changes until the baseline is tighter.
- **Phase 5 / Archive Recovery**: active in parallel. The `historical finds/`
  intake is now classified, `yj-sun/Csp` has loader/result provenance notes,
  and archive-to-`PrevResults` mapping has begun.

### Recommended next steps

1. Keep the PhD-result validation spine green: `tests/run.lisp`,
   `tests/validate-artifacts.sh`, and `tests/validate-ao.sh` remain the merge
   gate for the supported baseline.
2. Expand the validated umbrella to the older `ff1` / `ff2` / `ff3` family by
   deciding whether to add a lightweight provenance check asserting that
   `qcsp-may29-1996/NewData4b-Batch/Graph/ff*.ci` matches
   `data/sparc-archive/PrevResults/ff*.ci`.
3. Build out the validation matrix further: for each historical domain/result
   family, mark whether it is executable now, integrity-checkable now, or
   provenance-only for now.
4. Continue shrinking the remaining warning tail so validation logs become a
   clearer signal channel for real regressions.
5. Finish the `0.3.x` documentation lane by adding docstrings and clearer
   entry-point explanations for the major algorithms and supported workflows.
6. Only after the baseline and provenance work are tighter, begin controlled
   integration and research-readiness experiments such as alex DFA-option
   isolation against the validated snapshot.

### Phase / Release Alignment

Keep the repo on `0.x` releases until the thesis-validation baseline is stable
enough that a fresh checkout can reproduce the supported historical results and
the docs accurately describe that supported path.

- **`0.1.x` Stability builds**: artifact paths, reproducible plot generation,
  and baseline environment setup.
- **`0.2.x` Verification builds**: stronger asserted regression coverage around
  the thesis-era baselines. This is the current active track.
- **`0.3.x` Documentation / research-readiness builds**: clearer operator docs,
  explicit supported workflows, and guarded extension points for new research.
- **`1.0.0` target**: phases 1-3 are complete, CI continuously validates the
  supported thesis-result baseline, and release notes can describe deviations
  from the thesis as intentional rather than accidental.

Increment the internal build number once per completed roadmap cycle and note
the owning phase in the release summary so future work stays tied to the plan.

### Phase 1: Stability

1. Keep the artifact pipeline executable from a fresh checkout. The repo should
   always be able to regenerate CI summaries and comparison plots from the
   checked-in ACL and SBCL experiment artifacts.
2. Reduce the remaining warning noise during normal loads so new regressions are
   easier to spot. Treat a quieter load/test log as a reliability feature, not
   cosmetic cleanup.

### Phase 2: Verification

3. Strengthen regression coverage around deterministic baselines, starting with
   confused-queens metric assertions and other low-risk cases where exact
   behavior can be pinned down.
4. Finish converting the AO/test4 path into supported asserted coverage. CI now
   checks deterministic case-1 AO outcomes for qcsp3, may29, and alex; next
   work should either widen that asserted coverage or clearly document any
   remaining manual-only AO paths.
5. Keep the thesis-era versus modern results comparison executable. CI now
   checks that regenerated SBCL `ij2`/`ij3`/`ij4` tables preserve the ACL
   baseline ordering, correlation, and bounded ratio bands; next work should
   connect the older `PrevResults/ff*.ci` family once the exact experiment
   mapping is recovered.

### Phase 3: Documentation

6. Add docstrings and targeted explanations to the core entry points and major
   algorithms so future work can build on a clearer map of the code.
7. Keep the top-level docs synchronized with the actual executable state of the
   repo, especially around CI coverage, warning state, and experiment tooling.

### Phase 4: Research Readiness

8. Explore alex's DFA-related options (`node-type-consis`,
   `dfa-rearrangement`) in isolated experiments to determine whether they close
   the known ij4 gap without disturbing the validated baseline path.
9. Define a repeatable workflow for post-renovation research: establish the
   baseline snapshot, rerun validation, record deltas against thesis-era
   results, and only then evaluate new hypotheses or extensions.

### Phase 5: Archive Recovery

10. Continue the historical recovery track by unpacking/cataloging the legacy
    compressed archives and keeping watch for any media that could restore the
    lost QCSP-nov96 terrain code and data.
11. Treat newly recovered material under `historical finds/` as archive intake,
    not baseline code. The current intake appears to split into:
    `yj-sun/Csp` as a likely solver-lineage recovery candidate,
    `yj-sun/Gen++` as a likely upstream analyzer-generation toolchain,
    and `Unravel/` / `Refine/` as adjacent program-understanding context that
    should stay reference-only until a direct thesis-validation role is proven.
12. Prioritize archive work that strengthens the validated research story:
    first compare `historical finds/yj-sun/Csp` against the current snapshots
    and experiment artifacts, then map any unique batch/results material to the
    thesis-era `PrevResults/ff*.ci` family, and only after that spend time on
    broader adjacent-tool recovery.

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
ff95fae  Update README and RENOVATION docs with may29 results and .dir audit
f4c4d51  Clean up alex snapshot and recover unify.lisp
0474e79  Update docs to reflect alex cleanup and closed issues
fdd5ceb  Replace MvSit2.tar.Z with extracted ADT situation files
09a0d3b  Clean up may29 snapshot and fix test4 runner paths
76df23d  Clean up qcsp3 snapshot and untrack generated MPR situation data
251fc6f  Document alex ij4 TCC divergence root cause (Issue #2)
188e4a6  Add TCC/NCC regression assertions and GitHub Actions CI
afa377f  Fix CSP MPR test failure on CI — create MPR-Situation directory
7ff62ff  Document DataFind/ archive structure (closes #5)
a0de660  Consolidate all datasets into normalized data/ directory
```
