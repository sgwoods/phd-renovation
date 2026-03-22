# Repository Status

This file answers a broader question than `VALIDATION-MATRIX.md`:

**Is the entire repository indexed and, where practical, integrated, tested,
and validated against published or historically reported results?**

Short answer: **not entirely yet.**

- The primary solver line, reference snapshots, main thesis-result pipeline,
  bounded AO baseline, and several preserved result families are now indexed
  and either executable or integrity-checkable.
- Large portions of the archive are documented and classified, but are not yet
  part of the supported integrated line.
- Some historical systems, datasets, and toolchains are preserved mainly for
  provenance, recovery, or context rather than active validation.

Use this artifact as the repo-wide counterpart to `VALIDATION-MATRIX.md`.
For reviewed duplicate and redundancy decisions, see `DUPLICATES-REVIEW.md`.
For the practical operator view of "what do I run?", see `WORKFLOWS.md`.
For the repo-root helper scripts specifically, see `MANUAL-HELPERS.md`.

## Status Key

- `Indexed`: documented well enough that its role in the repo is understood.
- `Integrated`: part of the supported solver story rather than just preserved.
- `Automated`: covered by CI or a repeatable validation script.
- `Publication / report validation`: tied directly to thesis or historically
  reported results, either executable or integrity-checkable.

## Executive Read

| Question | Current answer |
|---|---|
| Is the whole repo indexed? | Mostly for primary systems, validation surfaces, and major archives; not exhaustively for every recovered intake subtree or legacy side directory. |
| Is the whole repo integrated? | No. `qcsp3/` plus the supported validation spine are integrated; most historical/result archives remain reference or integrity-check layers. |
| Is the whole repo tested? | No. The supported solver line and bounded AO baseline are tested and currently clean in fresh validation runs; many historical batches are integrity-checked instead of rerun. |
| Is the whole repo publication-validated? | Partially. The main thesis `ij2`/`ij3`/`ij4` story is executable and validated; several older result families are tied to publications/reports as preserved artifacts, but not all are modern reruns. |

## Repository-Wide Coverage Table

| Area | Kind | Indexed | Integrated | Automated | Publication / report validation | Current read |
|---|---|---|---|---|---|---|
| `qcsp3/` | Primary solver line | Yes | Yes | Yes | Yes | Operational center of the supported post-M1 baseline. |
| `csp/` | Reference solver snapshot | Yes | Reference-only | Yes | Indirectly | Covered by regression tests and used as a comparison anchor. |
| `qcsp-may29-1996/` | Reference solver snapshot + embedded batches | Yes | Partly | Yes | Yes, partly | Core solver snapshot is tested; embedded batch/result trees are partly integrity-checked. |
| `qcsp-alex-sep16-1997/` | Reference solver snapshot + archive-heavy extras | Yes | Partly | Yes | Partly | Core snapshot is tested; some experiment/result material remains provenance-only. |
| `tests/` | Validation spine | Yes | Yes | Yes | Yes | Authoritative supported validation surface. |
| `Q-Batch-SBCL/` | Modern experiment workspace | Yes | Yes | Yes | Yes | Main executable thesis-result replication path, but mixes tracked infra and generated outputs. |
| `data/acl-experiments/` | ACL thesis-era baseline results | Yes | Yes | Yes | Yes | Direct baseline for the supported `ij2`/`ij3`/`ij4` comparison checks. |
| `data/sparc-archive/PrevResults/` | Thesis-era / SPARC preserved results | Yes | Partly | Partly | Yes | Some families are integrity-checked; others are mapped but not rerun. |
| `qcsp-may29-1996/NewData4b-Batch/` | Preserved `ff*` family source tree | Yes | Partly | Yes | Yes | `ff1`/`ff2`/`ff3` are now integrity-checked, not fully rerunnable through `qcsp3/`. |
| `data/csp-adt-batch/` | Preserved ADT batch results | Yes | No, but bridge investigation started | Yes | Report-linked | Integrity-checkable preserved family; the first narrow `csp`-based `ij2` bridge now runs, defaults to the closer surviving `qcsp3` `Rnddefault` bundle, and now appears to diverge already in preprocessing rather than only later in search. |
| `data/csp-batch/` + `data/csp-save-results/` | Earliest DREV-era batch family | Yes | No | Yes | Report-linked | Integrity-checkable preserved family; outside the integrated executable line. |
| `historical finds/yj-sun/Csp/` | Archive recovery candidate | Yes | No | No | Indirectly | Strong provenance value; not part of the supported line. |
| `historical finds/yj-sun/Gen++/` | Upstream toolchain archive | Partly | No | No | Indirectly | Important context for historical input generation, but not integrated. |
| Other `historical finds/` subtrees | Archive/context intake | Partly | No | No | Unclear / indirect | Preserved as recovery/context material rather than validated code or data. |
| `data/motors-releases/` + `data/motors-backups/` | Compressed external solver archives | Yes | No | No | Historical context | Cataloged but not unpacked into a validated path yet. |
| `data/thesis/` | Publication artifact | Yes | Reference-only | No | Yes | Thesis PDF is preserved as the publication anchor, not a generated artifact. |
| `data/lost-datasets.md` + terrain references | Missing historical domain | Yes | No | No | Historically relevant | Explicitly tracked as the major blocked lane outside the current integrated line. |
| Root `run-test4*.lisp` | Manual AO harnesses | Yes | Partly | No | Indirectly | Preserved for manual/historical use; supported AO confidence now flows through `tests/ao-run.lisp`. |
| Root `run-csp-tests.lisp` / `renovate.lisp` | Legacy/manual loader helpers | Partly | No | No | No | Still usable, but secondary to `src/main.lisp` and `tests/`. |
| `docs/` | Generated/public status outputs | Yes | Yes | Yes | Project-status, not research publication | First-class operator/public status artifacts driven from one source file. |

## What This Means

The repository now has three broad zones:

1. `Supported integrated baseline`
   `qcsp3/`, the validation spine in `tests/`, the modern experiment workspace
   in `Q-Batch-SBCL/`, and the thesis-era ACL baselines under `data/`.

2. `Reference and integrity-check layers`
   Historical snapshots and preserved result families that are documented and
   checked, but not yet folded into one executable gold-standard line.

3. `Archive, recovery, and context material`
   Recovered historical finds, compressed legacy archives, and missing-domain
   trackers that matter to the long-term story but are not yet integrated.

4. `Incoming review queue`
   Newly found relevant material should land in `incoming/` first, then be
   reviewed and promoted into one of the three zones above.

## Deliberate Next Integration Target

The next post-M1 integration target should be:

**ADT batch archives (`ij1`-`ij4` era before the SBCL replication line)**

Why this family is the best next step:

1. it is already integrity-checkable through `tests/validate-adt-batch.sh`,
2. it sits closest to the direct-matching ADT solver line that `qcsp3/`
   already supports,
3. it extends historical coverage without depending on the still-blocked
   terrain lane, and
4. it is a better post-M1 bridge than the earlier `T1`-`T6` family, which is
   historically valuable but further away from the current integrated solver
   story.

That means the current recommended order is:

1. finish the `0.3.x` operator-docs pass,
2. use the ADT batch family as the next integration experiment,
3. keep `T1`-`T6` as a later preserved-family target,
4. keep terrain as the major deferred recovery lane.

The current bridge note for this target lives in `ADT-BATCH-INTEGRATION.md`.
Current recommendation: use `csp/` as the first executable bridge host for
this family, then compare that bridge against `qcsp3/`.

## Maintenance Rule

Keep this file in sync whenever one of these changes happens:

1. a directory or result family moves from provenance-only to
   integrity-checkable or executable,
2. a new top-level archive or workspace is added,
3. a previously manual workflow becomes part of the supported line, or
4. a result family becomes publication-validated in a stronger way than before.
