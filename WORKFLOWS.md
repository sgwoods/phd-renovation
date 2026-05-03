# Operator Workflows

This file is the short map of the repo's main operator-facing workflows.

Use it when the question is not "what does this directory contain?" but
"what do I run for the task in front of me?"

## Supported Primary Workflows

### 1. Interactive Solver Use

Use this when you want a REPL with the primary integrated solver line loaded.

```bash
sbcl --load "src/main.lisp"
```

Best for:

- trying `qcsp3:` entry points by hand,
- exploring queens, ADT, MPR, or memory search interactively,
- quick operator checks that do not need the full regression spine.

Main guide: `src/README.md`

### 2. Full Validation Spine

Use this when you want the supported confidence check for the repo.

```bash
sbcl --non-interactive --load "tests/run.lisp"
bash tests/validate-artifacts.sh
bash tests/validate-dashboard.sh
bash tests/validate-ff-provenance.sh
bash tests/validate-adt-batch.sh
bash tests/validate-csp-batch.sh
bash tests/validate-ao.sh
```

Best for:

- pre-merge confidence,
- post-change regression checks,
- confirming the supported thesis-validation baseline and status outputs.

Main guide: `tests/README.md`

### 3. Thesis Experiment Replication

Use this when you want to regenerate the supported SBCL experiment families.

```bash
bash Q-Batch-SBCL/ij2.sh
bash Q-Batch-SBCL/ij3.sh
bash Q-Batch-SBCL/ij4.sh
bash Q-Batch-SBCL/run-may29-all.sh
bash Q-Batch-SBCL/run-alex-all.sh
```

Best for:

- regenerating the modern experiment workspace,
- comparing qcsp3, may29, alex, and preserved ACL baselines,
- rebuilding the plotted thesis-result story.

Main guide: `Q-Batch-SBCL/README.md`
Plot/data-flow guide: `Q-Batch-SBCL/Graph/README.md`

### 4. Status, Dashboard, Handbook, And Public Page Sync

Use this when plan/status wording changes.

```bash
python3 tools/generate-release-dashboard.py
bash tests/validate-dashboard.sh
```

Best for:

- keeping the release dashboard, full handbook, public project page, and
  status manifest in sync,
- validating that generated docs/status outputs match the structured source
  data and tracked markdown sources.

Main sources:

- `docs/release-dashboard-data.json`
- `tools/generate-release-dashboard.py`
- `docs/README.md`
- `tools/README.md`

### 5. Release Hardening

Use this when preparing a `1.0.0` release candidate.

```bash
python3 tools/generate-release-dashboard.py
sbcl --non-interactive --load "tests/run.lisp"
bash tests/validate-artifacts.sh
bash tests/validate-ff-provenance.sh
bash tests/validate-adt-batch.sh
bash tests/validate-csp-batch.sh
bash tests/validate-ao.sh
bash tests/validate-dashboard.sh
```

Best for:

- final release-candidate confidence,
- making sure the public/status outputs are current,
- checking the exact release gate in `RELEASE-1.0-CHECKLIST.md`.

Main guides:

- `RELEASE-1.0-CHECKLIST.md`
- `RENOVATION.md`

### 5a. New Mac Startup / Retirement Handoff

Use this when you want to stand the project up on a different Mac and verify
that the current machine can be retired safely.

```bash
bash scripts/start-codex-new-mac.sh
```

If Quicklisp is not installed yet:

```bash
bash scripts/start-codex-new-mac.sh --install-quicklisp
```

Main guides:

- `NEW-MAC-HANDOFF.md`
- `RECOVERY-AND-REPRODUCIBILITY.md`

### 6. New Material Intake

Use this when new code, data, papers, or experiment artifacts arrive.

1. Easiest path: drop the material into `incoming/_landing/`.
   Codex can then create the proper intake batch and move it into place.
   Or, if you want to scaffold it yourself, run:

```bash
python3 tools/create_incoming_intake.py 2026-05-03-example \
  --added 2026-05-03 \
  --source "Lacie1 drive" \
  --type "mixed archive bundle"
```

2. More manual path: drop the material under `incoming/` using any convenient dump name.
   Or scaffold the intake with:

```bash
python3 tools/create_incoming_intake.py 2026-05-03-example \
  --added 2026-05-03 \
  --source "Lacie1 drive" \
  --type "mixed archive bundle"
```

3. Review it.
4. Normalize the intake folder label if the contents reveal a better date/source.
5. Update `incoming/INDEX.md`.
6. Promote it into `data/`, `historical finds/`, a snapshot tree, or
   `DUPLICATES-REVIEW.md`.

Main guides:

- `incoming/README.md`
- `incoming/INDEX.md`
- `incoming/REVIEW-TEMPLATE.md`
- `INTAKE-ROADMAP.md`
- `tools/create_incoming_intake.py`

## Secondary / Manual Workflows

These are still useful, but they are not the main supported operator path.

### Manual AO Harnesses

```bash
sbcl --non-interactive --load "run-test4.lisp"
sbcl --non-interactive --load "run-test4-may29.lisp"
sbcl --non-interactive --load "run-test4-alex.lisp"
```

Use these for:

- historical/manual AO checking,
- understanding the legacy `test4` loaders,
- comparing the manual harnesses to the asserted AO runner.

Supported AO confidence still comes from `tests/ao-run.lisp`.

### Legacy Loader / Renovation Helpers

- `run-csp-tests.lisp`
- `renovate.lisp`

These remain part of the repo's historical/operator context, but they are not
the primary supported flow for current work.

## Rule Of Thumb

If the task is about confidence, use `tests/`.

If the task is about interactive solver use, use `src/main.lisp`.

If the task is about the thesis-result experiment story, use `Q-Batch-SBCL/`.

If the task is about new finds, use `incoming/` first.
