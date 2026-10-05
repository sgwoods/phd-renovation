"""Validate a complete paired campaign and summarize per-instance repeated costs."""
import argparse
from collections import Counter, defaultdict
import json
from pathlib import Path
import statistics
from run import digest, HERE

STRATEGIES = ("bt", "fc", "fcdr", "fcdr-as", "table-mrv", "table-wdeg", "cp-sat")


def summarize(paths, repetitions=5):
    if not 1 <= repetitions <= 100:
        raise ValueError("Repetitions must be between 1 and 100")
    records = [json.loads(line) for path in paths for line in path.read_text().splitlines()]
    fixtures = {p.stem: p for p in sorted((HERE / "fixtures/noise").glob("*.sexp"))}
    expected = {key: json.loads(path.with_suffix(".json").read_text()) for key, path in fixtures.items()}
    groups = defaultdict(list)
    for row in records:
        key = row.get("instance_id", Path(row["fixture"]).stem)
        if key not in expected:
            raise ValueError(f"Unknown fixture {key}")
        if row["fixture_sha256"] != digest(fixtures[key]):
            raise ValueError(f"Fixture hash mismatch {key}")
        if row["fixture_metadata_sha256"] != digest(fixtures[key].with_suffix(".json")):
            raise ValueError(f"Metadata hash mismatch {key}")
        # Limits remain visible, not silently removed from latency statistics.
        if row["status"] not in ("SAT", "UNSAT", "UNKNOWN", "ERROR"):
            raise ValueError("Invalid status")
        if row["status"] in ("SAT", "UNSAT"):
            target = expected[key]["expected_solutions"]
            if row["status"] == "SAT" and (not row["solutions"] or not row["witnesses_valid"]
                                            or any(s not in target for s in row["solutions"])):
                raise ValueError(f"Invalid witness: {key}")
            if row["status"] == "UNSAT" and (target or not row["complete"]):
                raise ValueError(f"Invalid UNSAT claim: {key}")
            if row["mode"] == "all":
                canonical = lambda xs: sorted(tuple(sorted(x.items())) for x in xs)
                if row["complete"] and not (row["parity"] is True and
                        canonical(row["solutions"]) == canonical(target)):
                    raise ValueError(f"Enumeration contract failed: {key}")
            elif target:
                if (row["status"] != "SAT" or not row["witnesses_valid"] or len(row["solutions"]) != 1
                        or any(s not in target for s in row["solutions"])):
                    raise ValueError(f"First witness contract failed: {key}")
            elif row["status"] != "UNSAT" or not row["complete"]:
                raise ValueError(f"UNSAT contract failed: {key}")
        groups[key, row["mode"], row["strategy"]].append(row)
    cells = []
    for key in fixtures:
        for mode in ("all", "first"):
            for strategy in STRATEGIES:
                rows = groups[key, mode, strategy]
                if sorted(row["repetition"] for row in rows) != list(range(repetitions)):
                    raise ValueError(f"Missing or duplicate repetitions: {(key, mode, strategy)}")
                solved = all(row["status"] in ("SAT", "UNSAT") and (mode == "first" or row["complete"]) for row in rows)
                cells.append({"instance_id": key, "mode": mode, "strategy": strategy,
                    "variant": expected[key]["variant"], "noise_blocks": expected[key]["noise_blocks"],
                    "seed": expected[key]["seed"], "statuses": dict(Counter(row["status"] for row in rows)),
                    "all_repetitions_solved": solved,
                    "median_wall_seconds_including_limits": statistics.median(row["wall_seconds"] for row in rows),
                    "median_solve_seconds": statistics.median(row.get("solve_seconds", row.get("solve_ticks", 0) / row.get("ticks_per_second", 1)) for row in rows) if solved else None,
                    "nodes": rows[0].get("nodes_visited") if solved else None,
                    "constraint_tests": rows[0].get("table_constraint_tests") if solved else None,
                    "weight_updates": rows[0].get("weight_updates") if solved else None,
                    "backend_branches": rows[0].get("backend_branches") if solved else None})
                for counter in ("nodes_visited", "table_constraint_tests", "weight_updates", "backend_branches"):
                    if solved and len({row.get(counter) for row in rows}) != 1:
                        raise ValueError(f"Nondeterministic counter {key} {strategy} {counter}")
    if len(records) != len(fixtures) * 2 * len(STRATEGIES) * repetitions:
        raise ValueError("Unexpected campaign rows")
    return {"records": len(records), "fixtures": len(fixtures), "repetitions": repetitions,
            "statuses": dict(Counter(row["status"] for row in records)),
            "all_mode_exact_parity": sum(row["mode"] == "all" and row.get("parity") is True for row in records),
            "raw_sha256": {path.name: digest(path) for path in paths}, "cells": cells}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="+", type=Path)
    parser.add_argument("--repetitions", type=int, default=5)
    args = parser.parse_args()
    print(json.dumps(summarize(args.paths, args.repetitions), sort_keys=True, indent=2))
