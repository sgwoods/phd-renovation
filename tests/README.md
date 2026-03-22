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
  full readable handbook plus the public-facing PhD project page and this
  repo's public status manifest from their shared status/doc sources, and
  fails if the checked-in outputs are out of sync.
- `validate-ff-provenance.sh`: checks that the preserved `NewData4b-Batch`
  `ff*` graph summaries match their `PrevResults/` carry-forward copies and
  that the supporting raw/count lineage is present.
- `validate-adt-batch.sh`: checks that the preserved `data/csp-adt-batch/`
  `ij1`-`ij4` raw file grids and historically uneven CI summary tables still
  line up as expected.
- `validate-csp-batch.sh`: checks that the preserved `data/csp-batch/` and
  `data/csp-save-results/` DREV-era T1-T6 archive still matches its historical
  summary layout and known row-count quirks.
- `investigate-adt-batch-bridge.sh`: runs the first narrow executable bridge
  case for the preserved ADT batch `ij2` family and reports whether the
  current `csp:adt` output matches or diverges from the preserved archive.
  It now defaults to the closer surviving `qcsp3` `Rnddefault` bundle, and
  `PHD_ADT_BRIDGE_RANDOM_SOURCE=...` can override that seed source for
  comparison runs.
- `investigate-adt-batch-random-lineage.sh`: reruns that same `ij2` bridge
  case against the surviving `Rnddefault` bundles from may29, qcsp3, alex,
  and `historical finds/yj-sun/Csp` to test whether random-state lineage is
  driving the divergence.
- `investigate-adt-batch-input-shape.sh`: inspects the generated `ij2`
  situation and domain shape before search starts so we can tell whether the
  bridge mismatch begins in preprocessing or only later in the search. Under
  the current qcsp3-seeded bridge, it shows that `Dsize` and `NCC` already
  diverge before backtracking starts.
- `investigate-adt-batch-source-drift.sh` / `run-adt-batch-input-shape-generic.lisp`:
  compare that pre-search `ij2` shape across maintained source/dist variants.
  The current result is that `qcsp3/dist1` is materially closer to the
  preserved `ij2-050.1` preprocessing metrics than `csp/dist1`.
- `investigate-adt-batch-qcsp3-bridge.sh` / `run-adt-batch-bridge-qcsp3-ij2.lisp`:
  run the same narrow `ij2` bridge through maintained `qcsp3` using a
  legacy-compatible temporary workdir. The current result is still divergent,
  but materially closer to the preserved case than the maintained `csp`
  bridge on the tracked non-timing metrics.
- `investigate-adt-batch-qcsp3-old-dist1-bridge.sh`:
  reruns that same narrow `ij2` qcsp3 bridge through a temporary normalized
  copy of the carried `old-dist1-pre-quilici` distribution. The current result
  is that the preserved pre-Quilici label is runnable in isolation, but it
  lands farther from the preserved `ij2-050.1` metrics than maintained
  `qcsp3/dist1`.
- `investigate-adt-batch-structure-drift.sh`:
  compares the generated `ij2` situation profile and node-consistent domain
  shape for maintained `csp/dist1` versus maintained `qcsp3/dist1`. The current
  result is that `qcsp3` builds a smaller noise layer with fewer `begin`/`end`
  statements, more `check` statements, and the largest domain squeeze on
  `t2-c`.
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
after code changes. Fresh March 21, 2026 validation runs of
`tests/run.lisp` and `tests/validate-ao.sh` are currently clean for the
supported path, so any new warning output in those flows should be treated as a
potential regression signal.

`investigate-adt-batch-bridge.sh` is intentionally outside that supported gate
for now. It is an executable research/integration probe, not yet a passing
baseline check.

## Legacy AO Harnesses

The repo-root scripts:

- `run-test4.lisp`
- `run-test4-may29.lisp`
- `run-test4-alex.lisp`

are still useful as historical/manual harnesses, but `tests/ao-run.lisp` is the
asserted path that CI treats as supported coverage.
