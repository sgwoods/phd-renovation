# Recovery And Reproducibility

This file answers a practical continuity question:

**If this local working directory disappeared today, could the project be
recreated on a new machine without redoing the work?**

Short answer: **yes, if we keep treating the checked-in repo plus the companion
public repo as the durable record and avoid relying on local-only generated
state.**

## Precise Goal

The project goal at this stage is:

1. keep one integrated constraint-solver baseline that preserves the
   PhD-reported `ij2` / `ij3` / `ij4` story,
2. keep the other historical domains and result families either executable,
   integrity-checkable, or explicitly bounded as snapshot-specific /
   provenance-only,
3. maintain enough documentation, generated status artifacts, and preserved
   data that the work can be resumed from a fresh checkout rather than from
   fragile local context, and
4. make the next major phase the disciplined intake, de-duplication, and
   categorization of newly found material.

## Current Project State

As of this recovery audit checkpoint:

- `v1.0.0` is the published first stable release marker.
- `main` should be treated as the durable recovery baseline once it is aligned
  with the current working branch.
- `codex/fix-artifact-pipeline` remains the active working branch for ongoing
  changes, but it should no longer be the only branch that contains the real
  project state.
- The repo working tree is clean.
- The public companion site is a separate repo:
  `https://github.com/sgwoods/public`
- The supported validation spine is the practical continuity gate:
  - `tests/run.lisp`
  - `tests/validate-artifacts.sh`
  - `tests/validate-ff-provenance.sh`
  - `tests/validate-adt-batch.sh`
  - `tests/validate-csp-batch.sh`
  - `tests/validate-ao.sh`
  - `tests/validate-dashboard.sh`

## Status Read

The project is now in a post-`1.0.0` hardening state:

- the main solver line is stable,
- the supported thesis-result baseline is executable,
- major preserved historical families are either executable or
  integrity-checkable,
- the docs/dashboard/handbook/public-page stack is generated from tracked
  source,
- and the next major lane is intake review rather than solver rescue.

Recommended next steps from this point are:

1. treat `incoming/` as the main operational lane for newly found material,
2. classify each new find as executable, integrity-checkable,
   provenance-only, or duplicate,
3. target `1.0.1` for remaining STYLE-WARNING cleanup outside the supported
   release gate,
4. keep terrain and `Hanoi-4` explicitly bounded as deferred lanes,
5. and avoid widening the supported baseline casually.

## What Is Checked In

The current repo already checks in the material needed to resume work on a new
machine:

### Core source and snapshots

- `csp/`
- `qcsp3/`
- `qcsp-may29-1996/`
- `qcsp-alex-sep16-1997/`
- `src/`

### Validation and investigation harnesses

- the maintained regression suites under `tests/`
- the supported validation scripts
- the ADT bridge investigation scripts and notes

### Preserved data and publication anchors

- `data/acl-experiments/`
- `data/sparc-archive/`
- `data/csp-adt-batch/`
- `data/csp-batch/`
- `data/csp-save-results/`
- `data/thesis/` including the canonical thesis PDF

### Tracked generated/public-facing artifacts

- `docs/release-dashboard.html`
- `docs/project-handbook.html`
- `docs/public-phd-renovation.html`
- `docs/public-phd-renovation-handbook.html`
- `docs/public-status-phd-renovation.json`
- `docs/phd-renovation-thesis.pdf`
- `docs/phd-renovation-thesis.ps`

### Tracked project-state documentation

- `RENOVATION.md`
- `REPOSITORY-STATUS.md`
- `VALIDATION-MATRIX.md`
- `WORKFLOWS.md`
- `DOCS-COVERAGE-REVIEW.md`
- `DUPLICATES-REVIEW.md`
- `HANOI-4-STATUS.md`
- `RELEASE-1.0-CHECKLIST.md`
- `RELEASE-1.0.0-NOTES.md`
- and the local README layer across the major directories

## What Is Intentionally Not Checked In

The repo also intentionally leaves a large amount of generated working state
out of git.

That is expected and, at this point, acceptable.

### Ignored generated workspaces

From `.gitignore`, these are intentionally untracked:

- `csp/ADT-Random/`
- `csp/MPR-Random/`
- `csp/MPR-Situation/`
- `qcsp3/ADT-Random/`
- `qcsp3/ADT-Situation/`
- `qcsp3/MPR-Random/`
- `qcsp3/MPR-Situation/`
- the equivalent May29 and Alex random/situation workspaces
- `Q-Batch-SBCL/ij2/`, `ij3/`, `ij4/`
- `Q-Batch-SBCL/alex-*` and `may29-*` run trees
- `Q-Batch-SBCL/*.out`
- `Q-Batch-SBCL/Graph/*.dat`, `*.all`, `*.p1`, `*.pdf`

These are rebuildable or intentionally treated as working-state caches rather
than canonical source artifacts.

### Local-only environment noise

Also intentionally untracked:

- `.venv/`
- `.DS_Store`
- `.claude/`
- compiled Lisp artifacts like `*.fasl`

These are not part of the project baseline.

## Can The Work Be Recreated On A New Machine?

### For the main repo work: yes

A new machine can recover the practical project state if it does all of the
following:

1. clone `https://github.com/sgwoods/phd-renovation.git`
2. start from `main`, then check out the active working branch only if newer
   unreleased work is needed
3. install the required runtime tools:
   - SBCL
   - Quicklisp
   - Python 3
   - `matplotlib`
   - Ghostscript (`gs`) for thesis PostScript export
4. run the supported validation spine

That is enough to continue the main work without reconstructing the history by
hand.

### For the public site publication path: yes, but it is a companion repo

Public publication is not stored only in this repo.

It depends on the separate repo:

- `https://github.com/sgwoods/public`

This project now supports a portable sync path:

- if `PHD_PUBLIC_SITE_DIR` is set, the docs/status build will mirror the
  generated public assets there
- otherwise it falls back to `~/GitPages/public` if that directory exists
- if neither exists, the repo-local generated outputs still build and validate

So a new machine can continue the public publishing workflow, but it should
also clone the public companion repo and point `PHD_PUBLIC_SITE_DIR` at it.

## Remaining Reproducibility Risks

The main risks are no longer "missing code" risks. They are workflow risks:

1. **Public companion repo risk**
   The deployed Pages site lives in `sgwoods/public`, not only here.

2. **Generated-cache expectations**
   Some ignored random/situation and experiment-output trees will need to be
   regenerated rather than recovered byte-for-byte from git.

3. **Future incoming-material risk**
   New finds that are only dropped locally and not promoted or documented in
   `incoming/INDEX.md` would be easy to lose.

4. **Non-backed-up local working directory risk**
   A clone that lives only in a non-backed-up local folder is still more
   fragile than necessary even if the remote repos are current.

## What To Do To Be Confident

To be confident that no work has to be redone, treat this as the minimum
continuity checklist:

1. keep the working branch pushed,
2. keep the public companion repo pushed when public-facing assets change,
3. put every new archival find through `incoming/`,
4. keep `incoming/INDEX.md` and the status artifacts current,
5. keep the validation spine green,
6. avoid relying on local generated caches as if they were canonical data, and
7. prefer future local working clones inside an iCloud-backed parent folder on
   this machine once the current baseline/branch layout is settled.

## Local Working Directory Convention

Going forward, the preferred local convention should be:

1. keep the canonical git history in GitHub,
2. keep the public-facing Pages artifacts in the companion public repo,
3. and keep active local working directories on this machine inside an
   iCloud-backed parent folder.

That does **not** replace git. It is simply a second layer of local continuity
for the working checkout itself.

The practical time to adopt that convention is after the branch/default-branch
alignment and current intake/status cleanup are complete, so the move does not
interrupt active stabilization work.

## Recommended Next Steps

From this recovery checkpoint, the best next steps are:

1. keep `main` aligned with the durable recovery baseline,
2. make intake, de-duplication, and categorization the main active lane,
3. add a short bootstrap/recovery checklist to the main project page for human
   operators,
4. adopt the iCloud-backed local working-directory convention for future clones
   on this machine,
5. use `1.0.1` for STYLE-WARNING cleanup and small release-hardening polish,
6. and only then reopen larger deferred lanes like terrain recovery and
   `Hanoi-4` behavior work.
