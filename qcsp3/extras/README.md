# qcsp3 extras

Local guide to the non-ASDF AO support layer under the primary integrated
solver tree.

## Role

`qcsp3/extras/` is the preserved AO / `test4` support workspace used by the
supported legacy AO validation path. It is important, but it is **not** part
of the main `:qcsp3` ASDF load.

Think of this directory as:

- required for the bounded supported AO baseline,
- historically tied to the `test4` family,
- and separate from the core queens / ADT / MPR / memory-search line.

## What Loads It

The main current entry points are:

- `tests/ao-run.lisp`
- `run-test4.lisp`
- `run-test4-may29.lisp`
- `run-test4-alex.lisp`

If you only load `src/main.lisp` or the `:qcsp3` ASDF system, these files are
not loaded automatically.

## File Roles

| File | Role |
|---|---|
| `ac-graph.lisp` | AO graph representation and graph-level helpers |
| `hierarchy.lisp` | AO ordering hierarchy and relation layering |
| `ao-ac3.lisp` | AO AC-3 style propagation path |
| `ao-ac-new.lisp` | Alternate AO propagation path |
| `ao-revise.lisp` | Shared revise support |
| `ao-revise-step.lisp` | Step-oriented AO revise implementation |
| `ao-revise-aggressive.lisp` | Aggressive AO revise implementation |
| `ao-revise-fns.lisp` | Shared revise helper functions |
| `applyr.lisp` | Relation application / propagation helpers |
| `example-extend.lisp` | Mutable example graph setup used by the legacy harness |
| `test4.lisp` | Legacy AO harness definitions and wrapper entry points |
| `comment.lisp` | Preserved AO comments / historical context file |
| `compile-ao.lisp` | Historical compile helper for the AO layer |

## Supported Status

This directory is inside the supported validation umbrella, but only through a
bounded surface:

- `tests/ao-qcsp3-suite.lisp`
- `tests/ao-may29-suite.lisp`
- `tests/ao-alex-suite.lisp`
- `bash tests/validate-ao.sh`

That means the repo currently treats these files as:

- supported enough for the asserted AO baseline,
- historically valuable beyond that,
- but not part of the main integrated solver line in the same way as
  `qcsp3/queens.lisp`, `qcsp3/adt-simple.lisp`, or `qcsp3/memory-csp.lisp`.

## Practical Reading Order

If you need to understand or debug this layer, read in this order:

1. `test4.lisp`
2. `example-extend.lisp`
3. `ac-graph.lisp`
4. `ao-ac3.lisp` and `ao-ac-new.lisp`
5. `ao-revise-step.lisp` and `ao-revise-aggressive.lisp`
6. `applyr.lisp`
7. `hierarchy.lisp`

## What This Directory Is Not

- It is not the canonical home of the main integrated solver APIs.
- It is not part of the thesis `ij2` / `ij3` / `ij4` result pipeline.
- It is not a general-purpose utility library for the rest of the repo.

## Rule Of Thumb

If the task is about AO or `test4`, come here.

If the task is about the integrated solver line, start one level up in
`qcsp3/`.
