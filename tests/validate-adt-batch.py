#!/usr/bin/env python3
"""Validate the preserved CSP ADT batch archive structure.

This is an integrity check, not a modern rerun path. It proves that the
preserved `data/csp-adt-batch/` family still contains the expected per-run file
grid and the matching historical CI summary tables.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ADT_ROOT = ROOT / "data" / "csp-adt-batch"
GRAPH_ROOT = ADT_ROOT / "Graphical"

EXPECTED_RAW_NOISE = list(range(50, 1001, 50))
EXPECTED_PLOT_NOISE = {
    "ij1": {
        "cc": list(range(50, 501, 50)),
        "sec": list(range(50, 451, 50)),
    },
    "ij2": {
        "cc": list(range(50, 1001, 50)),
        "sec": list(range(50, 1001, 50)),
    },
    "ij3": {
        "cc": list(range(50, 951, 50)),
        "sec": list(range(50, 951, 50)),
    },
    "ij4": {
        "cc": list(range(50, 1001, 50)),
        "sec": list(range(50, 1001, 50)),
    },
}

RAW_PATTERN = re.compile(r"^(ij[1-4])-(\d{3,4})\.(\d+)$")


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def parse_ci_rows(path: Path) -> list[tuple[int, float, float, float]]:
    rows: list[tuple[int, float, float, float]] = []
    for lineno, line in enumerate(path.read_text().splitlines(), start=1):
        parts = line.split()
        if not parts:
            continue
        if len(parts) != 4:
            fail(f"{path}: expected 4 columns on line {lineno}, got {len(parts)}")
        try:
            noise = int(parts[0])
            mean = float(parts[1])
            lower = float(parts[2])
            upper = float(parts[3])
        except ValueError as exc:
            fail(f"{path}: could not parse numeric row on line {lineno}: {exc}")
        if not (lower <= mean <= upper):
            fail(f"{path}: CI row {lineno} has mean outside bounds")
        rows.append((noise, mean, lower, upper))
    if not rows:
        fail(f"{path}: no CI rows found")
    return rows


def validate_raw_family(family: str) -> None:
    family_dir = ADT_ROOT / family
    if not family_dir.is_dir():
        fail(f"Missing ADT family directory: {family_dir}")

    seed_map: dict[int, set[int]] = {}
    for path in family_dir.iterdir():
        if not path.is_file():
            continue
        match = RAW_PATTERN.match(path.name)
        if not match:
            continue
        _, noise_text, seed_text = match.groups()
        noise = int(noise_text)
        seed = int(seed_text)
        seed_map.setdefault(noise, set()).add(seed)

    raw_noises = sorted(seed_map)
    if raw_noises != EXPECTED_RAW_NOISE:
        fail(f"{family}: unexpected raw noise ladder {raw_noises}")

    expected_seeds = set(range(1, 11))
    for noise in EXPECTED_RAW_NOISE:
        seeds = seed_map.get(noise, set())
        if seeds != expected_seeds:
            fail(f"{family}: noise {noise} has seeds {sorted(seeds)}, expected 1..10")


def validate_plot_family(family: str) -> None:
    for suffix in ("cc", "sec"):
        expected_noises = EXPECTED_PLOT_NOISE[family][suffix]
        path = GRAPH_ROOT / f"{family}-plot-{suffix}.ci"
        if not path.is_file():
            fail(f"Missing preserved ADT CI summary: {path}")
        rows = parse_ci_rows(path)
        noises = [row[0] for row in rows]
        if noises != expected_noises:
            fail(f"{path}: unexpected x-axis ladder {noises}")


def main() -> None:
    print("== ADT batch archive validation ==")
    print("This integrity check protects the preserved ij1-ij4 ADT batch archive.")

    required_top_level = [
        ADT_ROOT / "README.md",
        ADT_ROOT / "ij1-bt.sh",
        ADT_ROOT / "ij234.sh",
        ADT_ROOT / "summary-ij1",
    ]
    for path in required_top_level:
        if not path.exists():
            fail(f"Missing required ADT batch artifact: {path}")

    for family in ("ij1", "ij2", "ij3", "ij4"):
        validate_raw_family(family)
        validate_plot_family(family)

    print("ADT batch archive validation passed.")


if __name__ == "__main__":
    main()
