# 1.0 Release Checklist

This file is the concrete punch list for the first `1.0.0` release.

It turns the current roadmap into a release gate we can actually close.

## What `1.0.0` Means

`1.0.0` does **not** mean every preserved historical family is fully rerunnable
through one code path.

It means:

1. the supported thesis-result baseline is executable from a fresh checkout,
2. the supported integrated solver story is honest and bounded,
3. the major preserved historical families are either executable,
   integrity-checkable, or explicitly deferred,
4. the repo/public documentation accurately describes that scope, and
5. release notes can explain remaining deltas as intentional rather than
   accidental.

## In Scope For `1.0.0`

- `qcsp3/` as the operational center of the supported integrated line
- supported thesis `ij2` / `ij3` / `ij4` validation path
- bounded AO baseline
- `ff*` integrity/provenance relationship
- ADT batch and DREV-era `T1`-`T6` as preserved integrity-checkable families
- clear status artifacts, handbook, dashboard, and public project page
- explicit deferred-lane documentation for terrain and `Hanoi-4`

## Explicitly Out Of Scope For `1.0.0`

- full terrain-domain recovery
- full `Hanoi-4` behavior/repeatability closure
- forcing snapshot-specific preserved families into `qcsp3/` when they are
  better treated as documented archives
- broader post-M1 research experiments such as alex DFA-option exploration as
  a release blocker

## Required Validation Gate

These must pass for a `1.0.0` release candidate:

```bash
sbcl --non-interactive --load "tests/run.lisp"
bash tests/validate-artifacts.sh
bash tests/validate-ff-provenance.sh
bash tests/validate-adt-batch.sh
bash tests/validate-csp-batch.sh
bash tests/validate-ao.sh
bash tests/validate-dashboard.sh
```

## Required Status / Docs Conditions

- [x] `README.md`, `RENOVATION.md`, `VALIDATION-MATRIX.md`, and
      `REPOSITORY-STATUS.md` agree on current scope
- [x] `M1-READINESS.md`, `INTEGRATION-DELTAS.md`, and
      `HANOI-4-STATUS.md` reflect current accepted boundaries
- [x] `docs/release-dashboard-data.json` reflects the active release focus
- [x] generated outputs are current:
      `docs/release-dashboard.html`,
      `docs/project-handbook.html`,
      `docs/public-phd-renovation.html`,
      `docs/public-phd-renovation-handbook.html`,
      `docs/public-status-phd-renovation.json`
- [x] public-facing wording matches repo-local wording

## Required Scope Conditions

- [x] supported executable families are clearly identified
- [x] integrity-checkable preserved families are clearly identified
- [x] snapshot-specific preserved families are clearly identified
- [x] deferred lanes are clearly identified
- [x] no hidden `1.0` blockers remain in project docs

## Release Notes Must State

- what the integrated line now guarantees
- what validation is continuously exercised
- which historical families are executable now
- which historical families are integrity-checkable only
- which historically important lanes are deferred
- which meaningful deltas remain documented

## Tag / Release Process

1. Regenerate the status/docs outputs.
2. Run the full validation gate.
3. Confirm the branch is clean.
4. Draft release notes from this checklist and the current roadmap.
5. Tag the release.
6. Push the tag and any synced public outputs.

## Current Best Read

As of March 22, 2026, the project looks close enough to `1.0.0` that the main
remaining work is **release hardening**, not broad new solver expansion.

The most likely remaining pre-`1.0` work is:

1. final selective docstrings and operator-facing cleanup,
2. drafting the actual `1.0.0` release notes from the now-stable scope,
3. keeping docs/status/public outputs synchronized,
4. keeping the validation gate green,
5. and making sure deferred lanes like terrain and `Hanoi-4` stay explicit
   rather than quietly becoming implied blockers.
