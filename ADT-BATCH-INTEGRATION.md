# ADT Batch Integration Bridge

This file defines the first deliberate post-M1 integration target:

**bring the preserved ADT batch `ij1`-`ij4` family closer to the integrated
solver line in a controlled, explainable way.**

It does not claim that the family is executable through `qcsp3/` yet.
It defines how to get there without blurring archive provenance and supported
baseline behavior.

## Why This Family First

The ADT batch family is the best next integration target because:

1. it is already integrity-checkable through `tests/validate-adt-batch.sh`,
2. it sits close to the direct ADT matching line that still exists in the
   maintained solver trees,
3. it extends historical coverage without depending on blocked terrain
   recovery, and
4. it is a more natural bridge than the earlier `T1`-`T6` family, which is
   historically valuable but farther from the current integrated solver story.

## Preserved Family

Current preserved source of truth:

- `data/csp-adt-batch/`

Current integrity check:

- `tests/validate-adt-batch.sh`

The preserved family contains four direct-CSP ADT experiment lines:

| Family | Historical method | Current bridge reading |
|---|---|---|
| `ij1` | Backtracking only | ADT direct match with BT-style settings |
| `ij2` | FCDR | ADT direct match with FC + DR |
| `ij3` | AC-3 + BT | ADT direct match with AC-3 preprocessing plus BT |
| `ij4` | AC-3 + FCDR | ADT direct match with AC-3 preprocessing plus FC + DR |

Important note:

These `ij1`-`ij4` names are **not** the same family as the later thesis
`ij2` / `ij3` / `ij4` memory-CSP line under `Q-Batch-SBCL/`.

## Preserved Driver Inventory

The preserved archive does not use one driver file per family. It uses a small
set of batch-part driver files plus shell wrappers:

| Family | Preserved driver files | Preserved shell wrapper | Historical knob pattern |
|---|---|---|---|
| `ij1` | `ij1-5-bt.lisp` and earlier sibling parts referenced by `ij1-bt.sh` | `ij1-bt.sh` | plain `adt` with noise/template/random/output knobs only |
| `ij2` | `ij2-1-fcdr.lisp` through `ij2-5-fcdr.lisp` | `ij2-fcdr.sh` | `adt` plus `:forward-checking t` and `:dynamic-rearrangement t` |
| `ij3` | `ij3-1-ac.lisp` through `ij3-5-ac.lisp` | `ij3-ac.sh` | `adt` plus `:arc-consis 'before` |
| `ij4` | `ij4-1-acfcdr.lisp` and sibling parts referenced by `ij4-acfcdr.sh` | `ij4-acfcdr.sh` | `adt` plus `:arc-consis 'before`, `:forward-checking t`, and `:dynamic-rearrangement t` |

Shared preserved facts across those drivers:

1. they all call `adt` directly,
2. they all use `:situation-id "adt-t2-1"` and `:template-id "adt-t2"`,
3. they all vary `:sit-noise`, `:random-ident`, and `:output-file`,
4. they all depend on the old `load` chain rooted in the base `csp` tree,
5. and the shell wrappers all run from historical `/u/sgwoods/csp`.

## Current State

What is already true:

- the archive structure is preserved,
- the raw result grids are present,
- the historical CI summaries are present,
- the family is automated as an integrity check,
- and the repo now treats it as the next post-M1 bridge.

What is not true yet:

- there is no supported modern rerun workflow for this family,
- there is no normalized qcsp3-era driver for these experiment modes,
- and there is no published equivalence claim between a modern rerun and the
  preserved ADT batch summaries.

## First Investigation Result

The first narrow executable bridge now exists for one preserved case:

- family: `ij2`
- case: `noise 50`, `random-ident "default"`
- host: `csp:adt`

Current result:

- the bridge runs successfully through `csp:adt`,
- it reproduces the expected knob pattern (`BT`, node consistency on, no AC,
  `FC`, `DR`, `random-ident default`, `RANDOM` ordering),
- but it does **not** yet reproduce the preserved non-timing metrics.

Current observed divergence versus preserved `ij2-050.1`:

| Metric | Preserved | Current bridge |
|---|---:|---:|
| Average domain size | 10.8 | 14.0 |
| NCC | 450 | 520 |
| TCC | 269 | 383 |
| BT / visited | 13 / 16 | 14 / 17 |
| FC cost | 366 | 563 |
| DR cost | 18 | 23 |

That means the first bridge is already useful: it has moved the ADT batch
family from "pure archive" to "executable investigation," but it has not yet
crossed into reproduction.

## Bridge Strategy

The safest bridge is:

1. keep `data/csp-adt-batch/` as the preserved historical source,
2. document the experiment-to-search-mode mapping clearly,
3. identify which maintained solver line is the best executable stand-in for
   each family,
4. create a modern reproduction harness only after that mapping is stable, and
5. compare modern outputs against the preserved archive without rewriting the
   archive itself.

## Candidate Executable Mapping

Working hypothesis:

| Preserved family | Closest maintained executable line |
|---|---|
| `ij1` | `csp:adt` or `qcsp3:adt` with BT-oriented settings |
| `ij2` | `csp:adt` or `qcsp3:adt` with FC + DR |
| `ij3` | `csp:adt` or `qcsp3:adt` with AC-3 + BT |
| `ij4` | `csp:adt` or `qcsp3:adt` with AC-3 + FC + DR |

This mapping is the bridge hypothesis, not a finished validation claim.

## First Host Recommendation

For the **first executable bridge**, the better host is:

**`csp/` first, then compare against `qcsp3/` later if useful.**

Why `csp/` is the better first bridge host:

1. the preserved drivers are clearly rooted in the historical base solver tree
   (`/u/sgwoods/csp`) rather than a later integrated line,
2. `csp:adt` already matches the preserved default IDs
   (`"adt-t2-1"` / `"adt-t2"`),
3. the preserved driver knobs map directly onto the simpler `csp:adt`
   interface without having to neutralize qcsp3-specific defaults,
4. `qcsp3:adt` adds later integrated-line features and different defaults
   (for example the Quilici-oriented defaults and extra override/suppression
   controls), which make it a stronger long-term target but a noisier first
   reproduction surface,
5. and a first successful `csp` bridge will give us a cleaner historical
   reference point before we ask whether `qcsp3` can stand in for the same
   family.

So the recommended sequence is:

1. build the first narrow rerun harness against `csp:adt`,
2. validate that it reproduces the preserved family shape credibly,
3. then investigate whether `qcsp3:adt` can inherit or absorb that bridge.

## First Concrete Deliverables

The next useful steps for this bridge are:

1. inventory the preserved `ij*.lisp`, shell runners, and summary scripts under
   `data/csp-adt-batch/`,
2. map their knobs onto the maintained ADT entry points,
3. define the first narrow `csp:adt` rerun harness for one family,
4. define what "success" means for that first rerun:
   exact file-shape match, trend match, or bounded metric match,
5. only then decide how and whether `qcsp3` should absorb the bridge.

The first three steps are now complete at investigation level.
The next live question is whether the current divergence comes from:

1. changed random-state lineage,
2. changed ADT situation/template data,
3. solver-behavior drift in `csp/`,
4. or a difference between preserved batch-output conventions and the current
   base solver reporting path.

The current leading suspect is now **random-state lineage**. The surviving
`Rnddefault` bundles in `qcsp-may29-1996/`, `qcsp3/`, `qcsp-alex-sep16-1997/`,
and `historical finds/yj-sun/Csp/` are not byte-identical, and the bridge was
originally borrowing only the May29 copy. The new
`tests/investigate-adt-batch-random-lineage.sh` probe exists to compare the
same `ij2` bridge case across those surviving default bundles before we blame
the core solver.

Current result from that probe:

| `Rnddefault` source | Tracked mismatches | Distance score | Current read |
|---|---:|---:|---|
| `qcsp3/ADT-Random/Rnddefault` | 6 | 391.2 | Closest surviving default bundle so far; still not a reproduction, but much nearer to the preserved `ij2-050.1` metrics than the others. |
| `qcsp-may29-1996/ADT-Random/Rnddefault` | 6 | 1273.8 | Significantly further away than the qcsp3 bundle. |
| `qcsp-alex-sep16-1997/ADT-Random/Rnddefault` | 6 | 1345.4 | Furthest successful surviving bundle among the maintained snapshots. |
| `historical finds/yj-sun/Csp/ADT-Random/Rnddefault` | load failure | n/a | Does not currently load cleanly through the `csp` bridge path. |

That does not prove random lineage is the entire story, but it does move the
investigation from "generic random-state suspicion" to a concrete next read:
the base `csp` bridge is much closer when seeded from the surviving qcsp3
default bundle than when seeded from the may29 or alex copies.

Because of that, the narrow bridge probe in
`tests/investigate-adt-batch-bridge.sh` now defaults to the surviving
`qcsp3/ADT-Random/Rnddefault` bundle rather than the May29 copy. The script
still accepts `PHD_ADT_BRIDGE_RANDOM_SOURCE=...` when we want to compare other
surviving seed bundles on purpose.

That default change materially improved the first `ij2` bridge reading:
the bridge still diverges, but it now stays much closer to the preserved
archive on NCC, TCC, BT/visited, and FC/DR cost than the earlier May29-seeded
probe did.

## Non-Goal

This bridge does **not** mean:

- rewriting the preserved historical files,
- moving the archive under `qcsp3/`,
- or claiming the family is already integrated just because it is now a named
  target.

The goal is to turn an integrity-checkable preserved family into the next
deliberate integration experiment, with provenance still intact.
