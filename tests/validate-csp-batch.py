#!/usr/bin/env python3
"""Validate the preserved early MOTORS T1-T6 batch archive."""

from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
BATCH_ROOT = ROOT / "data" / "csp-batch"
SAVE_ROOT = ROOT / "data" / "csp-save-results"

EXPECTED_NOISE_100S = list(range(100, 1001, 100))
EXPECTED_T6_COUNTS = {
    "t6-1.out": {100: 10, 200: 10, 300: 10, 400: 10, 500: 10, 600: 10, 700: 10, 800: 10, 900: 10, 1000: 10},
    "t6-2.out": {100: 10, 200: 10, 300: 10, 400: 11, 500: 10, 600: 10, 700: 10, 800: 10, 900: 10, 1000: 10},
    "t6-3.out": {100: 10, 200: 10, 300: 10, 400: 10, 500: 10, 600: 10, 700: 10, 800: 10, 900: 10, 1000: 10},
    "t6-4.out": {100: 10, 200: 10, 300: 10, 400: 10, 500: 10, 600: 10, 700: 9, 800: 10, 900: 10, 1000: 10},
    "t6-5.out": {100: 10, 200: 10, 300: 10, 400: 10, 500: 10, 600: 10, 700: 10, 800: 10, 900: 10, 1000: 10},
    "t6-6.out": {100: 10, 200: 10, 300: 10, 400: 10, 500: 10, 600: 10, 700: 10, 800: 10, 900: 10, 1000: 10},
    "t6-7.out": {100: 10, 200: 10, 300: 10, 400: 10, 500: 10, 600: 10, 700: 10, 800: 10, 900: 10, 1000: 10},
    "t6-8.out": {100: 10, 200: 10, 300: 10, 400: 10, 500: 10, 600: 10, 700: 9, 800: 10, 900: 10, 1000: 10},
}
EXPECTED_SUMMARY_COUNTS = {
    "t1-summary": 160,
    "t2-summary": 100,
    "t3-summary": 100,
    "t4-summary": 0,
    "t5-summary": 0,
}


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def numeric_rows(path: Path) -> list[list[str]]:
    rows: list[list[str]] = []
    for line in path.read_text().splitlines():
        parts = line.split()
        if parts and parts[0].isdigit():
            rows.append(parts)
    return rows


def validate_required_paths() -> None:
    required = [
        BATCH_ROOT / "README.md",
        BATCH_ROOT / "Graphical" / "data.t1",
        BATCH_ROOT / "Graphical" / "data.t2",
        BATCH_ROOT / "Graphical" / "gnup.in",
        SAVE_ROOT / "README.md",
        SAVE_ROOT / "README",
        SAVE_ROOT / "makps",
    ]
    for idx in range(1, 6):
        required.append(SAVE_ROOT / f"data-{idx}")
    for idx in range(1, 9):
        required.append(SAVE_ROOT / f"t6-{idx}.out")
    for path in required:
        if not path.exists():
            fail(f"Missing required CSP batch artifact: {path}")


def validate_t_summaries() -> None:
    summary_paths = {
        "t1-summary": BATCH_ROOT / "T1" / "t1-summary",
        "t2-summary": BATCH_ROOT / "T2" / "t2-summary",
        "t3-summary": BATCH_ROOT / "T3" / "t3-summary",
        "t4-summary": BATCH_ROOT / "T4" / "t4-summary",
        "t5-summary": BATCH_ROOT / "T5" / "t5-summary",
    }
    for name, path in summary_paths.items():
        if not path.exists():
            fail(f"Missing preserved T-summary file: {path}")
        rows = numeric_rows(path)
        if len(rows) != EXPECTED_SUMMARY_COUNTS[name]:
            fail(f"{path}: expected {EXPECTED_SUMMARY_COUNTS[name]} numeric rows, got {len(rows)}")
        if name in {"t1-summary", "t2-summary", "t3-summary"}:
            sizes = sorted({int(row[0]) for row in rows})
            if sizes != EXPECTED_NOISE_100S:
                fail(f"{path}: unexpected size ladder {sizes}")


def validate_graphical_summaries() -> None:
    expected = {
        "data.t1": EXPECTED_NOISE_100S,
        "data.t2": [90, 100] + list(range(150, 1001, 50)),
    }
    for name, ladder in expected.items():
        rows = numeric_rows(BATCH_ROOT / "Graphical" / name)
        sizes = [int(row[0]) for row in rows]
        if sizes != ladder:
            fail(f"{name}: unexpected x-axis ladder {sizes}")


def validate_saved_result_summaries() -> None:
    for idx in range(1, 6):
        path = SAVE_ROOT / f"data-{idx}"
        rows = numeric_rows(path)
        sizes = [int(row[0]) for row in rows]
        if sizes != EXPECTED_NOISE_100S:
            fail(f"{path}: unexpected size ladder {sizes}")


def validate_t6_outputs() -> None:
    for name, expected_counts in EXPECTED_T6_COUNTS.items():
        path = SAVE_ROOT / name
        counts = {size: 0 for size in EXPECTED_NOISE_100S}
        for row in numeric_rows(path):
            size = int(row[0])
            if size not in counts:
                fail(f"{path}: unexpected size value {size}")
            counts[size] += 1
        if counts != expected_counts:
            fail(f"{path}: expected size counts {expected_counts}, got {counts}")


def main() -> None:
    print("== CSP batch archive validation ==")
    print("This integrity check protects the preserved T1-T6 / DREV-era archive.")
    validate_required_paths()
    validate_t_summaries()
    validate_graphical_summaries()
    validate_saved_result_summaries()
    validate_t6_outputs()
    print("CSP batch archive validation passed.")


if __name__ == "__main__":
    main()
