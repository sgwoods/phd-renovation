# yj-sun/Csp Results Crosswalk

This note maps the historical result trees under `historical finds/yj-sun/Csp`
to the two result baselines that matter most in the renovated repository:

1. `data/sparc-archive/PrevResults/`
2. the current thesis-validation pipeline based on
   `data/acl-experiments/Graph/` and `Q-Batch-SBCL/Graph/`

The goal is to separate exact provenance from likely-but-not-yet-proven
relationships.

## 1. Source Experiment Families In The Archive

The alex-era experiment drivers explicitly define three core result families in
`general-exp-2.lisp`:

- `experiment-1` uses `*data-file-list-d*` with
  `"average-array-template-9-18"` and writes
  `testdata/Results/exp-1-original-result`.
- `experiment-2` uses `*data-file-list-c*` with
  `"average-array-template-8-14"` and writes
  `testdata/Results/exp-2-original-result`.
- `experiment-3` uses `*data-file-list-d*` with
  `"increment-template-2-2"` and writes
  `testdata/Results/exp-3-original-result`.

See:
- [general-exp-2.lisp](/Users/stevenwoods/phd-renovation/historical%20finds/yj-sun/Csp/general-exp-2.lisp#L8)
- [general-exp-2.lisp](/Users/stevenwoods/phd-renovation/historical%20finds/yj-sun/Csp/general-exp-2.lisp#L46)
- [general-exp-2.lisp](/Users/stevenwoods/phd-renovation/historical%20finds/yj-sun/Csp/general-exp-2.lisp#L267)

The matching `exp-1-x-y`, `exp-2-x-y`, and `exp-3-x-y` files are then derived
from those `*-original-result` files by `pick-two-for-xvgr`, selecting result
field 4 against result field 8. In practice this is program size vs total
constraint checks (TCC), because field 8 in the stored result list is `r10`
(`*constraint-cks*`).

See:
- [general-exp-2.lisp](/Users/stevenwoods/phd-renovation/historical%20finds/yj-sun/Csp/general-exp-2.lisp#L103)
- [general-exp-2.lisp](/Users/stevenwoods/phd-renovation/historical%20finds/yj-sun/Csp/general-exp-2.lisp#L456)

This gives us a reliable source-side interpretation for:

- `testdata/data-d/` -> experiment families 1 and 3
- `testdata/data-c/` -> experiment family 2
- `testdata/Results/exp-1/*`, `exp-2/*`, `exp-3/*` -> plotted size-vs-TCC
  derivatives of those runs

## 2. Exact Carry-Forward Into `PrevResults`

The following archive files are byte-for-byte identical to files in
`data/sparc-archive/PrevResults/`:

- `testdata/Results/exp-1/exp-1-x-y` ->
  `PrevResults/exp-1-x-y`
- `testdata/Results/PS/exp-1-two-filter.ps` ->
  `PrevResults/exp-1-two-filter.ps`
- `testdata/Results/PS/exp-10-two-filter.ps` ->
  `PrevResults/exp-10-two-filter.ps`
- `testdata/Results/PS/exp-123-prefilter.ps` ->
  `PrevResults/exp-123-prefilter.ps`
- `testdata/Results/PS/exp-3-two-filter.ps` ->
  `PrevResults/exp-3-two-filter.ps`
- `testdata/Results/PS/comparison.ps` ->
  `PrevResults/comparison.ps`
- `testdata/Results/PS/set-prefilter.ps` ->
  `PrevResults/set-prefilter.ps`
- `testdata/Results/PS/single-cons-2.ps` ->
  `PrevResults/single-cons-2.ps`
- `testdata/Results/PS/single-constraint.ps` ->
  `PrevResults/single-constraint.ps`
- `testdata/Results/PS/single-constraint-avg.ps` ->
  `PrevResults/single-constraint-avg.ps`
- `testdata/thesis-results/exp-1-x-y.fig` ->
  `PrevResults/exp-1-x-y.fig`

`testdata/Results/exp-2/exp-2-x-y` also maps directly to
`PrevResults/exp-2-x-y`; the only file difference is a trailing blank line in
the archived `PrevResults` copy.

This is the strongest evidence that `PrevResults/` was assembled from the
`yj-sun/Csp/testdata` result tree, not from an unrelated later export.

## 3. What `thesis-results/` Appears To Be

`testdata/thesis-results/` looks like the publication-layout layer sitting above
the raw and plotted experiment outputs:

- `exp-1-x-y.fig`, `exp-2-x-y.fig`, `exp-3-x-y.fig`
- matching FrameMaker exports `*.mk`
- `steve-ch5.xvgr` and `steve-ch5.ps`
- plan-set and static-order figures

These are best treated as chapter-figure assets, not as the primary numerical
source for regression validation.

## 4. Relationship To `PrevResults/ff*.ci`

The `ff1` / `ff2` / `ff3` family is now substantially better grounded than in
the first crosswalk pass.

What is now directly supported by archive metadata:

- `ff1-ci.gp`, `ff2-ci.gp`, and `ff3-ci.gp` label the three series as
  `Std Dist 1`, `Equal Dist 2`, and `Skewed Dist 3`, and describe them as
  `New-FCDR` runs with `2 Solns`.
- `AA-INDEX` classifies `ff1`, `ff2`, and `ff3` as:
  - strategy `FCDR`
  - ordering `Srt`
  - template `t1`
  - instance `2, qi-2`
  - distributions `1`, `2`, and `3`
  - source location `NewData4b`
- `qcsp.dir` records their original path as
  `qcsp/NewData4b-Batch/Graph/`, and that directory listing includes:
  - `ff1.all`, `ff2.all`, `ff3.all`
  - `ff1.ci`, `ff2.ci`, `ff3.ci`
  - `ff1.avg`, `ff2.avg`, `ff3.avg`
  - raw/intermediate artifacts under `Graph/Orig/`, including
    `ff1.raw`, `ff2.raw`, `ff3.raw`, `ff1.raw2`, `ff2.raw2`, `ff3.raw2`,
    plus `grab-avg` and `grab-ci`

This changes the picture materially:

- `ff*` is not best understood as a derivative of
  `historical finds/yj-sun/Csp/testdata/Results/exp-*`.
- It is a separate, later qcsp-era experiment family from
  `NewData4b-Batch`, preserved in `PrevResults/`.
- It belongs to the direct ADT/FCDR lineage, not the `MyBatch` /
  `bexp-*` experiment lane.

What the repo now preserves directly:

- `qcsp-may29-1996/NewData4b-Batch/Graph/ff1.ci`,
  `ff2.ci`, and `ff3.ci` are byte-for-byte identical to the copies under
  `data/sparc-archive/PrevResults/`.
- `qcsp-may29-1996/NewData4b-Batch/Graph/` also preserves the matching
  `ff*.all`, `ff*.avg`, `ff*-ci.gp`, `ff*-ci.ps`, and `Graph/Orig/ff*.raw*`
  lineage referenced by `qcsp.dir`.
- `qcsp-may29-1996/NewData4b-Batch/Count/` preserves the per-seed result files
  behind that graph family.
- `qcsp-may29-1996/NewData4b-Batch/f1-0100.lsp` shows the original batch shape:
  direct `adt` runs on `q-i2` / `quilici-t1` with `:forward-checking t`,
  `:dynamic-rearrangement t`, three noise distributions, and the thesis seed
  family from `AA-INDEX`.

What is still imperfect:

- The preserved shell stub `f0.sh` still points at the old `New-Batch/`
  location, so the on-disk batch wrapper is not a clean modern rerun path.
- We have strong preserved outputs and batch intent, but not yet a modernized,
  executable regeneration path for this `ff*` family.

Best current interpretation:

- `ff1` / `ff2` / `ff3` are thesis-era ADT FCDR + sorted-order comparisons over
  three noise distributions.
- They likely share lineage with the older `data/csp-adt-batch/` ADT batch
  experiments because they use the same random-seed family and single-line
  result style, but they are not the same dataset.
- The strongest surviving provenance anchor is now the checked-in
  `qcsp-may29-1996/NewData4b-Batch/` tree, with `PrevResults/` acting as its
  preserved thesis-era carry-forward.

## 5. Relationship To The Current Thesis-Validation Pipeline

The current automated thesis-validation pipeline does not use
`PrevResults/ff*.ci` yet.

Today it validates the supported replication story by comparing regenerated SBCL
CI tables in `Q-Batch-SBCL/Graph/` against the preserved ACL CI tables in
`data/acl-experiments/Graph/` for `ij2`, `ij3`, and `ij4`.

See:
- [validate-thesis-comparison.py](/Users/stevenwoods/phd-renovation/tests/validate-thesis-comparison.py#L1)

That means the present validation chain is:

- modern SBCL experiment reruns -> `Q-Batch-SBCL/Graph/ij*-ci.dat`
- compared against ACL-era baseline -> `data/acl-experiments/Graph/ij*-ci.dat`

Not yet in the active chain:

- `historical finds/yj-sun/Csp/testdata/*`
- `data/sparc-archive/PrevResults/ff*.ci`

So this archive crosswalk improves provenance, but it does not yet extend the
automated CI gate.

## 6. Practical Crosswalk Summary

Current best mapping:

- `testdata/data-d/` -> source inputs for archived experiments 1 and 3
- `testdata/data-c/` -> source inputs for archived experiments 2, 6, 9, and 10
- `testdata/Results/exp-1|2|3/*` -> archived size-vs-TCC result families
- `testdata/Results/PS/*` -> many exact carry-forwards into `PrevResults/`
- `testdata/thesis-results/*` -> publication and thesis-figure assets
- `PrevResults/ff*.ci` -> later summarized comparison layer with unresolved
  generation provenance
- `data/acl-experiments/Graph/ij*-ci.dat` -> current validated historical
  baseline for automated thesis checking

## 7. Best Next Step

The open question has shifted from "where did `ff*` come from?" to
"how much of `NewData4b-Batch` should become part of the supported executable
baseline?"

The most promising next targets are:

- compare `NewData4b-Batch/Count/` against the `ff*.all` summaries to document
  the aggregation path explicitly
- connect `Data/MvSit2/` situation names like `Sit-q-i2-dist{1,2,3}-*` to the
  preserved `q-i2` runs in `NewData4b-Batch`
- decide whether to add a lightweight provenance/integrity check asserting that
  `NewData4b-Batch/Graph/ff*.ci` matches `PrevResults/ff*.ci`
- only after that, consider whether a full modern rerun path is worth
  engineering for this older thesis-era family
