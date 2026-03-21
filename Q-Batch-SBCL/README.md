# Q-Batch-SBCL

This directory is the modern SBCL experiment workspace for thesis-result
replication.

## What Lives Here

- `bootstrap*.lisp`, `gen-seeds*.lisp`, `generate-*.lisp`: experiment setup and
  script generation helpers.
- `ij2*.lisp`, `ij3*.lisp`, `ij4*.lisp`: generated per-noise experiment drivers.
- `ij2.sh`, `ij3.sh`, `ij4.sh`, `run-may29-all.sh`, `run-alex-all.sh`: runner
  scripts for the supported experiment families.
- `Graph/`: data extraction, comparison plotting, and tracked overlay outputs.

## Result Layout

This directory mixes tracked experiment infrastructure with runtime-generated
outputs:

- Tracked: runner scripts, bootstrap/generator Lisp files, `Graph/*.py`,
  `Graph/*.gp`, and the checked-in comparison overlay PNGs.
- Generated at runtime: run directories such as `ij2/`, `ij3/`, `ij4/`,
  `may29-ij2/`, `may29-ij3/`, `may29-ij4/`, `alex-ij2/`, `alex-ij3/`,
  `alex-ij4/`, plus console `*.out` files and extracted graph tables/PDFs.

If this directory looks busy, that is normal: it is both the experiment control
surface and the scratch space for regenerated outputs.

## Supported Workflow

Run experiments from the repository root:

```bash
bash Q-Batch-SBCL/ij2.sh
bash Q-Batch-SBCL/ij3.sh
bash Q-Batch-SBCL/ij4.sh
bash Q-Batch-SBCL/run-may29-all.sh
bash Q-Batch-SBCL/run-alex-all.sh
```

Regenerate comparison artifacts:

```bash
bash tests/validate-artifacts.sh
```

That validation path compares regenerated SBCL CI tables against the preserved
ACL baseline under `data/acl-experiments/Graph/`.
