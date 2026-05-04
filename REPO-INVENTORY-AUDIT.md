# Repository Inventory Audit

This file answers two practical questions:

1. **What files are actually in this repo?**
2. **What other files, directories, caches, or tools does the project use or
   reference that are *not* in the repo, and why?**

It also records the current portability assessment from a fresh-clone audit.

## Executive Summary

- The repo currently has **7,635 tracked files** according to `git ls-files`.
- A generated snapshot of the full tracked file list currently lives at
  `REPO-FILE-LIST.txt`. That file is a local audit artifact, not canonical
  project source.
- The working repo on this MacBook is aligned at commit `dd6eaa1`
  with both `origin/main` and `origin/codex/fix-artifact-pipeline`.
- The full supported validation spine passes from the working repo on this
  machine.
- A local non-iCloud fresh clone can run the startup script successfully in
  `--skip-validation` mode.
- A full fresh-clone validation run currently exposes one remaining portability
  issue: SBCL/ASDF cache path creation under
  `~/.cache/common-lisp/.../private/tmp/...` fails for a clone under
  `/tmp/phd-renovation-portability-check`.

So the repo itself is healthy, but the "fresh clone anywhere, full validation
without adjustment" story is **close, not perfect**.

## Tracked File Inventory

### How to see the complete tracked file list

The authoritative file list is:

```bash
git ls-files
```

or equivalently:

```bash
rg --files
```

For this audit pass, I also generated:

```text
REPO-FILE-LIST.txt
```

which is a direct `git ls-files` snapshot from this working tree.

### Top-level tracked file counts

These counts come from `git ls-files` grouped by top-level path:

| Top-level area | Tracked file count | Read |
|---|---:|---|
| `qcsp-may29-1996/` | 3246 | Historical snapshot plus preserved batch/result subtrees |
| `data/` | 1971 | Preserved results, archives, thesis, and baseline data |
| `historical finds/` | 1481 | Recovery/provenance/context material |
| `qcsp-alex-sep16-1997/` | 703 | Historical snapshot with archive-heavy extras |
| `Q-Batch-SBCL/` | 97 | Modern experiment workspace plus tracked graph artifacts |
| `qcsp3/` | 33 | Primary integrated solver line |
| `tests/` | 31 | Supported validation and investigation harnesses |
| `csp/` | 18 | Base/reference solver snapshot |
| `docs/` | 9 | Generated dashboard/handbook/public-facing artifacts |
| `tools/` | 4 | Maintained build/generation helpers |
| `incoming/` | 4 | Intake workflow metadata and landing guidance |
| `src/` | 2 | Main interactive entry-point surface |

There are also a small number of repo-root tracked documents, ASDF systems,
and manual helper scripts.

### Main tracked file classes

The repo currently includes all of these classes of material:

1. **Core solver source**
   - `csp/`
   - `qcsp3/`
   - `qcsp-may29-1996/`
   - `qcsp-alex-sep16-1997/`
   - `src/`

2. **Supported validation and investigation harnesses**
   - `tests/`

3. **Preserved data and publication anchors**
   - `data/acl-experiments/`
   - `data/sparc-archive/`
   - `data/csp-adt-batch/`
   - `data/csp-batch/`
   - `data/csp-save-results/`
   - `data/thesis/`

4. **Tracked thesis graph artifacts**
   - `Q-Batch-SBCL/Graph/*.dat`
   - `Q-Batch-SBCL/Graph/*.all`
   - `Q-Batch-SBCL/Graph/*.p1`
   - `Q-Batch-SBCL/Graph/*.pdf`
   - tracked overlay PNGs

5. **Generated/public-facing docs now treated as first-class artifacts**
   - `docs/project-handbook.html`
   - `docs/public-phd-renovation-handbook.html`
   - `docs/release-dashboard.html`
   - `docs/public-phd-renovation.html`
   - `docs/public-status-phd-renovation.json`
   - thesis export copies under `docs/`

6. **Roadmap, recovery, intake, preservation, and release docs**
   - repo-root `*.md` governance/status artifacts

## What The Project Uses Or References Outside The Repo

This section is specifically about things the project depends on, reads, or
references that are **not checked into this repo**.

### 1. User-level Quicklisp install

| External path | Why it is not in the repo | Why the project uses it |
|---|---|---|
| `~/quicklisp/setup.lisp` | Quicklisp is a user/machine-level Common Lisp package manager, not project source | Required to load FiveAM and the test harnesses through SBCL |
| `~/quicklisp/` tree generally | Same reason; Quicklisp manages its own downloaded client and local distribution state | Provides Lisp dependency resolution during validation |

### 2. Companion public-site repo

| External path | Why it is not in the repo | Why the project uses it |
|---|---|---|
| `PHD_PUBLIC_SITE_DIR` if set | Separate repo by design | Target mirror location for generated public project artifacts |
| `~/GitPages/public` fallback | Companion repo is intentionally separate from the project repo | Lets the docs/status build publish into the Pages repo when present |

### 3. iCloud-backed convenience paths

| External path | Why it is not in the repo | Why the project uses or references it |
|---|---|---|
| `/Users/stevenwoods/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/incoming-landing` | Machine-local convenience path, not canonical project content | Raw drop zone for newly found incoming material |
| `/Users/stevenwoods/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/working-copy` | Separate local clone, not part of this clone | Handoff/backup experiment for a backed-up working location |

### 4. External runtime commands and toolchains

These are not repo files, but they are hard runtime dependencies of the
bootstrap and validation flow.

| External tool | Why it is not in the repo | Why the project uses it |
|---|---|---|
| `git` | System tool | clone/fetch/status/bootstrap workflows |
| `sbcl` | System tool | runs the solver and test suites |
| `python3` | System tool | graph extraction, doc generation, validations |
| Python `matplotlib` | Installed package, not vendored | plotting and some graph validations |
| `gs` (Ghostscript) | System tool | thesis PostScript export path |
| `rg` (ripgrep) | System tool | fast repo search and some operator workflows |
| `curl` | System tool | bootstrap fetch of Quicklisp installer |

### 5. Bootstrap fetch sources

| External reference | Why it is not in the repo | Why the project uses it |
|---|---|---|
| `https://beta.quicklisp.org/quicklisp.lisp` | External installer URL | Used by `scripts/start-codex-new-mac.sh --install-quicklisp` |
| `https://github.com/sgwoods/phd-renovation.git` | Remote origin, not local content | Canonical fresh-clone source |
| `https://github.com/sgwoods/public` | Separate repo | Public Pages publication target |

### 6. Local ignored/generated workspaces inside the repo tree

These are **inside the working tree**, but are intentionally not tracked.

| Ignored path family | Why it is not in the repo | Why the project may use it |
|---|---|---|
| `csp/ADT-Random/` | Generated workspace/cache | Local seed/state generation for older solver work |
| `csp/MPR-Random/`, `csp/MPR-Situation/` | Generated workspace/cache | Same for MPR |
| `qcsp3/ADT-Random/`, `qcsp3/ADT-Situation/`, `qcsp3/MPR-*` | Generated maintained-line workspaces | Debugging, generated state, bridge analysis |
| Equivalent May29/Alex random/situation dirs | Generated historical workspaces | Snapshot-local state generation/debugging |
| `Q-Batch-SBCL/ij2/`, `ij3/`, `ij4/` | Large generated run trees | Full local experiment regeneration mode |
| `Q-Batch-SBCL/alex-*`, `may29-*` | Generated run trees | Comparative experiment regeneration mode |
| `Q-Batch-SBCL/*.out` | Generated run outputs | Intermediate experiment outputs |
| `.venv/` | Local Python env | Convenience environment only |
| `.claude/` | Local app/tool state | Not project content |
| `.DS_Store` | Finder metadata | Machine noise |
| `*.fasl` | SBCL compiled outputs | Rebuildable compiler cache |
| `__pycache__/` | Python bytecode cache | Rebuildable interpreter cache |

### 7. SBCL / ASDF cache directories

| External path | Why it is not in the repo | Why it matters |
|---|---|---|
| `~/.cache/common-lisp/...` | User-level compile cache | SBCL/ASDF writes compiled cache artifacts here during system loads |

This path is especially important because it is where the fresh-clone
portability audit exposed the current remaining issue.

## What Is *Not* Missing

These classes of artifacts used by the supported thesis-validation flow are
now tracked and therefore **not** external requirements anymore:

- the canonical thesis graph tables under `Q-Batch-SBCL/Graph/`
- the comparison PDFs under `Q-Batch-SBCL/Graph/`
- the tracked overlay PNGs under `Q-Batch-SBCL/Graph/`
- the generated handbook/dashboard/public status artifacts under `docs/`

That was an intentional preservation upgrade.

## Current Deep Health Assessment

### 1. Repo hygiene

- Working repo status at the start of the health audit: clean
- Branch alignment: `HEAD`, `origin/main`, and
  `origin/codex/fix-artifact-pipeline` all at `dd6eaa1`
- Untracked files: none (`git ls-files -o --exclude-standard` returned empty)

This document itself and other audit artifacts may make the worktree dirty
until they are either committed or discarded.

### 2. Supported validation spine from the working repo

Passed on this MacBook:

- `python3 tools/generate-release-dashboard.py`
- `bash tests/validate-dashboard.sh`
- `sbcl --non-interactive --load tests/run.lisp`
- `bash tests/validate-artifacts.sh`
- `bash tests/validate-ff-provenance.sh`
- `bash tests/validate-adt-batch.sh`
- `bash tests/validate-csp-batch.sh`
- `bash tests/validate-ao.sh`

### 3. Fresh-clone bootstrap audit

#### What passed

A fresh local clone to `/tmp/phd-renovation-portability-check` successfully:

- cloned from the current repo,
- checked out `main`,
- ran `bash scripts/start-codex-new-mac.sh --skip-validation`,
- verified the main command dependencies on this machine,
- verified Quicklisp presence,
- and completed startup/bootstrap successfully outside the original working tree.

#### What failed

Running the **full** `bash scripts/start-codex-new-mac.sh` from that fresh
clone failed during SBCL/ASDF compilation, before any project-specific test
logic failed.

The key failure was:

- SBCL/ASDF attempted to create compiled cache directories under
  `~/.cache/common-lisp/.../private/tmp/phd-renovation-portability-check/...`
- directory creation failed with:
  `Can't create directory /Users/stevenwoods/.cache/common-lisp/.../private`

### 4. Current conclusion

The project is in a **healthy repo state** and has a **mostly working**
fresh-clone bootstrap story, but not yet a perfect "clone anywhere and run the
full validation spine with zero caveats" story.

The remaining portability issue is now narrow and concrete:

- **SBCL/ASDF cache-path behavior for fresh clones outside the original
  working tree**

That is the main thing still blocking a stronger portability claim.

## Current Recommendation

Treat the project as:

- healthy and trustworthy on this MacBook,
- fully committed and synchronized,
- ready for continued work,
- and close to portable,

but keep one explicit caveat:

- the full startup script still needs one more hardening pass for
  fresh-clone/full-validation SBCL cache behavior.

Once that is fixed, the portability story gets much stronger.
