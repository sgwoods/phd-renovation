# ADT Batch Snapshot Note

This file records the investigation state for the preserved ADT batch family.

Current project decision:

**treat the preserved ADT batch `ij1`-`ij4` family as a
snapshot-specific, integrity-checkable historical family rather than a
required reproduction target for the integrated `qcsp3` line.**

It remains historically important, and the repo keeps the bridge probes
because they explain the divergence. But the family is no longer the default
next integration target.

## Why This Family Was Investigated

The ADT batch family was investigated because:

1. it is already integrity-checkable through `tests/validate-adt-batch.sh`,
2. it sits close to the direct ADT matching line that still exists in the
   maintained solver trees,
3. it extends historical coverage without depending on blocked terrain
   recovery, and
4. it looked, at first, like a plausible post-M1 bridge into older direct-ADT
   result families.

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

## Investigation Strategy

The safest way to investigate the family was:

1. keep `data/csp-adt-batch/` as the preserved historical source,
2. document the experiment-to-search-mode mapping clearly,
3. identify which maintained solver line is the best executable stand-in for
   the family,
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

This mapping remains a bridge hypothesis, not a finished validation claim.

## Host Comparison Result

For the **narrow executable bridge probes**, the better maintained host is:

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

That made `qcsp3` the better probe host, but not enough to justify folding the
family into the integrated line.

## Why It Is Now Snapshot-Specific

The current evidence points to a real model split rather than one missing file
or one bad random seed:

1. the preserved ADT batch archive remains intact and integrity-checkable,
2. the narrow `csp` and `qcsp3` bridge probes both run, but neither reproduces
   the preserved `ij2` metrics,
3. the normalized `old-dist1-pre-quilici` probe makes the fit worse, not
   better,
4. the structure probe shows `qcsp3` builds a smaller noise layer with the
   strongest node-domain squeeze on `t2-c`,
5. and the generator probe shows that maintained `csp/dist1` and
   maintained `qcsp3/dist1` are different ADT noise models, not the same model
   with minor drift.

That combination makes the current project stance:

- keep the family preserved and integrity-checkable,
- keep the bridge notes as provenance and explanation,
- but do **not** require `qcsp3` to reproduce this family as part of the
  supported integrated baseline.

## What Stays Useful

Even with the snapshot-specific classification, the investigation work still
matters because it established:

1. where the divergence starts,
2. which maintained line is closer,
3. that old-dist restoration is not the missing key,
4. and that the remaining gap is rooted in a different ADT noise model.

## If Revisited Later

If the project chooses to revisit ADT batch integration later, the right
question is no longer "can `qcsp3` just rerun the family?" It is:

1. should a dedicated legacy-ADT emulation harness exist for this archive, or
2. is the current snapshot-specific classification sufficient for the
   gold-standard line?

## Concrete Deliverables Already In Place

The useful deliverables from this investigation are now:

1. inventory the preserved `ij*.lisp`, shell runners, and summary scripts under
   `data/csp-adt-batch/`,
2. map their knobs onto the maintained ADT entry points,
3. define narrow `csp` and `qcsp3` rerun harnesses,
4. isolate random-state, preprocessing, structure, and generator drift,
5. and leave a clear explanation for why the family is being treated as
   snapshot-specific.

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

The next probe also answered a more important question:
`tests/investigate-adt-batch-input-shape.sh` shows that the divergence now
starts **before search**, not inside backtracking. Under the closer qcsp3 seed
bundle, the generated bridge input state currently reports:

| Input-shape probe field | Current bridge value |
|---|---:|
| Situation size | 104 |
| Raw variable count | 5 |
| Raw average domain size | 104.0 |
| Node-consistent average domain size | 14.0 |
| Node-consistency checks | 520 |

Those last two values exactly match the bridge line's `Dsize` and `NCC`
columns (`14.0` and `520`). That means the remaining mismatch is already
present by the time preprocessing finishes. The current highest-value next
question is therefore not "why does search branch differently?" but
"why does the generated situation / node-consistency surface differ from the
preserved `ij2-050.1` case?"

`tests/investigate-adt-batch-source-drift.sh` now compares that same
pre-search surface across maintained source/dist variants using the surviving
`qcsp3/ADT-Random/Rnddefault` bundle:

| Probe | Situation size | Raw avg domain | Node avg domain | Node checks | Read |
|---|---:|---:|---:|---:|---|
| `csp/dist1` | 104 | 104.0 | 14.0 | 520 | Current narrow bridge baseline |
| `qcsp3/dist1` | 87 | 87.0 | 8.4 | 435 | Materially closer to preserved `ij2-050.1` on the pre-search `Dsize` / `NCC` pair |
| `qcsp3/old-dist1-pre-quilici` | 111 | 111.0 | 12.2 | 490 | Runs when the carried distribution is normalized inside a temporary bridge copy, but lands farther from the preserved `ij2-050.1` metrics than `qcsp3/dist1` |

That means the source-definition question is now sharper:
although the preserved wrappers look closer to the older `csp` tree, the
maintained `qcsp3` ADT setup currently produces a preprocessing surface
closer to the preserved `ij2` case than either the maintained `csp` setup
or the normalized `old-dist1-pre-quilici` variant does.
The next useful bridge step is therefore no longer "repair old-dist1 and see
if that explains the preserved case." That probe now runs and makes the fit
worse. The next step is to understand why the maintained `qcsp3/dist1`
preprocessing surface is still offset from the preserved archive.

That dedicated `qcsp3`-side runner now exists as
`tests/investigate-adt-batch-qcsp3-bridge.sh` /
`tests/run-adt-batch-bridge-qcsp3-ij2.lisp`. Using the same surviving
`qcsp3/ADT-Random/Rnddefault` bundle, it currently produces:

| Metric | Preserved `ij2-050.1` | `csp` bridge | `qcsp3` bridge |
|---|---:|---:|---:|
| Average domain size | 10.8 | 14.0 | 8.4 |
| NCC | 450 | 520 | 435 |
| TCC | 269 | 383 | 221 |
| BT / visited | 13 / 16 | 14 / 17 | 14 / 18 |
| Number of solutions | 3 | 3 | 4 |
| FC cost | 366 | 563 | 300 |
| DR cost | 18 | 23 | 18 |

That does **not** make `qcsp3` a reproduction yet, but it does change the
bridge recommendation: the maintained `qcsp3` line is now the closer
executable host for the first narrow `ij2` ADT batch bridge than the
maintained `csp` line.

The strongest next step is no longer "can `qcsp3` run the case at all?".
It is now "why does `qcsp3` still differ on the remaining bounded metrics,
especially solution count and the pre-search `Dsize` / `NCC` / `TCC` surface?"

`tests/investigate-adt-batch-structure-drift.sh` now drills into that
pre-search surface directly for maintained `csp/dist1` versus `qcsp3/dist1`.
The current result is that the drift is visible in both the generated noise
mix and the per-variable node-consistent domains:

| Probe | Base size | Total size | Noise size | Node avg domain | Node checks |
|---|---:|---:|---:|---:|---:|
| `csp/dist1` | 15 | 104 | 89 | 14.0 | 520 |
| `qcsp3/dist1` | 15 | 87 | 72 | 8.4 | 435 |

Key structural differences from that probe:

- `qcsp3/dist1` currently generates 17 fewer noise statements than `csp/dist1`.
- The largest statement-mix deltas are fewer `begin` / `end` noise blocks and
  more `check` noise statements under `qcsp3`.
- The node-domain squeeze is not evenly distributed. The largest drop is on
  `t2-c`, which falls from 32 candidates under `csp` to 13 under `qcsp3`.

That makes the next investigation target much sharper: compare why the
maintained `qcsp3` path is generating a smaller, differently shaped noise
surface for the same random bundle, and why that especially compresses the
`t2-c` candidate domain.

`tests/investigate-adt-batch-generator-drift.sh` now compares the maintained
source definitions directly. It confirms that the preprocessing drift is not
just about random-state lineage:

- `csp/dist1` and `qcsp3/dist1` are different distributions, not just the same
  label carried forward. `qcsp3/dist1` adds `while`, `increment`, and
  `not-equals`, increases `block`, `assign`, `decl`, and `check` weight, and
  no longer matches the original equal-weight seven-family `csp/dist1`.
- `qcsp3` also changed the generator behavior, not just the weights. It uses
  `get-line-number` / `get-specific-line` instead of `random-position`,
  supports saved-situation reload, names `for` blocks explicitly, and allows an
  extra `increment` branch inside generated loop bodies.
- The normalized `old-dist1-pre-quilici` probe shows that restoring the old
  weight family alone is not enough. The maintained `qcsp3` generator semantics
  still differ materially from the older `csp` path.

That narrows the post-M1 design choice:

1. either emulate the older `csp` ADT noise semantics inside a controlled
   `qcsp3` bridge harness when reproducing ADT batch results,
2. or treat the ADT batch family as snapshot-specific and document the bounded
   divergence rather than forcing the modern integrated line to mimic it.

## Non-Goal

This bridge does **not** mean:

- rewriting the preserved historical files,
- moving the archive under `qcsp3/`,
- or claiming the family is already integrated just because it is now a named
  target.

The goal is to turn an integrity-checkable preserved family into the next
deliberate integration experiment, with provenance still intact.
