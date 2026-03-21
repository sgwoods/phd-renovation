# Duplicates And Redundancy Review

This file records historical data and files that have been reviewed for
redundancy.

Its purpose is to separate two different cases clearly:

1. **Reviewed duplicate / redundant for the active main project**
   The repo already has a canonical copy elsewhere, and the duplicate is kept
   only for snapshot integrity or provenance.
2. **Looks duplicate, but still has go-forward value**
   The material overlaps another tree, but still matters for lineage,
   historical context, or recovery work.

## Status Key

- `Canonical elsewhere`: do not treat this copy as the active source of truth.
- `Retain for provenance`: keep it, but do not build new supported workflows on it.
- `Still go-forward valuable`: overlapping material still has a distinct role.

## Reviewed Items

| Area | Review result | Canonical / active path | Why kept | Go-forward read |
|---|---|---|---|---|
| `qcsp-may29-1996/Q-Batch/` | Reviewed duplicate | `data/acl-experiments/` | Preserved inside the May 1996 snapshot for historical integrity | Not needed as a separate active dataset in the main project |
| `qcsp-may29-1996/Q-Batch/Graph/ij2-ci.dat`, `ij3-ci.dat`, `ij4-ci.dat` | Verified duplicate by content | `data/acl-experiments/Graph/ij2-ci.dat`, `ij3-ci.dat`, `ij4-ci.dat` | Snapshot-local preserved copy | Canonical validation should use `data/acl-experiments/Graph/` |
| `historical finds/yj-sun/Csp/MyBatch/` vs `qcsp-alex-sep16-1997/MyBatch/` | Exact-match overlap exists | `qcsp-alex-sep16-1997/MyBatch/` for tracked snapshot use | Archive copy helps provenance and recovery analysis | Still useful for archive lineage, not an active duplicate to prune casually |
| `historical finds/yj-sun/Csp/SteveBkps/bt.lisp` vs alex backup copy | Exact-match overlap exists | `qcsp-alex-sep16-1997/SteveBkps/bt.lisp` | Archive provenance | No separate active role, but harmless as archive evidence |
| `historical finds/yj-sun/Csp/testdata/Results/PS/*` vs `data/sparc-archive/PrevResults/*` carry-forwards | Partial exact carry-forward overlap | `data/sparc-archive/PrevResults/` for tracked thesis-era preserved results | Archive source tree explains where many carry-forwards came from | Still valuable for provenance, not redundant enough to treat as disposable |
| `qcsp-may29-1996/NewData4b-Batch/Graph/ff*` vs `data/sparc-archive/PrevResults/ff*` | Overlapping preserved family, not redundant | Both matter | One is the stronger source-tree provenance anchor, the other is the preserved thesis-era carry-forward layer | Still go-forward valuable as a paired provenance story |

## Practical Rule

If a reviewed duplicate is needed for:

- snapshot integrity,
- thesis/result provenance,
- or archive-recovery explanation,

keep it, but mark its canonical active counterpart clearly.

If it is a true duplicate for day-to-day supported workflows, point users to
the canonical location and avoid expanding the supported validation flow around
the duplicate copy.

## Current Canonical Copy Rules

1. For the active ACL thesis-result baseline, prefer `data/acl-experiments/`
   over `qcsp-may29-1996/Q-Batch/`.
2. For the active preserved `ff*` lineage, treat
   `qcsp-may29-1996/NewData4b-Batch/` and `data/sparc-archive/PrevResults/ff*`
   as paired provenance layers rather than competing duplicates.
3. For archive intake under `historical finds/`, do not assume exact-match
   overlap means “safe to discard.” Many such copies still help explain how the
   tracked snapshot was assembled.

## Maintenance Rule

Update this file whenever:

1. a new duplicate tree is positively identified,
2. a canonical active copy is chosen for a preserved family,
3. an archive overlap is reviewed and judged to still have provenance value, or
4. a previously ambiguous overlap is reclassified as truly redundant.
