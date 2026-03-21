# sparc-archive/ — Original SPARC Archive (1993-1997)

Preserves the original PhD thesis data from a SPARC/Solaris workstation
(monarch). Serves as a historical record and verification source for the
modern SBCL replication. Moved from `DataFind/`.

## Structure

```
data/sparc-archive/
├── AA-INDEX              Experiment metadata index (seeds, distributions, series labels)
├── README.exper          Original notes on experiment provenance and reproducibility
├── csp.dir               Directory listing of original csp/ on SPARC (1993-1994)
├── qcsp.dir              Directory listing of original qcsp/ on SPARC (May 1996)
├── qcsp3.dir             Same as qcsp.dir (qcsp and qcsp3 were the same codebase)
├── qcsp-alex.dir         Directory listing of alex snapshot (Sep 1997)
├── QCSP-nov96.dir        Directory listing of Nov 1996 snapshot (source not recovered)
├── Data/
│   └── MvSit2/           64 pre-generated ADT situation files (problem instances)
└── PrevResults/          85 files of thesis-era experimental results
```

## .dir Files

Directory listings (`ls -l`) from the original SPARC archive. These map the
on-disk structure of each codebase snapshot, including backup directories,
`.fasl` compiled files, and `.zoo` archives that were cleaned up during
renovation.

| File | Maps To | Notes |
|------|---------|-------|
| csp.dir | `csp/` | Base solver from 1993-1994, batch experiments now in `data/csp-batch/` |
| qcsp.dir | `qcsp3/` | May 1996 snapshot with backup dirs `BakSrcLost/`, `BakMar14/` |
| qcsp3.dir | `qcsp3/` | Identical to qcsp.dir |
| qcsp-alex.dir | `qcsp-alex-sep16-1997/` | Sep 1997 with 40+ ADT-Random seed directories |
| QCSP-nov96.dir | *Not in repo* | Unique terrain analysis code. See [data/lost-datasets.md](../lost-datasets.md). |

## PrevResults/

Thesis-era experimental results (April 1997) from FCDR search under three
noise distributions. **These predate the ij2/ij3/ij4 experiment series.**

### ff1/ff2/ff3 — Confidence Interval Data

Three-column format: `noise  mean_CC  CI_lower  CI_upper`

| File | Distribution | Noise Range | Max Mean CC |
|------|-------------|-------------|-------------|
| ff1.ci | Standard (dist1) | 155-5920 | 95,140 |
| ff2.ci | Equal (dist2) | 210-7090 | 80,992 |
| ff3.ci | Skewed (dist3) | 125-6550 | 118,163 |

These are **not** the same as ij2/ij3/ij4 — they come from an older experiment
series using FCDR + Advance Sort, run before the memory-CSP two-phase approach
was developed.

Archive metadata now grounds these files more specifically:

- `AA-INDEX` identifies `ff1` / `ff2` / `ff3` as `FCDR` + `Srt` runs over
  distributions 1, 2, and 3 for template `t1`, instance `2, qi-2`, under the
  `NewData4b` experiment family.
- `qcsp.dir` records their original location as
  `qcsp/NewData4b-Batch/Graph/`, including preserved `ff*.all`, `ff*.ci`,
  `ff*.avg`, and raw/intermediate `Graph/Orig/ff*.raw*` files.
- The repository now preserves that batch family directly under
  `qcsp-may29-1996/NewData4b-Batch/`, including:
  - `Graph/ff1.ci`, `ff2.ci`, `ff3.ci` byte-identical to `PrevResults/`
  - `Count/fcdr-dist{1,2,3}-*` per-seed result files
  - batch driver stubs such as `f1-0100.lsp` showing direct `adt` runs over
    `q-i2` / `quilici-t1` with FC + DR across the thesis seed family
  - local documentation in `qcsp-may29-1996/NewData4b-Batch/README.md`
    explaining the preserved `Count/ -> ff*.all -> ff*.avg / ff*.ci` path

So the `ff*` family is now better understood as a preserved qcsp-era
ADT/FCDR distribution-comparison dataset, not a direct precursor of the later
`ij2` / `ij3` / `ij4` series. What is still missing is a clean modern rerun
path, not the thesis-era artifact lineage itself.

### Other Files

- `ff*-ci.gp` — Gnuplot scripts for plotting the CI data
- `ff*-ci.ps` — Rendered PostScript plots
- `*.xvgr` — XMGrace visualization files (deprecated format)
- `wcre97-1-figure1*.ps` — Conference paper figures (WCRE '97)
- `avg-array-8-14-*` — Averaged statistics across noise levels

## Data/MvSit2/

64 pre-generated ADT situation files (serialized Lisp S-expressions).

Naming: `Sit-q-i2-dist{1,2,3}-{seed}-{noise}`
- `q-i2` — Quilici template 1, instance 2
- `dist1/dist2/dist3` — Three noise distributions
- Seeds: `default` plus 9 named seeds from AA-INDEX
- Noise levels: 100, 250, 500, 750, 1000, 2000, 9999

These are static reference copies from the thesis era. The current test
suites generate equivalent situations dynamically at runtime.

## AA-INDEX

Structured metadata describing all experiment series:

- **ij1-ij5**: Method comparatives (BT, FCDR, 2-Phase Memory-CSP, Direct ADT)
- **f/ff/g/h series**: Distribution comparatives with varying templates
- **9 random seeds**: `default` plus 8 named seeds for reproducibility
- **3 distributions**: Standard, Equal, Skewed noise profiles

## Relationship to Current Repo

| Archive | Modern Equivalent | Notes |
|---------|-------------------|-------|
| PrevResults/ff*.ci | qcsp-may29-1996/NewData4b-Batch/Graph/ff*.ci | Same preserved thesis-era family; byte-identical carry-forward |
| qcsp-may29-1996/NewData4b-Batch/Graph/ff*.ci | data/acl-experiments/Graph/ij*-ci.dat | Different experiment era; both are historical graph baselines, but they answer different thesis questions |
| PrevResults/*.ps | Q-Batch-SBCL/Graph/*.png | PostScript replaced by matplotlib |
| Data/MvSit2/ | Generated at runtime | Static reference vs. dynamic generation |
| .dir files | Renovation source tree | Cleaned up during ACL-to-SBCL migration |

The ff1/ff2/ff3 data should not be used for direct comparison with ij2/ij3/ij4
results — they represent a different experimental methodology from an earlier
code version.
