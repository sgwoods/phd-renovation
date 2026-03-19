#!/usr/bin/env python3
"""Validate that regenerated SBCL CI tables preserve the published ACL result story.

This checker intentionally validates stable historical trends rather than
claiming point-for-point platform identity. It uses the thesis-era ACL CI
tables in `data/acl-experiments/Graph/` as the directly comparable baseline
for the currently supported ij2/ij3/ij4 experiment families.
"""

from __future__ import annotations

from math import sqrt
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ACL_DIR = ROOT / "data" / "acl-experiments" / "Graph"
SBCL_DIR = ROOT / "Q-Batch-SBCL" / "Graph"

SERIES_CONFIG = {
    "ij2": {
        "label": "Memory-CSP baseline",
        "min_shared_rows": 15,
        "min_ratio": 0.70,
        "max_ratio": 1.25,
        "min_ci_overlap": 15,
        "min_correlation": 0.99,
    },
    "ij3": {
        "label": "Memory-CSP FC/DR/advance-sort",
        "min_shared_rows": 20,
        "min_ratio": 0.45,
        "max_ratio": 0.95,
        "min_ci_overlap": 12,
        "min_correlation": 0.95,
    },
    "ij4": {
        "label": "Direct ADT FC/DR/advance-sort",
        "min_shared_rows": 16,
        "min_ratio": 0.40,
        "max_ratio": 0.80,
        "min_ci_overlap": 8,
        "min_correlation": 0.98,
    },
}


def read_ci_table(path: Path) -> dict[int, tuple[float, float, float]]:
    table = {}
    for line in path.read_text().splitlines():
        parts = line.split()
        if len(parts) >= 4:
            table[int(parts[0])] = tuple(map(float, parts[1:4]))
    return table


def pearson(xs: list[float], ys: list[float]) -> float:
    mean_x = sum(xs) / len(xs)
    mean_y = sum(ys) / len(ys)
    numer = sum((x - mean_x) * (y - mean_y) for x, y in zip(xs, ys))
    denom_x = sum((x - mean_x) ** 2 for x in xs)
    denom_y = sum((y - mean_y) ** 2 for y in ys)
    return numer / sqrt(denom_x * denom_y)


def ensure(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(message)


def validate_series(name: str) -> dict[int, float]:
    config = SERIES_CONFIG[name]
    acl = read_ci_table(ACL_DIR / f"{name}-ci.dat")
    sbcl = read_ci_table(SBCL_DIR / f"{name}-ci.dat")
    shared = sorted(set(acl) & set(sbcl))

    ensure(
        len(shared) >= config["min_shared_rows"],
        f"{name}: expected at least {config['min_shared_rows']} shared rows, got {len(shared)}",
    )

    acl_means = [acl[n][0] for n in shared]
    sbcl_means = [sbcl[n][0] for n in shared]
    ratios = [sbcl[n][0] / acl[n][0] for n in shared]
    ci_overlap = sum(
        1
        for n in shared
        if max(acl[n][1], sbcl[n][1]) <= min(acl[n][2], sbcl[n][2])
    )
    corr = pearson(acl_means, sbcl_means)

    ensure(
        min(ratios) >= config["min_ratio"],
        f"{name}: minimum SBCL/ACL mean ratio {min(ratios):.3f} is below {config['min_ratio']:.2f}",
    )
    ensure(
        max(ratios) <= config["max_ratio"],
        f"{name}: maximum SBCL/ACL mean ratio {max(ratios):.3f} exceeds {config['max_ratio']:.2f}",
    )
    ensure(
        ci_overlap >= config["min_ci_overlap"],
        f"{name}: CI overlap count {ci_overlap} is below {config['min_ci_overlap']}",
    )
    ensure(
        corr >= config["min_correlation"],
        f"{name}: correlation {corr:.4f} is below {config['min_correlation']:.2f}",
    )

    print(
        f"{name}: {config['label']}; shared={len(shared)} "
        f"ratio=[{min(ratios):.3f}, {max(ratios):.3f}] "
        f"corr={corr:.4f} overlap={ci_overlap}"
    )

    return {n: sbcl[n][0] for n in shared}


def validate_cross_series_ordering(series_means: dict[str, dict[int, float]]) -> None:
    shared_all = sorted(set.intersection(*(set(values) for values in series_means.values())))
    ensure(shared_all, "No shared noise levels across ij2/ij3/ij4 SBCL series")

    bad = []
    for noise in shared_all:
        ij2 = series_means["ij2"][noise]
        ij3 = series_means["ij3"][noise]
        ij4 = series_means["ij4"][noise]
        if not (ij4 < ij3 < ij2):
            bad.append((noise, ij4, ij3, ij2))

    ensure(
        not bad,
        "Cross-series efficiency ordering failed at shared noise levels: "
        + ", ".join(
            f"{noise}:(ij4={ij4:.1f},ij3={ij3:.1f},ij2={ij2:.1f})"
            for noise, ij4, ij3, ij2 in bad
        ),
    )
    print(
        "ordering: shared noise levels preserve thesis-era efficiency story "
        "(ij4 < ij3 < ij2)"
    )


def main() -> None:
    print("== Thesis comparison validation ==")
    print("This checks that regenerated SBCL CI tables preserve the published ACL result trends.")

    series_means = {name: validate_series(name) for name in ("ij2", "ij3", "ij4")}
    validate_cross_series_ordering(series_means)

    print("Thesis comparison validation passed.")


if __name__ == "__main__":
    main()
