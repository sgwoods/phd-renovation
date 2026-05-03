# Incoming Review Template

Use this template when a real intake batch lands in `incoming/`.

Copy the headings into a batch-local note or adapt them into the review
summary that accompanies promotion decisions.

The point is not paperwork for its own sake.
The point is to keep the big picture intact:

- preserve everything potentially useful,
- avoid losing provenance,
- keep the supported baseline bounded,
- and make future recovery possible without redoing interpretation work.

## Intake Summary

- Intake path:
- Original dump name:
- Reviewed name if renamed:
- Review date:
- Source / where it came from:
- Reviewer:

## Apparent Contents

Check all that apply and add short notes:

- source code
- datasets
- experiment outputs
- publications
- notes
- mixed archive bundle
- other:

## First Read

- What does this batch appear to be?
- What historical period or snapshot does it seem related to?
- Does it appear complete, partial, or mixed?
- Does it look unique or overlapping with material already in the repo?

## Preservation Questions

1. Is this the only known surviving copy?
2. If it overlaps existing material, what seems to be the canonical active copy?
3. Does the overlap still have provenance, lineage, or snapshot-integrity value?
4. Is any part of this batch too important to leave untracked locally?

## Classification

For the batch as a whole, or for major subparts:

- supported baseline candidate
- integrity-checkable archive
- provenance-only
- snapshot-specific
- duplicate but valuable
- duplicate and purely transient
- still pending / too unclear to classify safely

## Destination Decision

Where should the material go?

- stay in `incoming/`
- `data/`
- `historical finds/`
- solver snapshot tree
- documented in `DUPLICATES-REVIEW.md`

If split across destinations, note the split clearly.

## Relationship To Current Project Plan

- Does this change any current blocker?
- Does this strengthen or weaken recovery confidence?
- Does this affect any roadmap lane, such as terrain, `Hanoi-4`, ADT batch,
  thesis result families, or archive provenance?
- Does it justify changing any dashboard/handbook/status wording?

## Next Actions

- What should happen immediately?
- What can wait?
- What should be preserved but not touched yet?

## Index Update

After review, make sure `incoming/INDEX.md` reflects:

- intake path
- added date
- source
- apparent type
- status
- next action

## Rule Of Thumb

If anything is unclear, preserve first and narrow later.
Uncertainty is a reason to classify conservatively, not a reason to discard.
