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
  "docs/public-status-phd-renovation.json"
)

for path in "${required_inputs[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "Missing required dashboard file: $path" >&2
    exit 1
  fi
done

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

generated_outputs=(
  "docs/release-dashboard.html"
  "docs/public-phd-renovation.html"
  "docs/public-status-phd-renovation.json"
)

for path in "${generated_outputs[@]}"; do
  cp "$path" "$tmp_dir/$(basename "$path")"
done

python3 tools/generate-release-dashboard.py

stale_outputs=0
for path in "${generated_outputs[@]}"; do
  if ! cmp -s "$path" "$tmp_dir/$(basename "$path")"; then
    stale_outputs=1
    break
  fi
done

if [[ "$stale_outputs" -ne 0 ]]; then
  echo "Dashboard-generated HTML is out of date with its source data." >&2
  echo "Regenerate it with: python3 tools/generate-release-dashboard.py" >&2
  diff -u "$tmp_dir/release-dashboard.html" docs/release-dashboard.html >&2 || true
  diff -u "$tmp_dir/public-phd-renovation.html" docs/public-phd-renovation.html >&2 || true
  diff -u "$tmp_dir/public-status-phd-renovation.json" docs/public-status-phd-renovation.json >&2 || true
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

if ! rg -q '"project_id": "phd-renovation"' docs/public-status-phd-renovation.json; then
  echo "Public status manifest is missing the project id." >&2
  exit 1
fi

if ! rg -q '"status_value": "0.2.x-M1"' docs/public-status-phd-renovation.json; then
  echo "Public status manifest is missing the current build line." >&2
  exit 1
fi

echo "Release dashboard validation passed."
