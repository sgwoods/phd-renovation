# Repository Structure Review

This file reviews whether the repository layout makes it clear:

1. what the primary system artifacts are,
2. what defines domains and example generation,
3. what counts as outputs, preserved results, and graphs, and
4. what remains non-tested, non-integrated, or archive-only.

Short answer: **the repo is much clearer than it was, but a few mixed-purpose
areas still require insider knowledge.**

For the shortest current/reference/archive/deprecated map, see
`WORK-AREA-STATUS.md`.

## Top-Level Classification

| Path | Primary role | Current clarity |
|---|---|---|
| `qcsp3/` | Primary integrated solver candidate | Good |
| `csp/` | Earliest reference snapshot | Good |
| `qcsp-may29-1996/` | Reference snapshot plus embedded historical experiment trees | Mixed |
| `qcsp-alex-sep16-1997/` | Reference snapshot plus archive-heavy experiment/tooling material | Mixed |
| `tests/` | Supported validation spine | Strong |
| `Q-Batch-SBCL/` | Modern experiment drivers plus generated outputs | Mixed |
| `incoming/` | Single intake bucket for newly found relevant material | Strong |
| `data/` | Consolidated preserved data/results/publications | Strong |
| `historical finds/` | Archive intake and recovery staging | Good |
| `docs/` | Generated status/dashboard/public-page outputs | Good |
| `src/` | Modern interactive entry point | Strong |
| Root helper scripts | Legacy/manual entry points and bootstrap helpers | Mixed |

## What Is Already Clear

### Primary System Artifacts

These are reasonably easy to identify now:

| Area | Why it is clear |
|---|---|
| `qcsp3/`, `csp/`, `qcsp-may29-1996/`, `qcsp-alex-sep16-1997/` | Snapshot names, ASDF files, and README coverage make the solver lineage visible. |
| `tests/` | Clearly framed as the supported validation surface. |
| `src/main.lisp` | Clear REPL-oriented entry point. |
| `data/` | Consolidated preserved data/results catalog with a strong README. |

### Domain Definitions

Within each solver snapshot, the domain split is mostly legible:

| File family | Meaning |
|---|---|
| `queens.lisp` | Queens / confused-queens domain |
| `adt-simple.lisp` + `adt-setup.lisp` | ADT matching domain and its data/setup |
| `mpr-simple.lisp` + `mpr-setup.lisp` | MPR domain and its data/setup |
| `memory-csp.lisp`, `quilici-search.lisp`, `bm.lisp`, `bt.lisp` | Solver/search strategies rather than domain definitions |

### Preserved Results vs Active Validation

This is now understandable at a high level:

| Area | Meaning |
|---|---|
| `Q-Batch-SBCL/` | Active modern experiment control surface |
| `data/acl-experiments/` | Preserved ACL thesis-era baseline |
| `data/csp-adt-batch/`, `data/csp-batch/`, `data/csp-save-results/` | Preserved historical result families |
| `historical finds/` | Recovered archive material, not yet promoted |

## Where The Structure Is Still Doing Too Much Work

### 1. `Q-Batch-SBCL/` mixes code, tracked outputs, and scratch data

This directory is useful but not self-evident at a glance because it contains:

- tracked experiment drivers,
- tracked graph scripts,
- tracked comparison PNGs,
- and runtime-generated run directories and extracted graph tables.

The README explains this, but the directory still behaves like both `experiments/`
and `artifacts/` at once.

### 2. Historical snapshot roots mix source, generated runtime data, and preserved archives

This is especially true in:

- `qcsp-may29-1996/`
- `qcsp-alex-sep16-1997/`

For example, `qcsp-may29-1996/` contains source files alongside `Q-Batch/`,
`NewData*` batches, `ADT-SituationMar96/`, and other embedded historical
artifacts. That is historically faithful, but structurally mixed.

One reviewed exception is now explicitly marked in-place:
`qcsp-may29-1996/Q-Batch/` is a preserved duplicate of
`data/acl-experiments/`, retained for snapshot integrity rather than active use.

### 3. Root-level legacy helper scripts are easy to overread

Files like:

- `run-test4.lisp`
- `run-test4-may29.lisp`
- `run-test4-alex.lisp`
- `run-csp-tests.lisp`
- `renovate.lisp`

are still valuable, but they look more “primary” than they really are. In the
current repo they are secondary/manual helpers, not the main supported flow.

### 4. Some directory names are historically accurate but semantically opaque

Examples:

- `Q-Batch-SBCL/`
- `NewData4a-Batch/`, `NewData4b-Batch/`, `NewData5-Batch/`
- `Q-Batch-Freeze/`
- `MyBatch/`
- `artifacts/` inside snapshots

These names preserve provenance, which is good, but they do not explain their
role without documentation.

### 5. `historical finds/` is accurate but awkward as a pathname

The name is understandable to humans, but the space in the directory name adds
friction for shell work and scripting.

## Recommended Classification Model

Going forward, read the repo through these buckets:

### A. Supported integrated line

- `qcsp3/`
- `tests/`
- `Q-Batch-SBCL/`
- active status outputs in `docs/`
- thesis baseline inputs under `data/acl-experiments/`

### B. Reference snapshots

- `csp/`
- `qcsp-may29-1996/`
- `qcsp-alex-sep16-1997/`

### C. Preserved result families

- `data/csp-adt-batch/`
- `data/csp-batch/`
- `data/csp-save-results/`
- `data/sparc-archive/PrevResults/`
- embedded batch trees such as `qcsp-may29-1996/NewData4b-Batch/`

### D. Archive recovery / provenance intake

- `incoming/`
- `historical finds/`
- `data/motors-releases/`
- `data/motors-backups/`
- `data/lost-datasets.md`

### E. Manual compatibility helpers

- root `run-test4*.lisp`
- `run-csp-tests.lisp`
- `renovate.lisp`

## Recommendations

### Low-risk, do-now documentation moves

1. Keep `REPOSITORY-STATUS.md` and this file linked from `README.md`.
2. Keep `DOCS-COVERAGE-REVIEW.md` current as the explicit record of what is
   now well-covered versus still thin.
3. Add one short top-level note in `README.md` that root `run-test4*.lisp`,
   `run-csp-tests.lisp`, and `renovate.lisp` are manual compatibility helpers.
4. Add one short note in snapshot READMEs clarifying which subdirectories are:
   source, runtime-generated data, preserved results, and archive/context.
5. Keep all new finds landing in `incoming/` first, then promote them only
   after review.

### Medium-risk, defer-until-worth-it structure moves

1. Consider an eventual rename or alias scheme for mixed workspaces such as
   `Q-Batch-SBCL/` only if the historical name stops paying its way.
2. Consider a future `manual/` or `compat/` home for root helper scripts, but
   only if that does not break established references or provenance.
3. Consider a future no-space alias for `historical finds/` if automation
   pressure grows.

### Do not do casually

1. Do not flatten embedded historical batch trees out of snapshot directories
   just to make the layout prettier.
2. Do not rename historically meaningful directories like `NewData4b-Batch/`
   unless the repo adds a carefully documented alias/mapping layer.
3. Do not mix archive-intake material into the supported integrated line
   without first promoting it through validation/provenance work.

## Bottom Line

The repository already tells a coherent story if you know where to start:
`qcsp3/`, `tests/`, `Q-Batch-SBCL/`, `data/`, and the roadmap files.

What remains structurally confusing is not the solver core. It is the
historical overlap between:

- source vs embedded results inside snapshot roots,
- tracked experiment infrastructure vs generated outputs,
- and manual compatibility helpers vs supported workflows.

That means the next best improvements are documentation and labeling, not
aggressive directory surgery.
