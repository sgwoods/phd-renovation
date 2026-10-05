"""Restricted, exact semantic checking, not a general C parser or an AI model."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def validate(expr, depth=0):
    if depth > 12 or not isinstance(expr, list) or not expr:
        raise ValueError("Expected a bounded Boolean DSL expression")
    op = expr[0]
    if op == "div" and len(expr) == 2 and type(expr[1]) is int and expr[1] in (4, 100, 400):
        return
    arity = {"not": 1, "and": 2, "or": 2}.get(op) if isinstance(op, str) else None
    if arity is None or len(expr) != arity + 1:
        raise ValueError("Only div(4/100/400), not, and, or are supported")
    for child in expr[1:]:
        validate(child, depth + 1)


def evaluate(expr, year):
    op = expr[0]
    if op == "div":
        return year % expr[1] == 0
    if op == "not":
        return not evaluate(expr[1], year)
    if op == "and":
        return evaluate(expr[1], year) and evaluate(expr[2], year)
    return evaluate(expr[1], year) or evaluate(expr[2], year)


def gregorian(year):
    # Independent specification, not interpretation of the reference DSL tree.
    if year % 400 == 0:
        return True
    if year % 100 == 0:
        return False
    return year % 4 == 0


def signature(expr):
    validate(expr)
    return [evaluate(expr, year) for year in range(2000, 2400)]


def same_tree(a, b):
    """A tiny structural-plan baseline: commute Boolean operands, no algebra."""
    if a[0] != b[0] or len(a) != len(b):
        return False
    if a[0] == "div":
        return a == b
    if a[0] == "not":
        return same_tree(a[1], b[1])
    return ((same_tree(a[1], b[1]) and same_tree(a[2], b[2])) or
            (same_tree(a[1], b[2]) and same_tree(a[2], b[1])))


def render(expr, name="year"):
    if expr[0] == "div":
        return f"({name} % {expr[1]} == 0)"
    if expr[0] == "not":
        return f"!{render(expr[1], name)}"
    operator = "&&" if expr[0] == "and" else "||"
    return f"({render(expr[1], name)} {operator} {render(expr[2], name)})"


def check_proposal(original, proposal):
    """A valid model must also be an equivalent translation of its source DSL."""
    expected = signature(original)
    actual = signature(proposal)
    differences = [2000 + i for i, (a, b) in enumerate(zip(expected, actual)) if a != b]
    return {"translation_equivalent": not differences,
            "translation_counterexamples": differences,
            "proposal_is_gregorian": actual == [gregorian(y) for y in range(2000, 2400)]}


def build_report():
    fixtures = HERE / "leap-year-cases.json"
    cases = json.loads(fixtures.read_text())
    reference = cases[0]["expression"]
    known = [(c["plan"], c["expression"]) for c in cases if c.get("plan")]
    start = time.perf_counter()
    rows = []
    for case in cases:
        expr = case["expression"]
        actual = signature(expr)
        matches = [name for name, template in known if same_tree(expr, template)]
        mismatches = [2000 + i for i, result in enumerate(actual) if result != gregorian(2000 + i)]
        rows.append({**case, "code": f"bool {case['id']}(int {case.get('variable', 'year')}) {{ return {render(expr, case.get('variable', 'year'))}; }}",
                     "structural_plans": sorted(set(matches)), "semantically_gregorian": not mismatches,
                     "counterexamples": mismatches, "cycle_signature": actual,
                     "century_probes": {str(y): {"actual": evaluate(expr, y), "expected": gregorian(y)}
                                         for y in (1900, 2000, 2100, 2400)},
                     "scripted_reference_proposal": check_proposal(expr, reference)})
    return {"schema_version": 1, "provenance": "new-synthetic", "generator": "leap-year-dsl-v1",
            "source_commit": subprocess.check_output(["git", "-C", str(ROOT), "rev-parse", "HEAD"], text=True).strip(),
            "working_tree_dirty": bool(subprocess.check_output(["git", "-C", str(ROOT), "status", "--porcelain"], text=True).strip()),
            "source_sha256": {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                              for p in (Path(__file__), fixtures)},
            "model_kind": "none; scripted proposals only", "external_calls": 0,
            "semantic_domain": "mathematical integer years; proleptic Gregorian rule",
            "proof_scope": "Boolean combinations of divisibility by 4, 100, 400 only; period divides 400",
            "cycle": [2000, 2399], "verification_seconds": time.perf_counter() - start, "cases": rows}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.parse_args()
    print(json.dumps(build_report(), indent=2, sort_keys=True))
