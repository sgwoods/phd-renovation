# Historical Finds

This directory is a staging area for newly recovered historical material that
appears related to the PhD renovation project, but is not yet part of the
validated thesis-result baseline.

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

### `Refine/`

This currently contains a small set of `.pob` artifacts under `Progs/`, with
mostly empty companion directories.

Working assumption: these are likely historical tool outputs or snapshots worth
preserving, but they are not yet understood well enough to integrate further.

### `SurgA-Info` and `Unravel-changes/`

These are small but useful provenance clues:

- `SurgA-Info` links `SurgeonsA`, `tkXsurgeon`, and `unravel`
- `Unravel-changes/SteveLog` contains notes about parser output, variable type
  extensions, and dataflow representation needs

These notes may help connect `Gen++`, `Unravel`, and the Lisp experiments into
one broader historical workflow.

## Handling Rules

1. Do not mix files from this directory into the validated baseline casually.
2. Preserve original filenames, directory layout, and timestamps where
   possible.
3. Prefer cataloging and diffing text sources before touching binaries,
   executables, or generated outputs.
4. When promoting anything out of this directory, document why it matters to
   thesis-result validation or to archive recovery.

## Suggested Recovery Order

1. Compare `yj-sun/Csp` against the tracked solver snapshots to identify unique
   source variants, missing helpers, and older experiment drivers.
2. Map `yj-sun/Csp/testdata/Results/` and `MyBatch/` against current thesis
   artifacts to see whether they explain older `PrevResults/ff*.ci` families or
   the AO/test4 path.
3. Catalog `yj-sun/Gen++` as an upstream toolchain archive and identify the
   minimum subset needed to explain `.component` / `.control` generation.
4. Leave `Unravel/`, `Refine/`, and the note files as reference/context until a
   direct dependency on thesis validation is established.
