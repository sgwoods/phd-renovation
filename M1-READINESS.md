# Milestone M1 Readiness

This file answers one narrow question:

**What still matters for Milestone M1, and are any remaining non-terrain
historical families still blocking it?**

Short answer: **no additional non-terrain family is currently an undisclosed
M1 blocker.** The only explicitly blocked major historical lane remains the
terrain domain, and that is outside M1 by design.

Project decision as of March 21, 2026: **Milestone M1 is accepted.**

## M1 Gate Checklist

| Gate | Current status | Evidence | M1 read |
|---|---|---|---|
| Supported FiveAM/core baseline | Met | `tests/run.lisp` | Core solver baseline is already part of the validated line. |
| Supported PhD `ij2` / `ij3` / `ij4` trend story | Met | `tests/validate-artifacts.sh`, `tests/validate-thesis-comparison.py` | This is the central executable thesis baseline and remains the main gate. |
| Asserted AO baseline | Met for bounded scope | `tests/ao-run.lisp`, `tests/validate-ao.sh` | M1 accepts the current honest AO boundary: qcsp3 and May29 now assert AO cases 1-3 across the reduction families plus `test4s` / `test4a`, while alex keeps its revise baseline. Broader AO breadth can stay post-M1. |
| Preserved `ff1` / `ff2` / `ff3` relationship | Met as integrity-checked | `tests/validate-ff-provenance.sh` | M1 does not require `ff*` to be rerunnable through `qcsp3/`; it requires the family to stay explicitly connected and checked. |
| Meaningful snapshot deltas documented | Met | `INTEGRATION-DELTAS.md` | The remaining snapshot differences are now explicit rather than folklore. |
| Validation/dashboard/public status flow | Met | `tests/validate-dashboard.sh`, `docs/public-status-phd-renovation.json` | Operator/public status outputs are now part of the maintained baseline flow. |

## Non-Blocking For M1

These matter historically, but they are **not** first-gate blockers for M1:

| Family / lane | Current state | Why it does not block M1 |
|---|---|---|
| Early `exp-1` / `exp-2` / `exp-3` families | Integrity-checkable/documented lineage | Useful for broader historical coverage, but not required for the first integrated validated line. |
| ADT batch archive (`ij1`-`ij4`) | Integrity-checkable | Important archive family, but outside the minimum M1 executable story. |
| Earliest DREV-era `T1`-`T6` family | Integrity-checkable | Historically meaningful, but also outside the minimum M1 executable story. |
| Alex DFA-option behavior | Diagnosed but not promoted into supported validation | This is a research-readiness lane, not a first integrated-baseline gate. |
| Hanoi-4 behavior / repeatability | Explicitly tracked, but not yet indexed as a runnable family | For `1.0`, a clear status statement is sufficient; full understanding is deferred to `2.0`. |
| Remaining minor log noise | Small leftovers only | Worth trimming, but not strong enough to block M1 once bounded and documented. |

## Explicitly Outside M1

| Family / lane | Current state | Why it is outside M1 |
|---|---|---|
| QCSP-nov96 terrain domain | Provenance-only, recovery lead exists | Missing runnable artifacts still prevent inclusion; this is the one major historical gap that remains blocked outside M1. |

## Practical M1 Reading

M1 is ready when we can say all of the following with a straight face:

1. `qcsp3/` is the operational center of the supported thesis-result story.
2. The current validation spine stays green from a fresh checkout.
3. AO support is asserted and honestly bounded rather than hand-waved.
4. `ff*` stays connected to the integrated line as a checked preserved family.
5. The remaining archive-heavy families are explicitly *post-M1* rather than
   silently missing.

That means the question is no longer "what other non-terrain archive family
must be pulled in before M1?" M1 has been accepted, and the active question is
now "what documentation and operator-facing cleanup best prepares the repo for
the next integration step?"
