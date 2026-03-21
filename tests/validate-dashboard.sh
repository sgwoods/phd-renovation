#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== Release dashboard validation =="

required_inputs=(
  "docs/release-dashboard-data.json"
  "tools/generate-release-dashboard.py"
  "docs/release-dashboard.html"
  "docs/public-phd-renovation.html"
)

for path in "${required_inputs[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "Missing required dashboard file: $path" >&2
    exit 1
  fi
done

python3 tools/generate-release-dashboard.py

if ! git diff --quiet -- docs/release-dashboard.html docs/public-phd-renovation.html; then
  echo "Dashboard-generated HTML is out of date with its source data." >&2
  echo "Regenerate it with: python3 tools/generate-release-dashboard.py" >&2
  git diff -- docs/release-dashboard.html docs/public-phd-renovation.html >&2 || true
  exit 1
fi

if ! rg -q "M1: integrated validated baseline" docs/release-dashboard.html; then
  echo "Dashboard output is missing the current milestone marker." >&2
  exit 1
fi

if ! rg -q "Open release dashboard" docs/public-phd-renovation.html; then
  echo "Public project page output is missing the dashboard link." >&2
  exit 1
fi

echo "Release dashboard validation passed."
