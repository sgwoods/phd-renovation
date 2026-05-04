# Recovery And Reproducibility

This file answers a practical continuity question:

**If this local working directory disappeared today, could the project be
recreated on a new machine without redoing the work?**

Short answer: **yes, if we keep treating the checked-in repo plus the companion
public repo as the durable record and avoid relying on local-only generated
state.**

The guiding retention rule behind that answer is documented separately in
`PRESERVATION-POLICY.md`: potentially useful project information should be
classified and preserved, not discarded merely because it is not yet fully
integrated.

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
- `codex/fix-artifact-pipeline` is the active working branch for ongoing
  changes.
- `main` must stay aligned with the durable current state if fresh clones are
  expected to land on the right baseline directly.
- The startup/handoff path for a different Mac is now documented in
  `NEW-MAC-HANDOFF.md` and implemented in `scripts/start-codex-new-mac.sh`.
- A fresh-clone bootstrap proof has passed in non-iCloud form, while the
  iCloud-backed working-clone experiment exposed Git worktree friction on a
  different Mac and should not currently be treated as the preferred active
  clone model.
- The repo working tree should be kept clean at handoff checkpoints.
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

1. keep this MacBook repo as the known-good active baseline until the next
   machine has a clean non-iCloud working clone,
2. treat `incoming/` as the main operational lane for newly found material,
3. classify each new find as executable, integrity-checkable,
   provenance-only, or duplicate,
4. target `1.0.1` for remaining STYLE-WARNING cleanup outside the supported
   release gate,
5. keep terrain and `Hanoi-4` explicitly bounded as deferred lanes,
6. harden the fresh-clone/full-validation path around the current SBCL/ASDF
   cache-path issue, and
7. avoid widening the supported baseline casually.

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
- the tracked thesis-result graph tables and visual outputs under
  `Q-Batch-SBCL/Graph/`

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

The artifact validator now supports a fresh-clone fallback mode: if ignored
local experiment run trees are absent, it validates the tracked graph tables,
tracked overlay/report artifacts, and thesis-comparison outputs instead of
pretending it can re-extract from local caches that are not part of git.

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

5. **Preservation-discipline risk**
   Future finds that are reviewed informally but not routed through
   `incoming/`, `DUPLICATES-REVIEW.md`, or another tracked destination would
   weaken the project's long-term recoverability.

## What To Do To Be Confident

To be confident that no work has to be redone, treat this as the minimum
continuity checklist:

1. keep the working branch pushed,
2. keep the public companion repo pushed when public-facing assets change,
3. put every new archival find through `incoming/`,
4. keep `incoming/INDEX.md` and the status artifacts current,
5. keep the validation spine green,
6. avoid relying on local generated caches as if they were canonical data, and
7. keep potentially useful historical material under the preservation policy
   rather than treating uncertainty as a reason to discard it, and
8. prefer future local working clones inside an iCloud-backed parent folder on
   this machine once the current baseline/branch layout is settled.

## Local Working Directory Convention

Going forward, the preferred local convention should be:

1. keep the canonical git history in GitHub,
2. keep the public-facing Pages artifacts in the companion public repo,
3. keep raw intake and backup-oriented material in iCloud-backed locations,
   but use a non-iCloud active Git working clone on new machines unless and
   until iCloud worktree behavior is proven reliable there.

The existing iCloud helper remains useful for backup/reference clone
management:

`scripts/use-icloud-working-copy.sh`

The preferred project-specific iCloud path for new local intake work is:

`/Users/stevenwoods/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/`

with the raw-drop handoff directory at:

`/Users/stevenwoods/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/incoming-landing/`

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
