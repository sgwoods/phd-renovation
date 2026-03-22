#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ADT batch generator-drift investigation =="
echo "This compares maintained csp and qcsp3 ADT noise definitions at the source level."

python3 - <<'PY'
from pathlib import Path
import re

root = Path("/Users/stevenwoods/phd-renovation")
csp_text = (root / "csp/adt-setup.lisp").read_text()
qcsp3_text = (root / "qcsp3/adt-setup.lisp").read_text()

def dist_block(text: str, name: str) -> str:
    pattern = re.compile(r'\(\s*"' + re.escape(name) + r'"\s*(.*?)\n\s*\)\)?', re.S)
    match = pattern.search(text)
    if not match:
        raise SystemExit(f"Could not find distribution block for {name}")
    return match.group(1)

def parse_weights(block: str):
    stop_markers = ["((array", "( (array", "((int", "( (int"]
    cut = len(block)
    for marker in stop_markers:
        pos = block.find(marker)
        if pos != -1:
            cut = min(cut, pos)
    stmt_block = block[:cut]
    return [(name.lower(), int(count)) for name, count in re.findall(r'\(([A-Za-z-]+)\s+(\d+)\)', stmt_block)]

def weight_dict(weights):
    return {name: count for name, count in weights}

def print_weights(label: str, weights):
    pairs = ", ".join(f"{name}={count}" for name, count in weights)
    print(f"{label}: {pairs}")

csp_dist1 = parse_weights(dist_block(csp_text, "dist1"))
qcsp3_dist1 = parse_weights(dist_block(qcsp3_text, "dist1"))
qcsp3_old = parse_weights(dist_block(qcsp3_text, "old-dist1-pre-quilici"))

print_weights("csp/dist1", csp_dist1)
print_weights("qcsp3/dist1", qcsp3_dist1)
print_weights("qcsp3/old-dist1-pre-quilici", qcsp3_old)

def signature_map(text: str):
    signatures = {}
    patterns = {
        "uses_random_position": r"\(sloc\s+\(random-position\)\)",
        "uses_get_line_number": r"\(sloc\s+\(get-line-number\)\)",
        "has_generate_ran_while": r"\(defun generate-ran-While",
        "has_generate_ran_increment": r"\(defun generate-ran-Increment",
        "for_uses_named_block": r"\(list begin-sid begin-sloc \(list 'Begin block-name",
        "for_begin_is_unnamed": r"\(list begin-sid begin-sloc \(list 'Begin \)\)",
        "for_end_is_unnamed": r"\(list begin-sid begin-sloc \(list 'End   \)\)",
        "for_stmt_can_increment": r"\(random 4\)",
        "for_stmt_only_zero_assign_print": r"\(random 3\)",
        "block_uses_specific_line": r"generate-ran-Block[\s\S]*get-specific-line",
        "block_uses_random_span": r"generate-ran-Block[\s\S]*\(\+ sloc \(random 35\)\)",
        "supports_situation_reload": r"Reload situation from existing file",
    }
    for name, pattern in patterns.items():
        signatures[name] = bool(re.search(pattern, text))
    return signatures

csp_sig = signature_map(csp_text)
qcsp3_sig = signature_map(qcsp3_text)

print()
print("source-level generator signatures:")
for key in sorted(csp_sig):
    print(f"  {key}: csp={str(csp_sig[key]).lower()} qcsp3={str(qcsp3_sig[key]).lower()}")

csp_weights = weight_dict(csp_dist1)
qcsp3_weights = weight_dict(qcsp3_dist1)
all_keys = sorted(set(csp_weights) | set(qcsp3_weights))
delta = {key: qcsp3_weights.get(key, 0) - csp_weights.get(key, 0) for key in all_keys if qcsp3_weights.get(key, 0) != csp_weights.get(key, 0)}

print()
print("weight delta (qcsp3/dist1 - csp/dist1):")
for key, value in delta.items():
    print(f"  {key}: {value:+d}")
PY

echo "ADT batch generator-drift investigation completed."
