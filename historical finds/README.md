# Historical Finds

This directory is a staging area for newly recovered historical material that
appears related to the PhD renovation project, but is not yet part of the
validated thesis-result baseline.

New finds should land in `incoming/` first. Move material into
`historical finds/` only after review shows that it belongs here as
archive/recovery material rather than as canonical data, supported code, or a
reviewed duplicate.

Treat everything here as archive intake first, source-of-truth second. Nothing
in this directory should be assumed to define supported behavior until it has
been cataloged, compared against the tracked snapshots, and either promoted
into a documented recovery path or left as reference-only context.

## Current Intake

### `yj-sun/`

Most likely the highest-value recovery lead in this intake.

- `Csp/` looks like a direct relative of the current Lisp solver lineage. It
  contains many familiar files (`adt-simple.lisp`, `mpr-setup.lisp`,
  `memory-csp.lisp`, `general-exp.lisp`, `test4.lisp`, `template.txt`,
  `testdata/Results/`, `MyBatch/`, etc.) plus older variants and backups that
  are not all present in the modernized repo.
- `Gen++/` appears to be the C/C++ analyzer generator toolchain used to produce
  component/control representations for the plan-recognition experiments. It
  includes documentation, example queries, rule-checker code, and a `mylisp/`
  area that may explain part of the historical input pipeline.

Working assumption: `yj-sun/Csp` is a recovery candidate for Phase 5 archive
work, while `yj-sun/Gen++` is an upstream toolchain archive that may help us
understand how historical `.component` / `.control` inputs were produced.

See also: `yj-sun/Csp/README.md` for the first comparison pass against the
tracked solver snapshots.

### `Unravel/`

This looks like an external NIST release of the Unravel slicing tool, including
source archives and two technical reports (`NIST-IR-5691` volumes 1 and 2).

Working assumption: this is important context for neighboring program-analysis
work, but it should remain reference-only unless we find direct evidence that
it formed part of the thesis validation pipeline for this repo.

Local guide:

- `Unravel/README.md`

### `Refine/`

This currently contains a small set of `.pob` artifacts under `Progs/`, with
mostly empty companion directories.

Working assumption: these are likely historical tool outputs or snapshots worth
preserving, but they are not yet understood well enough to integrate further.

Local guide:

- `Refine/README.md`

### `SurgA-Info` and `Unravel-changes/`

These are small but useful provenance clues:

- `SurgA-Info` links `SurgeonsA`, `tkXsurgeon`, and `unravel`
- `Unravel-changes/SteveLog` contains notes about parser output, variable type
  extensions, and dataflow representation needs

These notes may help connect `Gen++`, `Unravel`, and the Lisp experiments into
one broader historical workflow.

Local guide:

- `Unravel-changes/README.md`

## Handling Rules

1. Do not mix files from this directory into the validated baseline casually.
2. Preserve original filenames, directory layout, and timestamps where
   possible.
3. Prefer cataloging and diffing text sources before touching binaries,
   executables, or generated outputs.
4. When promoting anything out of this directory, document why it matters to
   thesis-result validation or to archive recovery.

## What This Directory Is Not

This directory is not:

- the main solver line,
- the canonical preserved baseline data area,
- or a dumping ground for unreviewed finds.

New material should enter through `incoming/` first. Material only belongs here
after review has established that it is best treated as archive/recovery or
reference context.

## Typical Outcomes After Review

Material reviewed here usually ends in one of these states:

| Outcome | Meaning |
|---|---|
| kept in `historical finds/` | archive/recovery value remains, but it is not part of the supported line |
| promoted into `data/` | the material proves to be a canonical preserved result/publication family |
| promoted into a snapshot tree | it clearly belongs to one historical code line |
| recorded in `DUPLICATES-REVIEW.md` | it overlaps a canonical copy and is only needed for provenance |
| reference-only | useful context, but not something the main project needs to build around |

## Suggested Recovery Order

1. Compare `yj-sun/Csp` against the tracked solver snapshots to identify unique
   source variants, missing helpers, and older experiment drivers.
2. Keep separating result families cleanly: `yj-sun/Csp/testdata/Results/`
   explains part of `PrevResults/`, while the `ff1` / `ff2` / `ff3` family now
   appears to belong to the qcsp-era `NewData4b-Batch` lineage rather than the
   older `MyBatch` lane.
3. Catalog `yj-sun/Gen++` as an upstream toolchain archive and identify the
   minimum subset needed to explain `.component` / `.control` generation.
4. Leave `Unravel/`, `Refine/`, and the note files as reference/context until a
   direct dependency on thesis validation is established.

## Rule Of Thumb

If the material helps explain how the historical project was assembled, but not
what the current supported baseline should execute, this is probably the right
place for it.
