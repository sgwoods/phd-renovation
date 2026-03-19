# Missing/Lost Datasets

## QCSP-nov96 Snapshot (November 1996)

The November 1996 snapshot is documented only by a directory listing in
`data/sparc-archive/QCSP-nov96.dir` (197 entries). The source code and
data files were never recovered from the original SPARC archive.

This snapshot was an intermediate version between `qcsp-may29-1996/` (May 1996)
and `qcsp-alex-sep16-1997/` (September 1997). It contained unique terrain
CSP domain code not found in any other snapshot.

### Unique Source Files (completely lost)

| File | Purpose | Equivalent In Other Snapshots |
|------|---------|-------------------------------|
| terrain-setup.lisp | Terrain domain template definitions, situation generator | No equivalent -- unique to nov96 |
| terrain-simple.lisp | Terrain domain constraint definitions | No equivalent -- unique to nov96 |
| closure.lisp | Graph closure computations | No equivalent -- unique to nov96 |
| terrain-test.lisp | Terrain test harness | No equivalent -- unique to nov96 |

These follow the same pattern as `adt-setup.lisp`/`adt-simple.lisp` and
`mpr-setup.lisp`/`mpr-simple.lisp` for the ADT and MPR domains respectively.
Without the setup file, the terrain templates and situation structure are unknown
and TCSP data files cannot be regenerated.

### Unique Data Directories

| Directory | Files Listed | Description |
|-----------|-------------|-------------|
| TCSP-Random/ | 1 (Rnddefault) | Terrain CSP random state |
| TCSP-Situation/ | 5 files | One terrain situation with decomposition sidecars |

TCSP-Situation contained:
- `Sit-terrain-1-nil-default-0` -- Main situation file
- `.Sit-terrain-1-nil-default-0.r` -- Red decomposition
- `.Sit-terrain-1-nil-default-0.g` -- Green decomposition
- `.Sit-terrain-1-nil-default-0.p` -- Purple decomposition
- `.Sit-terrain-1-nil-default-0.y` -- Yellow decomposition

The `.r/.g/.p/.y` sidecar pattern matches how ADT and MPR situations store
colored constraint decompositions.

### Source Files Present in Nov96 (recovered in other snapshots)

Most of the standard solver files are shared with may29 and alex:
bm.lisp, bt.lisp, ct.lisp, gsat.lisp, utility.lisp, queens.lisp,
mpr-setup.lisp, mpr-simple.lisp, adt-setup.lisp, adt-simple.lisp,
adt-template.lisp, memory-csp.lisp, quilici-search.lisp, experiment.lisp,
commands.lisp, data-dep.lisp, new-dep.lisp, new-dep1.lisp, new-setup.lisp,
old-template.lisp, program-setup.lisp, layered.lisp, raw-search.lisp

### Backup Archives Listed

The .dir listing shows two .zoo archives in a `Bkp/` subdirectory:
- `Bkp/dec5-bkp.zoo` -- December 5 backup
- `Bkp/Dec5b.zoo` -- December 5 backup (variant)

These December 1996 backups might contain the terrain source code if
recovered from the SPARC archive.

### ADT/MPR Data Also Present

| Directory | Files | Notes |
|-----------|------:|-------|
| ADT-Random/ | 53 | Standard Rnd\* seed files |
| ADT-Situation/ | 0 | Listed but empty |
| MPR-Random/ | 1 | Rnddefault only |
| MPR-Situation/ | 20 | 4 situations x 5 files each (noise 0, 50, 200, 500) |

### Recovery Guidance

To recover the terrain CSP code, look for:

1. **SPARC backup tapes** from the "monarch" workstation, late 1996
2. **`.zoo` archives**: `dec5-bkp.zoo` and `Dec5b.zoo` from the Bkp/ directory
3. **Files named**: `terrain-setup.lisp`, `terrain-simple.lisp`, `closure.lisp`
4. **Directory named**: `QCSP-nov96/` or `QCSP/` dated November-December 1996

The terrain domain was an exploratory extension for graph-based CSP problems.
It was not used in the final thesis experiments (ij2/ij3/ij4 series) and was
dropped before the alex (September 1997) snapshot.
