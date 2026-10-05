"""Optional backend assertions invoked by the FiveAM suite, with a Lisp oracle."""
import json
from pathlib import Path
import random
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent.parent
HERE = ROOT / "experiments/constraint-search"
sys.path.insert(0, str(HERE))
from cp_sat_worker import solve, valid_assignment


def bridge(path):
    result = subprocess.run(["sbcl", "--script", str(HERE / "dump-model.lisp"), str(path)],
                            text=True, capture_output=True, timeout=30, check=True)
    return json.loads(result.stdout)


def sexp(value):
    if isinstance(value, str):
        return '"' + value.replace('\\', '\\\\').replace('"', '\\"') + '"'
    return "(" + " ".join(sexp(item) for item in value) + ")"


fixtures = sorted((HERE / "fixtures").glob("*.sexp")) + sorted((HERE / "fixtures/historical").glob("*.sexp"))
fixtures += sorted((HERE / "fixtures/noise").glob("*.sexp"))
for fixture in fixtures:
    model = bridge(fixture)
    result = solve(model, "all", 5)
    assert result["complete"] and result["parity"] is True, fixture

with tempfile.TemporaryDirectory() as directory:
    fixture = Path(directory) / "generated.sexp"
    for seed in range(100):
        rng = random.Random(seed)
        variables = [[f"x{i}", rng.sample(["a", "b", "c"], rng.randrange(4))] for i in range(3)]
        tuples = [[a, b, c] for a in variables[0][1] for b in variables[1][1]
                  for c in variables[2][1] if rng.randrange(2)]
        fixture.write_text('(:schema-version 1 :id "cp-generated" :provenance "new-synthetic" '
                           f':variables {sexp(variables)} :constraints '
                           f'((:id "ternary" :kind :table :scope ("x0" "x1" "x2") :tuples {sexp(tuples)}) '
                           '(:id "injective" :kind :all-different :scope ("x0" "x2"))))')
        result = solve(bridge(fixture), "all", 5)
        assert result["complete"] and result["parity"] is True, seed
    fixture.write_text('(:schema-version 1 :id "empty" :provenance "new-synthetic" :variables nil :constraints nil)')
    assert solve(bridge(fixture), "all", 5)["solutions"] == [{}]

model = bridge(HERE / "fixtures/ambiguous.sexp")
assert not valid_assignment(model, {"left": "a", "right": "a"})
assert not valid_assignment(model, {"left": "a"})
first = solve(model, "first", 5)
assert first["status"] == "SAT" and not first["complete"] and first["parity"] is None
limited = solve(model, "all", 0)
assert limited["status"] == "UNKNOWN" and not limited["complete"]
# This is a correctness smoke test, not a cold-start latency assertion. Keep the
# benchmark's default budget unchanged; allow loaded CI hosts time to import.
process = subprocess.run([sys.executable, str(HERE / "run.py"), "--strategy", "cp-sat", "--wall-seconds", "60",
                          str(HERE / "fixtures/ordered.sexp")], capture_output=True, text=True, timeout=90)
assert process.returncode == 0 and json.loads(process.stdout)["parity"] is True, process.stdout + process.stderr
print(f"CP-SAT contract passed: {len(fixtures)} fixtures, 100 ternary models, limits and witness checks")
