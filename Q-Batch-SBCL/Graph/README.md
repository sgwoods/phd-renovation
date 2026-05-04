# Graph Workspace Guide

This directory is the thesis-result comparison and plotting surface for the
modern SBCL experiment workspace.

Use it when the question is:

- where do the extracted CI tables come from,
- which files are generated versus tracked,
- and which scripts rebuild the plotted comparison story.

## What Lives Here

### Tracked plotting/control files

- `extract-data.py`
- `compare-plots.py`
- `compare-ij2-overlay.py`
- `compare-all-overlay.py`
- the `*.gp` gnuplot helpers

These are maintained operator/build files.

### Tracked comparison tables and summaries

Examples:

- `ij2-ci.dat`
- `ij3-ci.dat`
- `ij4-ci.dat`
- `ij2-ci-time.dat`
- `ij3-other-ci.dat`
- `ij*-raw.dat`

These are canonical tracked thesis-result artifacts. In a full local rebuild
they are regenerated from preserved SBCL experiment outputs by
`tests/validate-artifacts.sh`; on a fresh clone they remain available as the
checked-in comparison baseline.

### Tracked visual outputs

Examples:

- `compare-ij2-overlay.png`
- `compare-ij3-overlay.png`
- `compare-ij4-overlay.png`
- `compare-all-overlay.png`
- `compare-*.pdf`

The overlay PNGs and comparison PDFs are tracked because they are part of the
published/readable artifact surface for the repo and are needed for honest
fresh-clone validation.

## Main Inputs

This directory combines:

1. regenerated SBCL summary tables from the local `Q-Batch-SBCL/` runs,
2. preserved ACL baseline tables from `data/acl-experiments/Graph/`,
3. comparison plotting scripts that overlay qcsp3, may29, alex, and ACL views.

## Supported Operator Flow

If you want the supported rebuild path, run:

```bash
bash tests/validate-artifacts.sh
```

That path:

1. extracts fresh SBCL CI tables,
2. regenerates the tracked overlay PNGs,
3. rebuilds the comparison PDFs,
4. and runs the thesis-comparison check that protects the published trend story.

## Direct Script Use

Use the Python scripts directly only when you want a narrower/manual refresh:

```bash
python3 Q-Batch-SBCL/Graph/compare-plots.py
python3 Q-Batch-SBCL/Graph/compare-ij2-overlay.py
python3 Q-Batch-SBCL/Graph/compare-all-overlay.py
```

Use the gnuplot helpers when you specifically want the older plot path rather
than the supported validation wrapper.

## Rule Of Thumb

If the task is confidence in the thesis-result story, use
`tests/validate-artifacts.sh`.

If the task is manual plot iteration or debugging one comparison layer, work
directly in this directory.
