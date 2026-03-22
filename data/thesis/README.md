# PhD Thesis

This directory holds the thesis document that the repo is trying to make
continuously checkable.

## File

- `Woods PHD CS-96-33 A Method of Program Understanding using Constraint Satisfaction.pdf`

## Why This Matters

The thesis is not just background reading in this project. It is the main
publication target behind the supported validation story.

The repo's primary goal is to keep the solver, preserved baselines, and
reproduction harnesses aligned tightly enough that the thesis-result story
remains explainable from a fresh checkout.

## What The Thesis Covers

At a high level, the thesis:

- presents program understanding as a constraint-satisfaction problem,
- uses ADT recognition as the central application domain,
- introduces the memory-CSP two-phase search methodology,
- and compares it against direct CSP matching and related search variants
  under increasing noise.

## Practical Repo Relationship

These repo areas are the closest operational companions to the thesis:

| Repo area | Role |
|---|---|
| `data/acl-experiments/` | Preserved ACL/SPARC baseline for the main thesis `ij2` / `ij3` / `ij4` story |
| `Q-Batch-SBCL/` | Modern SBCL rerun workspace for that same supported comparison story |
| `tests/validate-artifacts.sh` | Main executable thesis-artifact validation path |
| `tests/validate-thesis-comparison.py` | Thesis-story comparison check between regenerated SBCL summaries and preserved ACL curves |
| `data/sparc-archive/PrevResults/` | Earlier thesis-era and pre-thesis result families that provide historical context but are not the same as the main `ij2` / `ij3` / `ij4` story |

## Rule Of Thumb

If you want the publication narrative, start with the thesis PDF.

If you want the supported executable approximation of that narrative, start
with `data/acl-experiments/`, `Q-Batch-SBCL/`, and `tests/validate-artifacts.sh`.
