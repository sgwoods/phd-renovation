# qcsp-may29-1996 extras

Local guide to the May 29, 1996 snapshot's AO / `test4` support layer.

## Role

`qcsp-may29-1996/extras/` contains the non-ASDF AO support files used by the
May29 snapshot. This is the May29 counterpart to `qcsp3/extras/`.

It matters because:

- the supported AO validation spine still exercises this snapshot,
- the files preserve the mid-lineage AO implementation state,
- and they help explain the historical relationship between May29 and the
  later integrated `qcsp3` AO surface.

## What Loads It

The main current entry points are:

- `tests/ao-run.lisp`
- `run-test4-may29.lisp`

These files are not part of the `:qcsp-may29-1996` ASDF system by default.

## File Roles

| File | Role |
|---|---|
| `ac-graph.lisp` | AO graph representation and graph-level helpers |
| `hierarchy.lisp` | AO ordering hierarchy and relation layering |
| `ao-ac3.lisp` | AO AC-3 style propagation path |
| `ao-ac-new.lisp` | Alternate AO propagation path |
| `ao-revise.lisp` | Shared revise support / preserved stub |
| `ao-revise-step.lisp` | Step-oriented AO revise implementation |
| `ao-revise-aggressive.lisp` | Aggressive AO revise implementation |
| `ao-revise-fns.lisp` | Shared revise helper functions |
| `applyr.lisp` | Relation application / propagation helpers |
| `example-extend.lisp` | Mutable example graph setup used by the legacy harness |
| `test4.lisp` | Legacy AO harness definitions and wrapper entry points |
| `comment.lisp` | Preserved AO comments / historical context file |
| `compile-ao.lisp` | Historical compile helper for the AO layer |

## Supported Status

This directory participates in the supported validation umbrella only through
the bounded AO path:

- `tests/ao-may29-suite.lisp`
- `bash tests/validate-ao.sh`

That means it is:

- supported for the asserted legacy AO baseline,
- historically meaningful beyond that,
- but not part of the main May29 ASDF load used by the core solver suites.

## Relationship To qcsp3/extras

This directory and `qcsp3/extras/` are intentionally similar.

In practice:

- May29 preserves the earlier snapshot-local AO layer,
- `qcsp3/extras/` is the later integrated line's AO counterpart,
- and the current supported AO baseline compares them through the shared
  asserted harness.

## What This Directory Is Not

- It is not the canonical home of the main May29 solver APIs.
- It is not part of the thesis `ij2` / `ij3` / `ij4` artifact pipeline.
- It is not a general utility directory for the rest of the snapshot.

## Rule Of Thumb

If the task is about May29 AO behavior or `run-test4-may29.lisp`, start here.

If the task is about the May29 snapshot's main solver line, start one level up
in `qcsp-may29-1996/`.
