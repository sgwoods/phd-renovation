#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ICLOUD_ROOT="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation"
ICLOUD_INCOMING="${ICLOUD_ROOT}/incoming-landing"
PUBLIC_FALLBACK="${HOME}/GitPages/public"

INSTALL_QUICKLISP=0
SKIP_VALIDATION=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-quicklisp)
      INSTALL_QUICKLISP=1
      shift
      ;;
    --skip-validation)
      SKIP_VALIDATION=1
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: $0 [--install-quicklisp] [--skip-validation]" >&2
      exit 2
      ;;
  esac
done

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing required command: $cmd" >&2
    exit 1
  fi
}

echo "== PhD Renovation new-Mac startup =="
echo "Repo root: $ROOT_DIR"

require_cmd git
require_cmd sbcl
require_cmd python3
require_cmd rg
require_cmd gs
require_cmd curl

python3 - <<'PY'
import importlib.util
import sys
if importlib.util.find_spec("matplotlib") is None:
    sys.exit("Missing required Python package: matplotlib")
PY

mkdir -p "$ICLOUD_INCOMING"
echo "Ensured iCloud intake path: $ICLOUD_INCOMING"

if [[ ! -f "${HOME}/quicklisp/setup.lisp" ]]; then
  if [[ "$INSTALL_QUICKLISP" -eq 1 ]]; then
    echo "Installing Quicklisp..."
    tmp_quicklisp="$(mktemp /tmp/quicklisp.XXXXXX.lisp)"
    trap 'rm -f "$tmp_quicklisp"' EXIT
    curl -fsSL -o "$tmp_quicklisp" https://beta.quicklisp.org/quicklisp.lisp
    sbcl --non-interactive \
      --load "$tmp_quicklisp" \
      --eval '(quicklisp-quickstart:install)' \
      --eval '(sb-ext:exit)'
  else
    echo "Quicklisp is missing at ${HOME}/quicklisp/setup.lisp" >&2
    echo "Re-run with --install-quicklisp, or install Quicklisp first." >&2
    exit 1
  fi
fi

echo "Quicklisp: OK"

if [[ -d "$PUBLIC_FALLBACK" ]]; then
  export PHD_PUBLIC_SITE_DIR="$PUBLIC_FALLBACK"
  echo "Using public site checkout: $PHD_PUBLIC_SITE_DIR"
else
  echo "Public site checkout not found at $PUBLIC_FALLBACK"
  echo "Repo-local docs/status generation will still work."
fi

echo "Branch state:"
git -C "$ROOT_DIR" status -sb

if [[ "$SKIP_VALIDATION" -eq 0 ]]; then
  echo "== Running supported validation spine =="
  sbcl --non-interactive --load "$ROOT_DIR/tests/run.lisp"
  bash "$ROOT_DIR/tests/validate-artifacts.sh"
  bash "$ROOT_DIR/tests/validate-ff-provenance.sh"
  bash "$ROOT_DIR/tests/validate-adt-batch.sh"
  bash "$ROOT_DIR/tests/validate-csp-batch.sh"
  bash "$ROOT_DIR/tests/validate-ao.sh"
  python3 "$ROOT_DIR/tools/generate-release-dashboard.py"
  bash "$ROOT_DIR/tests/validate-dashboard.sh"
fi

cat <<EOF

Startup complete.

Preferred new-material drop path:
  $ICLOUD_INCOMING

Preferred repo-local intake handoff:
  $ROOT_DIR/incoming/_landing

If you need to sync the public site later, clone:
  https://github.com/sgwoods/public

Then set:
  export PHD_PUBLIC_SITE_DIR="\$HOME/GitPages/public"
EOF
