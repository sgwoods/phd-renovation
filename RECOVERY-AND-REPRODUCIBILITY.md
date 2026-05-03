# Recovery And Reproducibility

This file answers a practical continuity question:

**If this local working directory disappeared today, could the project be
recreated on a new machine without redoing the work?**

Short answer: **yes, with a few explicit rules and one important branch
warning.**

The key warning is this:

- the durable working line is **not** `main`
- the durable working line is the pushed branch
  `codex/fix-artifact-pipeline`
- `main` is still intentionally behind at the earlier onboarding checkpoint

If someone clones only `main`, they will **not** recover the current project
state.

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

As of this recovery audit:

- `v1.0.0` is the published first stable release marker.
- The active working branch is `codex/fix-artifact-pipeline`.
- The default branch `main` is still at the older onboarding-era checkpoint
  and should **not** be treated as the current working baseline.
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
2. check out `codex/fix-artifact-pipeline` rather than stopping at `main`
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

1. **Wrong branch risk**
   Resuming from `main` instead of `codex/fix-artifact-pipeline` would lose
   the real current state.

2. **Public companion repo risk**
   The deployed Pages site lives in `sgwoods/public`, not only here.

3. **Generated-cache expectations**
   Some ignored random/situation and experiment-output trees will need to be
   regenerated rather than recovered byte-for-byte from git.

4. **Future incoming-material risk**
   New finds that are only dropped locally and not promoted or documented in
   `incoming/INDEX.md` would be easy to lose.

## What To Do To Be Confident

To be confident that no work has to be redone, treat this as the minimum
continuity checklist:

1. keep the working branch pushed,
2. keep the public companion repo pushed when public-facing assets change,
3. put every new archival find through `incoming/`,
4. keep `incoming/INDEX.md` and the status artifacts current,
5. keep the validation spine green,
6. and avoid relying on local generated caches as if they were canonical data.

## Recommended Next Steps

From this recovery checkpoint, the best next steps are:

1. decide whether `main` should be advanced to the current working baseline or
   whether the branch-first workflow is intentional for a while longer,
2. make intake, de-duplication, and categorization the main active lane,
3. add a short bootstrap/recovery checklist to the main project page for human
   operators,
4. use `1.0.1` for STYLE-WARNING cleanup and small release-hardening polish,
5. and only then reopen larger deferred lanes like terrain recovery and
   `Hanoi-4` behavior work.
