# docs Guide

This directory contains generated project-status and handbook outputs plus the
structured source data that drives them.

Use this guide when you want to answer:

- which files here are authoritative inputs,
- which ones are generated outputs,
- and which ones are mirrored to the public Pages repo.

## Authoritative Source

`release-dashboard-data.json` is the main structured status source for the
generated project views.

It carries the current build line, focus, roadmap timeline, handbook refresh
policy, and the short public-facing status story used across the generated
outputs.

If the roadmap meaningfully moves, the current blocker changes, the harness
materially changes, or the release focus shifts, update this file and then
regenerate the outputs.

## Generated Repo Outputs

These files are generated from the structured status source and markdown docs:

| File | Role |
|---|---|
| `release-dashboard.html` | Repo-local visual roadmap dashboard |
| `project-handbook.html` | Full generated handbook for human-readable project state |
| `public-phd-renovation.html` | Repo-side source for the public project page |
| `public-phd-renovation-handbook.html` | Repo-side source for the public handbook |
| `public-status-phd-renovation.json` | Manifest export for the shared public status interface |

Do not hand-edit the generated HTML or JSON here unless you are debugging the
generator itself. The normal path is to update the markdown or
`release-dashboard-data.json`, then regenerate.

## Public Sync Role

The repo build produces the PhD-owned public assets that are later copied into
the public Pages repo:

- `phd-renovation.html`
- `phd-renovation-handbook.html`
- `phd-renovation-dashboard.html`
- `data/projects/phd-renovation.json`

The shared public `index.html` is no longer owned directly by this repo.
Instead, this repo exports its project status through
`public-status-phd-renovation.json` in the interface format.

## Normal Regeneration Flow

```bash
python3 tools/generate-release-dashboard.py
bash tests/validate-dashboard.sh
```

That regeneration step updates the dashboard, handbook, public page source,
public handbook source, and status manifest together.

## Rule Of Thumb

If the question is "what is the current official project status view?", start
here.

If the question is "how are these generated?", see `tools/README.md`.
