#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== AO validation =="
echo "This asserted validation protects the supported legacy test4 baseline."

sbcl --non-interactive --load "tests/ao-run.lisp"

echo "AO validation passed."
