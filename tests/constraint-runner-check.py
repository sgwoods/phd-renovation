"""Subprocess contract assertions invoked by the FiveAM benchmark suite."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent.parent
RUNNER = ROOT / "experiments/constraint-search/run.py"
FIXTURE = ROOT / "experiments/constraint-search/fixtures/ordered.sexp"


def run(*args):
    process = subprocess.run([sys.executable, str(RUNNER), "--strategy", "bt", *map(str, args)],
                             text=True, capture_output=True, check=False, timeout=30)
    return process.returncode, [json.loads(line) for line in process.stdout.splitlines()]


code, rows = run(FIXTURE)
assert code == 0 and len(rows) == 1
row = rows[0]
assert row["status"] == "SAT" and row["parity"] is True and row["complete"] is True
assert row["solutions"] == [{"source": "a", "target": "b"}]
assert row["fixture_sha256"] == hashlib.sha256(FIXTURE.read_bytes()).hexdigest()
assert row["source_sha256"] and row["workers"] == 1

code, rows = run("--wall-seconds", "0.000001", FIXTURE)
assert code == 0 and rows[0]["status"] == "UNKNOWN"
assert rows[0]["termination"] == "wall-limit" and rows[0]["complete"] is False
code, rows = run("--cpu-seconds", "0", FIXTURE)
assert code == 0 and rows[0]["status"] == "UNKNOWN" and rows[0]["parity"] is None
code, rows = run("--mode", "first", FIXTURE)
assert code == 0 and rows[0]["status"] == "SAT" and rows[0]["complete"] is False
code, rows = run("--repetitions", "2", FIXTURE)
assert code == 0 and [row["repetition"] for row in rows] == [0, 1]
code, rows = run("--repetitions", "0", FIXTURE)
assert code != 0 and rows == []
code, rows = run("--strategy", "all", "--repetitions", "2", FIXTURE)
assert code == 0 and [row["strategy"] for row in rows] == ["bt", "fc", "fcdr", "fcdr-as", "fc", "fcdr", "fcdr-as", "bt"]

with tempfile.TemporaryDirectory() as directory:
    invalid = Path(directory) / "invalid.sexp"
    # If dispatch evaluation ever becomes enabled, this raises an ordinary error
    # instead of the schema rejection. It never writes or executes external code.
    invalid.write_text('#.(error "reader-evaluation-occurred")')
    code, rows = run(invalid)
    assert code == 1 and rows[0]["status"] == "ERROR"
    assert "dispatch is forbidden" in rows[0]["reason"]
    invalid.write_text(FIXTURE.read_text() + "\n(:extra 1)")
    code, rows = run(invalid)
    assert code == 1 and "Trailing instance data" in rows[0]["reason"]
    code, rows = run(Path(directory) / "absent.sexp")
    assert code == 1 and rows[0]["status"] == "ERROR"
    invalid.write_text('(:schema-version 1 :id "empty" :provenance "new-synthetic" '
                       ':variables nil :constraints nil)')
    code, rows = run(invalid)
    assert code == 0 and rows[0]["status"] == "SAT" and rows[0]["solutions"] == [{}]
    assert rows[0]["parity"] is True

# Saved smoke data also exercises the campaign validator, including incomplete
# results. Fixture paths in old records are labels; validation uses repo fixtures.
HERE = ROOT / "experiments/constraint-search"
sys.path.insert(0, str(HERE))
spec = importlib.util.spec_from_file_location("noise_summary", HERE / "summarize-noise.py")
summary_module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(summary_module)
paths = [HERE / "results" / f"2026-10-04-noise-{mode}.jsonl" for mode in ("all", "first")]
summary = summary_module.summarize(paths, repetitions=1)
assert summary["records"] == 280 and summary["all_mode_exact_parity"] == 140
records = [json.loads(line) for path in paths for line in path.read_text().splitlines()]
with tempfile.TemporaryDirectory() as directory:
    target = Path(directory) / "campaign.jsonl"

    def summarize_rows(rows):
        target.write_text("".join(json.dumps(row) + "\n" for row in rows))
        return summary_module.summarize([target], repetitions=1)

    for bad in (records[:-1], records + [records[0]]):
        try:
            summarize_rows(bad)
        except ValueError:
            pass
        else:
            raise AssertionError("Accepted missing or duplicate campaign rows")
    index = next(i for i, row in enumerate(records) if row["mode"] == "all" and row["status"] == "SAT")
    partial = [dict(row) for row in records]
    partial[index].update(complete=False, parity=None)
    result = summarize_rows(partial)
    assert sum(not cell["all_repetitions_solved"] for cell in result["cells"]) == 1
    partial[index].update(status="UNKNOWN", solutions=[], witnesses_valid=None)
    assert summarize_rows(partial)["statuses"]["UNKNOWN"] == 1
    partial[index].update(status="SAT", solutions=[{"wrong": "mapping"}], witnesses_valid=True)
    try:
        summarize_rows(partial)
    except ValueError:
        pass
    else:
        raise AssertionError("Accepted invalid witness")

print("runner contract passed")
