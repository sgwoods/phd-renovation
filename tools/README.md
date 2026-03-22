# tools Guide

This directory contains the repo's maintained documentation/status generators.

Use this guide when you want to know which script owns the dashboard, handbook,
public page, or status manifest.

## Primary Scripts

### `generate-release-dashboard.py`

This is the top-level status/doc generation entry point.

It regenerates the project-facing outputs that need to stay synchronized:

- `docs/release-dashboard.html`
- `docs/public-phd-renovation.html`
- `docs/public-status-phd-renovation.json`
- `docs/project-handbook.html`
- `docs/public-phd-renovation-handbook.html`

Run this after any meaningful roadmap, blocker, harness, or release-focus
change.

### `generate_project_handbook.py`

This builds the long-form handbook from the repo's source markdown documents.

Normally you do not need to call it directly, because
`generate-release-dashboard.py` already includes it as part of the regular
docs/status build.

Use it directly only when debugging handbook generation in isolation.

## Source Ownership

The generators draw from:

- `docs/release-dashboard-data.json` for structured roadmap/status data
- the tracked markdown documents listed in `generate_project_handbook.py`

If a new guide should appear in the handbook, add it to the handbook source
list in `generate_project_handbook.py`.

## Validation Pair

The supported validation check for these scripts is:

```bash
python3 tools/generate-release-dashboard.py
bash tests/validate-dashboard.sh
```

If validation fails after a source change, the generated files in `docs/` are
out of date or inconsistent with the expected public/status outputs.

## Rule Of Thumb

Update source docs and status data first.

Then regenerate through `generate-release-dashboard.py`.

Then validate with `tests/validate-dashboard.sh`.
