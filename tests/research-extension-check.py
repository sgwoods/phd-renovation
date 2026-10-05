"""Behavioral checks launched by the FiveAM research suite."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent.parent
BENCH = ROOT / "experiments/constraint-search"


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def rejected(function, *args):
    try:
        function(*args)
    except ValueError:
        return
    raise AssertionError("Invalid input accepted")


leap = module("leap_year", BENCH / "demos/leap_year.py")
report = leap.build_report()
assert len(report["cases"]) == 8
assert all(c["semantically_gregorian"] == c["expected_correct"] for c in report["cases"])
cases = {c["id"]: c for c in report["cases"]}
assert cases["renamed_reordered"]["structural_plans"] == ["gregorian-plan"]
assert not cases["factored_equivalent"]["structural_plans"]
assert cases["factored_equivalent"]["semantically_gregorian"]
assert cases["leap_year_trust_me"]["counterexamples"] == [2100, 2200, 2300]
assert cases["century_exception_only"]["counterexamples"] == [2000]
assert cases["leap_year_trust_me"]["scripted_reference_proposal"]["proposal_is_gregorian"]
assert not cases["leap_year_trust_me"]["scripted_reference_proposal"]["translation_equivalent"]
for bad in ([], ["div", 5], ["div", True], ["div", 400.0], ["eval", "x"], ["and", ["div", 4]], [["bad"]]):
    rejected(leap.signature, bad)
deep = ["div", 4]
for _ in range(14):
    deep = ["not", deep]
rejected(leap.signature, deep)
for c in report["cases"]:
    for year in range(-400, 401):
        assert leap.evaluate(c["expression"], year) == leap.evaluate(c["expression"], year + 400)
assert [leap.gregorian(y) for y in (1900, 2000, 2100, 2400)] == [False, True, False, True]

memory = module("memory_audit", BENCH / "memory/run.py")
run = subprocess.run([sys.executable, str(BENCH / "memory/run.py")], text=True, capture_output=True, timeout=900)
if run.returncode:
    raise AssertionError(run.stdout[-12000:] + run.stderr)
rows = [json.loads(line) for line in run.stdout.splitlines()]
assert len(rows) == 22 and all(r["status"] == "PASS" for r in rows)
assert all("experiments/constraint-search/run.py" in r["source_sha256"] and r["sbcl_version"] for r in rows)
assert [len(r["index_solutions"]) for r in rows[:2]] == [1, 3]
assert [len(r["union"]) for r in rows[:2]] == [1, 2]
assert all(r["original_memory_search_parity"] is True for r in rows[:2])
assert all(r["original_memory_search_parity"] is None for r in rows[2:])
assert any(r["index_solutions"] and not r["union"] for r in rows)
for row in rows:
    memory.validate(row, row["direct_solutions"])
    if row["union"]:
        bad = copy.deepcopy(row)
        bad["union"].append(bad["union"][0])
        rejected(memory.validate, bad, row["direct_solutions"])
        bad = copy.deepcopy(row)
        bad["groups"] = []
        rejected(memory.validate, bad, row["direct_solutions"])
        bad = copy.deepcopy(row)
        completed = next(g for g in bad["groups"] if g["completions"])
        completed["completions"] = []
        rejected(memory.validate, bad, row["direct_solutions"])
print("Research extension contract passed: 22 memory cases, 8 DSL programs, mutation and periodicity checks")
