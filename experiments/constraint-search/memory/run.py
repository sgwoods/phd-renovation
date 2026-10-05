"""Audit two-stage matching against direct full matches in fresh Lisp processes."""
import json
from pathlib import Path
import platform
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
BENCH = HERE.parent
ROOT = BENCH.parent.parent
sys.path.insert(0, str(BENCH))
from run import bounded_run, digest, git


def canonical(solutions):
    return sorted(tuple(sorted(s.items())) for s in solutions)


def validate(row, expected):
    full, index, groups = row["direct_solutions"], row["index_solutions"], row["groups"]
    if canonical(full) != canonical(expected):
        raise ValueError("Direct expected-set mismatch")
    if canonical(index) != canonical([g["index"] for g in groups]):
        raise ValueError("Missing or duplicate index group")
    if len(canonical(index)) != len(set(canonical(index))):
        raise ValueError("Duplicate index candidate")
    extends = lambda s, p: all(s.get(k) == v for k, v in p.items())
    if any(not any(extends(s, p) for p in index) for s in full):
        raise ValueError("Index recall loss")
    for group in groups:
        target = [s for s in full if extends(s, group["index"])]
        if canonical(group["completions"]) != canonical(target):
            raise ValueError("Per-index completion mismatch")
    union = [s for g in groups for s in g["completions"]]
    if canonical(union) != canonical(full) or canonical(row["union"]) != canonical(full):
        raise ValueError("Union mismatch or duplicates")


def main():
    sources = [BENCH / "run.py", *sorted(BENCH.glob("*.lisp")), *sorted(HERE.glob("*.py")), *sorted(HERE.glob("*.lisp")),
               ROOT / "qcsp3.asd", *sorted((ROOT / "qcsp3").glob("*.lisp"))]
    provenance = {"source_commit": git("rev-parse", "HEAD"), "working_tree_dirty": bool(git("status", "--porcelain")),
                  "python_version": platform.python_version(), "platform": platform.platform(),
                  "sbcl_version": subprocess.check_output(["sbcl", "--version"], text=True).strip(),
                  "source_sha256": {str(p.relative_to(ROOT)): digest(p) for p in sources}}
    cases = [("adt-base", None), ("adt-two", None)]
    cases += [("adt-base", p) for p in sorted((BENCH / "fixtures/noise").glob("*.json"))]
    failed = False
    for case, metadata in cases:
        row = {**provenance, "id": metadata.stem if metadata else case, "wall_budget_seconds": 60}
        try:
            with tempfile.TemporaryDirectory(prefix="memory-audit-") as directory:
                command = ["sbcl", "--script", str(HERE / "worker.lisp"), case]
                if metadata:
                    details = json.loads(metadata.read_text())
                    prepared = Path(directory) / "prepared.sexp"
                    prepared.write_text(details["prepared_situation"])
                    command.append(str(prepared))
                    expected = details["expected_solutions"]
                    row["fixture_metadata_sha256"] = digest(metadata)
                else:
                    fixture = BENCH / "fixtures/historical" / f"{case}.sexp"
                    oracle = bounded_run(["sbcl", "--script", str(BENCH / "worker.lisp"), str(fixture), "table-mrv", "all", "5"], 60)
                    oracle.check_returncode()
                    expected = json.loads(oracle.stdout)["solutions"]
                    row["fixture_sha256"] = digest(fixture)
                result = bounded_run(command, 60)
                if result.returncode:
                    raise ValueError(result.stderr[-4000:])
                row.update(json.loads(result.stdout))
                validate(row, expected)
                row["status"] = "PASS"
        except (OSError, ValueError, subprocess.SubprocessError) as error:
            failed = True
            row.update(status="ERROR", reason=str(error))
        print(json.dumps(row, sort_keys=True), flush=True)
    return int(failed)


if __name__ == "__main__":
    sys.exit(main())
