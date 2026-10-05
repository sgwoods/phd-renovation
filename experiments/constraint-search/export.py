#!/usr/bin/env python3
"""Materialize reviewed zero-noise historical cases, or check them without writes."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
CASES = ("adt-base", "adt-index", "adt-two", "mpr-base")


def exports():
    sources = [HERE / name for name in ("historical-export.lisp", "export-worker.lisp", "export.py",
                                        "model.lisp", "qcsp3-adapter.lisp")]
    sources += sorted((ROOT / "qcsp3").glob("*.lisp")) + [ROOT / "qcsp3.asd"]
    hashes = {str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest() for path in sources}
    for case in CASES:
        process = subprocess.run(["sbcl", "--script", str(HERE / "export-worker.lisp"), case],
                                 capture_output=True, text=True, timeout=30)
        if process.returncode:
            raise RuntimeError(f"{case}: {process.stderr}")
        record = json.loads(process.stdout)
        instance = record.pop("instance_sexp") + "\n"
        record["exporter_version"] = 1
        record["source_sha256"] = hashes
        record["instance_sha256"] = hashlib.sha256(instance.encode()).hexdigest()
        yield case, instance, json.dumps(record, indent=2, sort_keys=True) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true", help="Write generated fixtures and provenance; default checks")
    args = parser.parse_args()
    output = HERE / "fixtures" / "historical"
    for case, instance, provenance in exports():
        for suffix, content in ((".sexp", instance), (".json", provenance)):
            path = output / (case + suffix)
            if args.write:
                output.mkdir(parents=True, exist_ok=True)
                path.write_text(content)
            elif not path.exists() or path.read_text() != content:
                raise SystemExit(f"Historical export drift: {path}. Review before using --write.")
        print(f"{case}: original predicates, legacy search, model and oracle agree")


if __name__ == "__main__":
    main()
