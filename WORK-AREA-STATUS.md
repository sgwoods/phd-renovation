# Work Area Status

This file answers a practical question:

**Which parts of the repo are current working areas, which are reference or
archive areas, and which should be treated as deprecated for day-to-day
mainline use?**

The goal is not to throw anything away.
The goal is to keep the project easy to navigate without confusing:

- active working surfaces,
- preserved historical/reference surfaces,
- archive-only material,
- and older helper paths that still exist but should not be mistaken for the
  primary supported workflow.

## Status Key

- `Current working area`
  The place we expect most active mainline work to happen now.

- `Supported validation area`
  Part of the trusted confidence gate for the current baseline.

- `Reference snapshot`
  A preserved historical code line that still matters, but is not the primary
  place for new integrated work.

- `Preserved results / provenance`
  Important historical data or result material kept for comparison,
  integrity-checking, or lineage.

- `Archive intake / pending review`
  Material that may matter, but is not yet promoted into a durable long-term
  home.

- `Deprecated for mainline use`
  Still preserved and usable when needed, but should not be treated as the
  default path for everyday supported work.

## Current Read

| Area | Status | How to treat it now |
|---|---|---|
| `qcsp3/` | Current working area | Primary integrated solver line and default code surface for ongoing mainline work. |
| `tests/` | Supported validation area | Authoritative confidence gate for the current baseline. |
| `src/` | Current working area | Main interactive entry point for the supported solver line. |
| `Q-Batch-SBCL/` | Current working area | Main thesis-result experiment workspace, with mixed tracked/generated content. |
| `docs/` | Current working area | Generated status, handbook, and public-facing outputs that are part of the maintained build. |
| `tools/` | Current working area | Maintained helper scripts for docs/status generation and intake scaffolding. |
| `incoming/` | Archive intake / pending review | First stop for all newly found relevant material. |
| `incoming/_landing/` | Archive intake / pending review | Raw-drop handoff area before Codex converts material into a proper intake batch. |
| `data/acl-experiments/` | Preserved results / provenance | Canonical preserved ACL thesis-era baseline for active comparison checks. |
| `data/thesis/` | Preserved results / provenance | Canonical thesis source artifact. |
| `data/csp-adt-batch/`, `data/csp-batch/`, `data/csp-save-results/` | Preserved results / provenance | Historical result families kept for integrity checks and research context. |
| `data/sparc-archive/` | Preserved results / provenance | SPARC-era preserved archive and report/result carry-forward layer. |
| `historical finds/` | Preserved results / provenance | Reviewed archive/recovery material, not a supported execution surface. |
| `csp/` | Reference snapshot | Earliest preserved solver line; used for comparison and historical grounding. |
| `qcsp-may29-1996/` | Reference snapshot | Historical snapshot with embedded preserved experiment trees. |
| `qcsp-alex-sep16-1997/` | Reference snapshot | Historical snapshot with extended experiment/tooling context. |
| root `run-test4*.lisp` | Deprecated for mainline use | Preserved manual compatibility helpers; useful historically, but not the supported AO gate. |
| `run-csp-tests.lisp` | Deprecated for mainline use | Historical/manual helper, secondary to `tests/`. |
| `renovate.lisp` | Deprecated for mainline use | Historical bootstrap/helper context, not a current working surface. |

## Practical Rule

When in doubt:

1. do new integrated solver work in `qcsp3/`,
2. use `tests/` for confidence,
3. use `Q-Batch-SBCL/` for the thesis-result experiment story,
4. use `incoming/` first for anything newly found,
5. treat snapshots as reference material unless there is a specific historical
   reason to work inside them,
6. and treat root helper scripts as deprecated for day-to-day mainline use.

## Important Distinction

`Deprecated for mainline use` does **not** mean disposable.

These areas are still preserved because they can be useful for:

- historical comparison,
- manual reconstruction of old workflows,
- provenance,
- or future recovery work.

The label only means:

**do not mistake them for the default supported path going forward.**

## Recommended Next Step

Keep this file current whenever a work area changes role, especially if:

1. an intake area becomes a promoted permanent home,
2. a snapshot-specific family becomes part of the supported baseline,
3. a manual helper becomes truly obsolete,
4. or a new archive/research lane becomes important enough to name explicitly.
