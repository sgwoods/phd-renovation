# Expanded repeated campaign, 2026-10-05

1600 retained runs: 20 fixtures x eight policies x two modes x 5 repetitions.
Statuses: SAT=1360, UNSAT=240. Exact all-mode parity: 800/800.
Completed cells: 320/320. Each cell contains five repetitions.

## Matched-engine ablation

Counts are **less/equal/more/unresolved/unavailable** for the left policy relative to the right, across 20 materialized fixtures. Repetitions are not independent samples.

| Mode | Left vs right | Nodes | Constraint tests |
|---|---|---|---|
| all | table-degree vs table-mrv | 12/5/3/0/0 | 20/0/0/0/0 |
| all | table-wdeg vs table-degree | 0/20/0/0/0 | 0/20/0/0/0 |
| all | table-wdeg vs table-mrv | 12/5/3/0/0 | 20/0/0/0/0 |
| first | table-degree vs table-mrv | 4/10/6/0/0 | 14/0/6/0/0 |
| first | table-wdeg vs table-degree | 0/20/0/0/0 | 0/20/0/0/0 |
| first | table-wdeg vs table-mrv | 4/10/6/0/0 | 14/0/6/0/0 |

Frozen degree keeps every constraint weight at one; adaptive weighting changes weights after failures. Active degree changes during both searches. MRV does not use its recorded weights.

### Two-decoy negative

| Policy | Nodes | Constraint tests | Weight updates |
|---|---:|---:|---:|
| table-mrv | 15 | 1686 | 3 |
| table-degree | 9 | 1236 | 0 |
| table-wdeg | 9 | 1236 | 3 |

## Timing scope

Observed one-minute host load ranged from 7.96 to 33.07 on 8 logical CPUs. No other project test suite ran during collection, but unrelated host activity was not controlled. **These are repeated observations under contention, not a quiet-host speedup benchmark.**

The 10-second outer wall limit includes process startup, imports, solving and oracle verification. Lisp has a 5-second CPU budget; CP-SAT has a 5-second solver wall budget. Costs below are medians of cell medians, not ratios or claimed speedups. Limits remain in wall measurements.

| Policy | All-mode wall seconds | First-mode wall seconds | Zero solve-time cells |
|---|---:|---:|---:|
| bt | 0.3164 | 0.3013 | 0 |
| fc | 0.3185 | 0.3154 | 0 |
| fcdr | 0.3116 | 0.3139 | 0 |
| fcdr-as | 0.3132 | 0.3049 | 0 |
| table-mrv | 0.3157 | 0.3043 | 0 |
| table-degree | 0.3214 | 0.3276 | 0 |
| table-wdeg | 0.3266 | 0.3248 | 0 |
| cp-sat | 1.5877 | 1.6822 | 0 |

Tiny Lisp solve times can hit clock resolution; cold-start and exhaustive-check cost can dominate. Backend branches are not interchangeable with legacy nodes/TCC. No timing significance test or SPARC-to-modern hardware ratio is claimed.

## Provenance and next gate

Source commits: `31797185f090dd8f797e0e6fefaad7a591d1e569`. All captured execution source hashes agree across both modes. The dirty-tree field is captured at each runner's start; later documentation/new-subdirectory work does not change those execution hashes. Fixture and original-generation sidecar hashes were validated without rewriting historical provenance.

Inputs span one controlled decoy family, not 20 independent program families. Do not attribute degree gains to learned failure feedback. A quiet-host campaign and larger, diverse families remain necessary for latency/generalization claims. Historical defaults and goldens are unchanged.

Evidence: [2026-10-05-expanded-summary.json](2026-10-05-expanded-summary.json), [2026-10-05-expanded-all.jsonl](2026-10-05-expanded-all.jsonl), [2026-10-05-expanded-first.jsonl](2026-10-05-expanded-first.jsonl).
