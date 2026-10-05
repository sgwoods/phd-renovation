"""Render the full paired campaign without selecting only successful timings."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import statistics


def compare(cells, mode, left, right, counter):
    selected = {(c["instance_id"], c["strategy"]): c for c in cells if c["mode"] == mode}
    counts = Counter()
    for key, strategy in selected:
        if strategy != left:
            continue
        a, b = selected[key, left], selected[key, right]
        if not (a["all_repetitions_solved"] and b["all_repetitions_solved"]):
            counts["unresolved"] += 1
        elif a[counter] is None or b[counter] is None:
            counts["unavailable"] += 1
        else:
            counts["less" if a[counter] < b[counter] else "equal" if a[counter] == b[counter] else "more"] += 1
    return "/".join(str(counts[k]) for k in ("less", "equal", "more", "unresolved", "unavailable"))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("summary", type=Path)
    parser.add_argument("raw", type=Path, nargs="+")
    args = parser.parse_args()
    summary = json.loads(args.summary.read_text())
    if (summary["matrix"], summary["fixtures"], summary["repetitions"]) != ("expanded", 20, 5):
        raise ValueError("This checkpoint report expects the expanded 20-case five-repeat matrix")
    records = []
    for path in args.raw:
        if summary["raw_sha256"].get(path.name) != hashlib.sha256(path.read_bytes()).hexdigest():
            raise ValueError("Raw evidence differs from validated summary")
        records.extend(json.loads(line) for line in path.read_text().splitlines())
    hashes = {json.dumps(r["source_sha256"], sort_keys=True) for r in records}
    if len(hashes) != 1:
        raise ValueError("Execution source hashes changed across this paired campaign")
    cells = summary["cells"]
    statuses = ", ".join(f"{key}={value}" for key, value in sorted(summary["statuses"].items()))
    print("# Expanded repeated campaign, 2026-10-05\n")
    print(f"{summary['records']} retained runs: {summary['fixtures']} fixtures x eight policies x two modes x {summary['repetitions']} repetitions.")
    print(f"Statuses: {statuses}. Exact all-mode parity: {summary['all_mode_exact_parity']}/800.")
    print(f"Completed cells: {sum(c['all_repetitions_solved'] for c in cells)}/{len(cells)}. Each cell contains five repetitions.\n")
    print("## Matched-engine ablation\n")
    print("Counts are **less/equal/more/unresolved/unavailable** for the left policy relative to the right, across 20 materialized fixtures. Repetitions are not independent samples.\n")
    print("| Mode | Left vs right | Nodes | Constraint tests |\n|---|---|---|---|")
    for mode in ("all", "first"):
        for left, right in (("table-degree", "table-mrv"), ("table-wdeg", "table-degree"), ("table-wdeg", "table-mrv")):
            print(f"| {mode} | {left} vs {right} | {compare(cells, mode, left, right, 'nodes')} | {compare(cells, mode, left, right, 'constraint_tests')} |")
    print("\nFrozen degree keeps every constraint weight at one; adaptive weighting changes weights after failures. Active degree changes during both searches. MRV does not use its recorded weights.\n")
    print("### Two-decoy negative\n")
    print("| Policy | Nodes | Constraint tests | Weight updates |\n|---|---:|---:|---:|")
    for c in cells:
        if c["instance_id"] == "noise-s0-n2-negative" and c["mode"] == "all" and c["strategy"].startswith("table-"):
            print(f"| {c['strategy']} | {c['nodes']} | {c['constraint_tests']} | {c['weight_updates']} |")
    print("\n## Timing scope\n")
    loads = [r[key][0] for r in records for key in ("host_load_average_start", "host_load_average_end")]
    print(f"Observed one-minute host load ranged from {min(loads):.2f} to {max(loads):.2f} on {records[0]['logical_cpus']} logical CPUs. No other project test suite ran during collection, but unrelated host activity was not controlled. **These are repeated observations under contention, not a quiet-host speedup benchmark.**\n")
    print("The 10-second outer wall limit includes process startup, imports, solving and oracle verification. Lisp has a 5-second CPU budget; CP-SAT has a 5-second solver wall budget. Costs below are medians of cell medians, not ratios or claimed speedups. Limits remain in wall measurements.\n")
    print("| Policy | All-mode wall seconds | First-mode wall seconds | Zero solve-time cells |\n|---|---:|---:|---:|")
    for strategy in dict.fromkeys(c["strategy"] for c in cells):
        selected = [c for c in cells if c["strategy"] == strategy]
        values = [statistics.median(c["median_wall_seconds_including_limits"] for c in selected if c["mode"] == mode) for mode in ("all", "first")]
        print(f"| {strategy} | {values[0]:.4f} | {values[1]:.4f} | {sum(c['median_solve_seconds'] == 0 for c in selected)} |")
    print("\nTiny Lisp solve times can hit clock resolution; cold-start and exhaustive-check cost can dominate. Backend branches are not interchangeable with legacy nodes/TCC. No timing significance test or SPARC-to-modern hardware ratio is claimed.\n")
    print("## Provenance and next gate\n")
    print("Source commits: " + ", ".join(f"`{s}`" for s in sorted({r['source_commit'] for r in records})) + ". All captured execution source hashes agree across both modes. The dirty-tree field is captured at each runner's start; later documentation/new-subdirectory work does not change those execution hashes. Fixture and original-generation sidecar hashes were validated without rewriting historical provenance.\n")
    print("Inputs span one controlled decoy family, not 20 independent program families. Do not attribute degree gains to learned failure feedback. A quiet-host campaign and larger, diverse families remain necessary for latency/generalization claims. Historical defaults and goldens are unchanged.\n")
    print("Evidence: " + ", ".join(f"[{p.name}]({p.name})" for p in [args.summary, *args.raw]) + ".")


if __name__ == "__main__":
    main()
