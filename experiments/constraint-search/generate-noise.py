"""Materialize or check bounded ADT near-plan cases with pinned semantic outcomes."""
import argparse
import json
from pathlib import Path
import subprocess
from run import digest, HERE, ROOT


CASES = [(seed, level, "positive") for seed in range(5) for level in range(3)]
CASES += [(0, level, "negative") for level in range(3)]
CASES += [(0, 2, "ambiguous"), (0, 2, "renamed")]


def replay_metadata_matches(stored, current):
    # These hashes describe the original generation, not today's replay. Keep the
    # archived sidecars unchanged; compare every semantic/provenance field otherwise.
    return ({k: v for k, v in stored.items() if k != "source_sha256"} ==
            {k: v for k, v in current.items() if k != "source_sha256"})


def generate(cases=CASES):
    sources = [HERE / name for name in ("generate-noise.py", "noise-worker.lisp", "historical-export.lisp",
                                        "model.lisp", "qcsp3-adapter.lisp", "run.py")]
    sources += sorted((ROOT / "qcsp3").glob("*.lisp")) + [ROOT / "qcsp3.asd"]
    hashes = {str(path.relative_to(ROOT)): digest(path) for path in sources}
    for seed, level, variant in cases:
        process = subprocess.run(["sbcl", "--script", str(HERE / "noise-worker.lisp"), str(seed), str(level), variant],
                                 capture_output=True, text=True, timeout=120)
        if process.returncode:
            raise RuntimeError(process.stderr)
        record = json.loads(process.stdout)
        instance = record.pop("instance_sexp") + "\n"
        unit = record.pop("ticks_per_second")
        timings = {key + "_seconds": record.pop(key + "_ticks") / unit for key in ("export", "audit")}
        record["source_sha256"] = hashes
        yield record, instance, timings


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()
    directory = HERE / "fixtures/noise"
    for record, instance, timings in generate():
        import hashlib
        record["instance_sha256"] = hashlib.sha256(instance.encode()).hexdigest()
        for suffix, content in ((".sexp", instance), (".json", json.dumps(record, sort_keys=True, indent=2) + "\n")):
            path = directory / (record["id"] + suffix)
            if args.write:
                directory.mkdir(parents=True, exist_ok=True)
                path.write_text(content)
            elif not path.exists():
                raise SystemExit(f"Missing noise fixture: {path}")
            elif suffix == ".json":
                if not replay_metadata_matches(json.loads(path.read_text()), record):
                    raise SystemExit(f"Noise metadata drift: {path}; inspect before --write")
            elif path.read_text() != content:
                raise SystemExit(f"Noise model drift: {path}; inspect before --write")
        print(json.dumps({"id": record["id"], "expected": record["expected_solution_count"],
                          "assignments_audited": record["assignments_audited"], **timings}), flush=True)


if __name__ == "__main__":
    main()
