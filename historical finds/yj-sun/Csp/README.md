# yj-sun/Csp Archive Notes

This directory appears to be a historically important archive for the Lisp
solver lineage behind this repository. It is not a drop-in replacement for any
 tracked snapshot, but it is clearly closest to the `qcsp-alex-sep16-1997`
branch and preserves material that does not exist elsewhere in the repo.

## Current Assessment

### Closest tracked snapshot

By path overlap, this archive is closest to `qcsp-alex-sep16-1997`:

- `qcsp-alex-sep16-1997`: 116 shared paths
- `qcsp-may29-1996`: 69 shared paths
- `qcsp3`: 23 shared paths
- `csp`: 17 shared paths

However, the overlapping top-level Lisp sources are not byte-for-byte copies of
any tracked snapshot. Files such as `adt-setup.lisp`, `adt-simple.lisp`,
`memory-csp.lisp`, `mpr-setup.lisp`, `queens.lisp`, and `utility.lisp` all
differ from the versions in `csp/`, `qcsp3/`, `qcsp-may29-1996/`, and
`qcsp-alex-sep16-1997/`.

### Strong exact-match signals

Some archive material matches the tracked alex snapshot exactly, which makes it
useful for provenance:

- `MyBatch/` batch runners and helper scripts are exact matches for the tracked
  alex `MyBatch/` files.
- `SteveBkps/bt.lisp` matches the tracked alex copy.
- Several `testdata/` artifacts match tracked alex files exactly, including:
  `ave.res1`, `dmax.c`, `exp-step.1`, `exp-step.2`, `extract.C`,
  `incre-plan.res`, `new-plans.res`, `special-exp-1.res`,
  `special-exp-2.res`, and `tscale-3c.result`.

This suggests the archive likely sits very near the alex-era experiment and
batch infrastructure, even though its solver and loader sources preserve extra
variants not carried into the tracked snapshot.

## What This Archive Adds

The most valuable archive-only material appears to be:

- Experiment/load orchestration:
  `yj-load.lisp`, `test4.lisp`, `general-exp.lisp`, `general-exp-2.lisp`,
  `random-templ-exp.lisp`, `static-order-exp.lisp`, `cpu-xy.lisp`,
  `single-constraint.lisp`, `this-exp-data.lisp`, `exp-2-data.lisp`,
  `exp-10-data.lisp`, `exp-ssa-data.lisp`
- Gen++ translation / dependency processing support:
  `new-setup.lisp`, `new-dep.lisp`, `new-dep1.lisp`,
  `new-dep-no-consumer.lisp`, `new-dep-cnl.lisp`, `2-pre.lisp`
- Template/history variants:
  `adt-template.lisp`, `adt-template.lisp.dec-23-1996`, `old-template.lisp`,
  `new-templates`
- Additional drivers and recovery clues:
  `program-setup.lisp`, `compile-set.lisp`, `final-test.lisp`, `testing.lisp`,
  `test2.lisp`, `startup.lisp`, `random.lisp`, `raw-search.lisp`
- Preserved compiled artifacts:
  `*.sbin` and `Fasls/*.fasl`
- Broader experiment datasets:
  `testdata/Results/`, `testdata/Results-Loop/`, `testdata/Static/`,
  `testdata/data-c/`, `testdata/data-d/`, `testdata/data-y/`,
  `testdata/fmkfile/`, `testdata/thesis-results/`

## Immediate Implications

1. `yj-sun/Csp` is best treated as a recovery/reference source, not as a
   supported execution target.
2. It is especially promising for reconstructing:
   - how alex-era experiments were orchestrated,
   - how `.component` / `.control` inputs were transformed for the Lisp system,
   - how older thesis-result families relate to modern validation artifacts.
3. The exact `MyBatch/` matches make this archive directly relevant to the
   `test4` / AO / batch provenance story.

## Best Next Recovery Steps

1. Diff the archive-only loader and experiment drivers against the tracked
   snapshots, starting with:
   `yj-load.lisp`, `test4.lisp`, `general-exp.lisp`, `new-setup.lisp`,
   and `new-dep.lisp`.
2. Map `testdata/thesis-results/`, `testdata/Results/`, and the `data-c` /
   `data-d` experiment families to `data/sparc-archive/PrevResults/ff*.ci`
   and the modern validation pipeline.
3. Compare `adt-template.lisp` and related template variants against the
   tracked ADT setup to determine whether they explain any thesis-era result
   differences or missing template context.
4. Keep the archive separate from the validated baseline until any promoted
   material has a documented role in thesis-result reproduction.
