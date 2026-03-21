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

The `ff1` / `ff2` / `ff3` family in `PrevResults/` is only partially mapped.

What we can say confidently:

- `ff1-ci.gp`, `ff2-ci.gp`, and `ff3-ci.gp` label the three series as
  `Std Dist 1`, `Equal Dist 2`, and `Skewed Dist 3`.
- `ff-PROBSIZE` and `ff-TIMING` show these are summarized distribution-based
  comparison tables, not raw `exp-*` plots.
- No byte-identical source files for `ff1.ci`, `ff2.ci`, `ff3.ci`,
  `ff1.avg`, `ff2.avg`, `ff3.avg`, or `ff*.all` were found under
  `historical finds/yj-sun/Csp/testdata/`.

What is still only an inference:

- The `exp-1` / `exp-2` / `exp-3` families are the most plausible upstream
  source families for the three-way `ff*` comparison story, because they are
  grouped together repeatedly in the archive and represent the main early
  comparison set.
- But there is not yet a located script or checked-in intermediate file that
  proves `exp-*` was transformed into `ff*`.

So the current state is:

- `exp-*` to `PrevResults/exp-*` and many `.ps` outputs: proven
- `exp-*` to `PrevResults/ff*.ci`: plausible, but not yet proven

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

To close the remaining gap, the next highest-value search is for the script or
intermediate artifact that generated `PrevResults/ff1.ci`, `ff2.ci`, and
`ff3.ci` from one of:

- the `exp-1` / `exp-2` / `exp-3` families
- batch outputs in `MyBatch/`
- archived result bundles such as `first-3-xy`, `first-3-cpu`, or related
  experiment summaries

Until that bridge is found, `PrevResults/ff*.ci` should be treated as a
historically important but only partially grounded comparison layer.
