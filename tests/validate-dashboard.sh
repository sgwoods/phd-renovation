#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== Release dashboard validation =="

required_inputs=(
  "PROJECT-STATUS.json"
  "docs/release-dashboard-data.json"
  "tools/generate-release-dashboard.py"
  "tools/generate_project_handbook.py"
  "scripts/show-project-version.sh"
  "docs/release-dashboard.html"
  "docs/project-handbook.html"
  "docs/public-phd-renovation.html"
  "docs/public-phd-renovation-handbook.html"
  "docs/public-status-phd-renovation.json"
  "data/thesis/Woods PHD CS-96-33 A Method of Program Understanding using Constraint Satisfaction.pdf"
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
  "PROJECT-STATUS.md"
  "docs/project-handbook.html"
  "docs/public-phd-renovation.html"
  "docs/public-phd-renovation-handbook.html"
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
  diff -u "$tmp_dir/PROJECT-STATUS.md" PROJECT-STATUS.md >&2 || true
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

if ! rg -q "phd-renovation-thesis.pdf" docs/public-phd-renovation.html; then
  echo "Public project page output is missing the thesis PDF link." >&2
  exit 1
fi

if ! rg -q "phd-renovation-thesis.ps" docs/public-phd-renovation.html; then
  echo "Public project page output is missing the thesis PostScript link." >&2
  exit 1
fi

expected_build_line="$(python3 - <<'PY'
import json
from pathlib import Path
data = json.loads(Path("PROJECT-STATUS.json").read_text())
print(data["metrics"]["build_line"]["value"])
PY
)"

thesis_pdf="docs/phd-renovation-thesis.pdf"
thesis_ps="docs/phd-renovation-thesis.ps"
source_thesis_pdf="data/thesis/Woods PHD CS-96-33 A Method of Program Understanding using Constraint Satisfaction.pdf"

if [[ ! -s "$thesis_pdf" ]]; then
  echo "Generated thesis PDF is missing." >&2
  exit 1
fi

if [[ ! -s "$thesis_ps" ]]; then
  echo "Generated thesis PostScript is missing." >&2
  exit 1
fi

if ! cmp -s "$source_thesis_pdf" "$thesis_pdf"; then
  echo "Generated thesis PDF is out of sync with the canonical thesis source." >&2
  exit 1
fi

if ! rg -q "$expected_build_line" docs/public-phd-renovation.html; then
  echo "Public project page output is missing the current build line." >&2
  exit 1
fi

if ! rg -q "Steven Woods" docs/public-phd-renovation.html; then
  echo "Public project page output is missing the parent-site link." >&2
  exit 1
fi

if ! rg -q "Table of contents" docs/project-handbook.html; then
  echo "Project handbook output is missing the table of contents." >&2
  exit 1
fi

if ! rg -q "Current focus" PROJECT-STATUS.md; then
  echo "Root project status summary is missing expected status content." >&2
  exit 1
fi

if ! bash -n scripts/show-project-version.sh; then
  echo "show-project-version helper has invalid shell syntax." >&2
  exit 1
fi

if ! rg -q "Readable handbook for the full project state" docs/public-phd-renovation-handbook.html; then
  echo "Public handbook output is missing the handbook hero copy." >&2
  exit 1
fi

if ! rg -q "PhD Renovation" docs/public-phd-renovation-handbook.html; then
  echo "Public handbook output is missing the parent-page link." >&2
  exit 1
fi

if ! rg -q "PhD Renovation" docs/release-dashboard.html; then
  echo "Repository dashboard output is missing the parent-page link." >&2
  exit 1
fi

if ! rg -q '"project_id": "phd-renovation"' docs/public-status-phd-renovation.json; then
  echo "Public status manifest is missing the project id." >&2
  exit 1
fi

if ! rg -q "\"status_value\": \"$expected_build_line\"" docs/public-status-phd-renovation.json; then
  echo "Public status manifest is missing the current build line." >&2
  exit 1
fi

echo "Release dashboard validation passed."
