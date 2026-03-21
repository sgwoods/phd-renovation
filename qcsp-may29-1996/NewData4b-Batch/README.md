# NewData4b-Batch

This directory preserves the qcsp-era `ff1` / `ff2` / `ff3` ADT/FCDR
distribution-comparison family that later appears under
`data/sparc-archive/PrevResults/`.

## What Is Here

- `f1-*.lsp`, `f2-*.lsp`, `f3-*.lsp`: preserved batch drivers for the three
  noise distributions.
- `Count/`: per-seed result records for the completed runs.
- `Graph/`: preserved summaries, plots, and helper artifacts.

The preserved drivers show the batch shape directly:

- `f1-*` uses `:rand-dist "dist1"`
- `f2-*` uses `:rand-dist "dist2"`
- `f3-*` uses `:rand-dist "dist3"`

and all three run direct `adt` matching on `q-i2` with template
`quilici-t1`, `:forward-checking t`, and `:dynamic-rearrangement t` across the
thesis seed family.

## Aggregation Path

The best current reconstruction of the preserved result pipeline is:

1. Per-seed runs are stored under `Count/` as
   `fcdr-dist{1,2,3}-{noise}.{seed-index}`.
2. Each distribution contributes 70 preserved completed runs:
   7 noise settings x 10 seeds.
3. `Graph/ff1.all`, `ff2.all`, and `ff3.all` are the per-distribution
   consolidated tables formed from those 70 run records.
4. `Graph/ff1.avg`, `ff2.avg`, and `ff3.avg` summarize the same runs by
   x-axis problem size, reporting mean TCC plus the observed low/high bounds.
5. `Graph/ff1.ci`, `ff2.ci`, and `ff3.ci` preserve the same mean TCC values
   with confidence-interval bounds instead of min/max bounds.

The repository's `tests/validate-ff-provenance.sh` check now protects the
carry-forward from `Graph/ff*` into `data/sparc-archive/PrevResults/ff*`.

## Reading The Columns

### `Count/` and `ff*.all`

The key preserved field for the graph summaries is total constraint checks
(TCC). For example, the first `dist1` run:

- `Count/fcdr-dist1-0100.1`
- `Graph/ff1.all` first line

both record the same TCC value `396`, and `ff1.all` preserves the same
per-seed runs after light formatting normalization.

### `ff*.avg` and `ff*.ci`

These summary tables do **not** use the raw noise setting as the x-axis.
Their first column is the effective problem-size axis used in the preserved
graphs.

The preserved `Graph/ff-PROBSIZE` file explains that axis as a problem-size
range per raw noise setting and distribution. The first column in `ff*.avg`
and `ff*.ci` appears to be the representative rounded size drawn from those
ranges.

Example for `dist1`:

- raw noise `100` corresponds to preserved size range `134-174`
- the graph summaries use x-axis value `155`

## Gaps And Limits

- `f0.sh` still points at the older `New-Batch/` location, so the preserved
  shell wrapper is not a clean modern rerun path.
- The `f*-9999.lsp` drivers exist, but the preserved completed `Count/` and
  `ff*.all` data cover the 70 completed runs for the smaller supported set.
- `Graph/ff-DID-NOT-COMPLETE` preserves the larger unfinished cases separately.

So this directory is strong preserved provenance, but not yet a supported
fresh-checkout rerun workflow.
