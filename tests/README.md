# Test And Validation Guide

This directory is the authoritative validation surface for the renovated
project. If the question is "what proves the current baseline still works?",
start here.

## Main Entry Points

- `run.lisp`: orchestrates the Four FiveAM suites in separate SBCL processes.
- `ao-run.lisp`: asserted AO regression runner for the supported `test4`
  baseline across qcsp3, may29, and alex, now covering qcsp3/may29 AO cases
  1-3 plus the legacy wrappers and alex's revise baseline.
- `validate-artifacts.sh`: rebuilds SBCL graph artifacts, regenerates overlay
  plots, and checks the current thesis-result pipeline.
- `validate-dashboard.sh`: regenerates the visual release dashboard and the
  public-facing PhD project page plus this repo's public status manifest from
  their shared structured source file, and fails if the checked-in outputs are
  out of sync.
- `validate-ff-provenance.sh`: checks that the preserved `NewData4b-Batch`
  `ff*` graph summaries match their `PrevResults/` carry-forward copies and
  that the supporting raw/count lineage is present.
- `validate-adt-batch.sh`: checks that the preserved `data/csp-adt-batch/`
  `ij1`-`ij4` raw file grids and historically uneven CI summary tables still
  line up as expected.
- `validate-csp-batch.sh`: checks that the preserved `data/csp-batch/` and
  `data/csp-save-results/` DREV-era T1-T6 archive still matches its historical
  summary layout and known row-count quirks.
- `validate-ao.sh`: shell wrapper that runs `ao-run.lisp`.
- `validate-thesis-comparison.py`: checks that regenerated SBCL `ij2` / `ij3` /
  `ij4` CI tables preserve the supported ACL baseline story.

## Suite Breakdown

- `csp-suite.lisp`: base solver regression metrics.
- `qcsp3-suite.lisp`: primary solver regression metrics.
- `may29-suite.lisp`: May 29 1996 snapshot regression metrics.
- `alex-suite.lisp`: Sep 16 1997 alex snapshot regression metrics.
- `ao-qcsp3-suite.lisp`, `ao-may29-suite.lisp`, `ao-alex-suite.lisp`:
  deterministic AO assertions for the supported `test4` path, including the
  bounded M1 AO surface.

## Supported Validation Spine

Run these from the repository root:

```bash
sbcl --non-interactive --load "tests/run.lisp"
bash tests/validate-artifacts.sh
bash tests/validate-dashboard.sh
bash tests/validate-ff-provenance.sh
bash tests/validate-adt-batch.sh
bash tests/validate-csp-batch.sh
bash tests/validate-ao.sh
```

This is the baseline CI path and the best local confidence check before or
after code changes.

## Legacy AO Harnesses

The repo-root scripts:

- `run-test4.lisp`
- `run-test4-may29.lisp`
- `run-test4-alex.lisp`

are still useful as historical/manual harnesses, but `tests/ao-run.lisp` is the
asserted path that CI treats as supported coverage.
