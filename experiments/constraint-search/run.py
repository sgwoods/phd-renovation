#!/usr/bin/env python3
"""Run isolated, bounded constraint-solver comparisons; emit JSONL to stdout."""

import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import signal
import subprocess
import sys
import time


HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def git(*args):
    return subprocess.check_output(["git", "-C", str(ROOT), *args], text=True).strip()


def bounded_run(command, seconds):
    # A CP worker launches a Lisp bridge. Kill the whole owned process group on
    # timeout so a timed-out record cannot leave background experiment work.
    with subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                          text=True, start_new_session=True) as process:
        try:
            out, err = process.communicate(timeout=seconds)
        except subprocess.TimeoutExpired:
            try:
                os.killpg(process.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            process.communicate()
            raise
        return subprocess.CompletedProcess(command, process.returncode, out, err)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("fixtures", nargs="*", type=Path)
    parser.add_argument("--strategy", choices=["bt", "fc", "fcdr", "fcdr-as", "table-mrv", "table-degree", "table-wdeg", "cp-sat", "all", "comparison", "expanded", "ablation"], default="all",
                        help="all = four legacy; comparison = original seven; expanded = eight; ablation = three table-FC policies")
    parser.add_argument("--cp-python", default=sys.executable, help="Python containing optional OR-Tools")
    parser.add_argument("--mode", choices=["all", "first"], default="all")
    parser.add_argument("--wall-seconds", type=float, default=10)
    parser.add_argument("--cpu-seconds", type=int, default=5)
    parser.add_argument("--repetitions", type=int, default=1, help="Rotate strategy order between fresh-process repetitions")
    args = parser.parse_args()
    if not math.isfinite(args.wall_seconds) or args.wall_seconds <= 0 or args.cpu_seconds < 0:
        parser.error("wall-seconds must be finite and positive; cpu-seconds must be nonnegative")
    if not 1 <= args.repetitions <= 100:
        parser.error("repetitions must be between 1 and 100")
    fixtures = args.fixtures or sorted((HERE / "fixtures").glob("*.sexp"))
    strategies = ["bt", "fc", "fcdr", "fcdr-as"] if args.strategy == "all" else [args.strategy]
    if args.strategy == "comparison":
        strategies = ["bt", "fc", "fcdr", "fcdr-as", "table-mrv", "table-wdeg", "cp-sat"]
    elif args.strategy == "expanded":
        strategies = ["bt", "fc", "fcdr", "fcdr-as", "table-mrv", "table-degree", "table-wdeg", "cp-sat"]
    elif args.strategy == "ablation":
        strategies = ["table-mrv", "table-degree", "table-wdeg"]
    sources = [*sorted(HERE.glob("*.lisp")), *sorted(HERE.glob("*.py")), *sorted(HERE.glob("requirements*.txt")), ROOT / "qcsp3.asd",
               *sorted((ROOT / "qcsp3").glob("*.lisp"))]
    provenance = {
        "source_commit": git("rev-parse", "HEAD"),
        "working_tree_dirty": bool(git("status", "--porcelain")),
        "source_sha256": {str(p.relative_to(ROOT)): digest(p) for p in sources},
        "platform": platform.platform(), "machine": platform.machine(),
        "python_version": platform.python_version(), "logical_cpus": os.cpu_count(),
        "workers": 1, "mode": args.mode, "wall_budget_seconds": args.wall_seconds,
        "seed": None, "generator": "materialized-fixture-v1",
    }
    failed = False
    for repetition in range(args.repetitions):
        order = strategies[repetition % len(strategies):] + strategies[:repetition % len(strategies)]
        for fixture, strategy in ((fixture, strategy) for fixture in fixtures for strategy in order):
            started = time.monotonic()
            legacy = strategy in ("bt", "fc", "fcdr", "fcdr-as")
            configuration = {
                          "forward_checking": strategy != "bt",
                          "dynamic_rearrangement": strategy in ("fcdr", "fcdr-as"),
                          "advance_sort": strategy == "fcdr-as", "backjump": False,
                          "arc_consistency": False,
                      } if legacy else {"policy": strategy, "backjump": False, "arc_consistency": False}
            if strategy == "cp-sat":
                configuration = {"solver_defaults": True, "random_seed": 0, "num_search_workers": 1,
                                 "enumerate_all_solutions": args.mode == "all"}
            record = {**provenance, "schema_version": 1, "fixture": str(fixture.resolve()),
                      "strategy": strategy, "configuration": configuration,
                      "engine": "qcsp3" if legacy else "cp-sat" if strategy == "cp-sat" else "table-fc",
                      "oracle_assignment_budget": 100000, "repetition": repetition,
                      "strategy_order_index": order.index(strategy)}
            record["host_load_average_start"] = os.getloadavg()
            record["solver_time_budget_seconds" if strategy == "cp-sat" else "cpu_budget_seconds"] = args.cpu_seconds
            try:
                record["fixture_sha256"] = digest(fixture)
                metadata = fixture.with_suffix(".json")
                if metadata.exists():
                    record["fixture_metadata_sha256"] = digest(metadata)
                    details = json.loads(metadata.read_text())
                    record["fixture_metadata"] = {key: details[key] for key in
                        ("generator", "seed", "noise_blocks", "variant", "expected_solution_count") if key in details}
                command = ["sbcl", "--script", str(HERE / "worker.lisp"), str(fixture.resolve()),
                           strategy, args.mode, str(args.cpu_seconds)]
                if strategy == "cp-sat":
                    command = [args.cp_python, str(HERE / "cp_sat_worker.py"), str(fixture.resolve()),
                               args.mode, str(args.cpu_seconds)]
                process = bounded_run(command, args.wall_seconds)
                result = json.loads(process.stdout)
                if not isinstance(result, dict):
                    raise ValueError("Worker returned a non-object result")
                record.update(result)
                record["exit_code"] = process.returncode
                record["stderr"] = process.stderr
                if process.returncode != 0:
                    record["status"] = "ERROR"
                    record.update(complete=False, parity=None)
                if digest(fixture) != record["fixture_sha256"]:
                    raise ValueError("Fixture changed while the worker was running")
                if metadata.exists() and digest(metadata) != record.get("fixture_metadata_sha256"):
                    raise ValueError("Fixture metadata changed while the worker was running")
                failed |= record["status"] == "ERROR"
            except subprocess.TimeoutExpired:
                record.update(status="UNKNOWN", termination="wall-limit", complete=False,
                              parity=None, witnesses_valid=None)
            except (OSError, ValueError) as error:
                failed = True
                record.update(status="ERROR", reason=str(error), complete=False, parity=None)
            record["wall_seconds"] = time.monotonic() - started
            record["host_load_average_end"] = os.getloadavg()
            print(json.dumps(record, sort_keys=True), flush=True)
    return int(failed)


if __name__ == "__main__":
    sys.exit(main())
