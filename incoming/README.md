# Incoming

This directory is the **single intake bucket** for newly found material that
may be relevant to the project:

- source trees
- datasets
- experiment outputs
- publications
- notes
- recovered archives

Think of this as the shell-friendly implementation of:

`new relevant information to integrate`

## Purpose

Use `incoming/` first whenever new material arrives and its final home is not
yet settled.

Do **not** drop new finds directly into:

- `qcsp3/`
- `csp/`
- `qcsp-may29-1996/`
- `qcsp-alex-sep16-1997/`
- `data/`
- `historical finds/`

until that material has been reviewed.

## Intake Workflow

1. Add the new material under a dated subdirectory, for example:
   - `incoming/2026-03-21-lacie1/`
   - `incoming/2026-04-02-sparc-cdrom/`
   - `incoming/2026-04-10-paper-scan/`
2. Add a short note describing:
   - where it came from,
   - what it appears to contain,
   - and whether it looks like code, data, publication, or mixed material.
3. Update `incoming/INDEX.md` with one row for the new intake.
4. Review the intake before promoting anything out of `incoming/`.
5. After review, move or classify it into one of these destinations:
   - `data/` for canonical preserved datasets/publications
   - `historical finds/` for archive/recovery material
   - a solver snapshot tree if it clearly belongs there
   - `DUPLICATES-REVIEW.md` if it is a reviewed duplicate/redundant copy

## Review Outcomes

Every reviewed intake should end in one of these states:

- `promoted`: moved into the main repo structure
- `historical`: retained under `historical finds/`
- `duplicate`: documented as redundant/canonical elsewhere
- `reference-only`: preserved, but not integrated
- `pending`: still under review

## Rule Of Thumb

If the right home is not obvious yet, it belongs in `incoming/`.
