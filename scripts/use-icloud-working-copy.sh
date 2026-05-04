#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ICLOUD_PROJECT_DIR="${PHD_ICLOUD_PROJECT_DIR:-$HOME/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation}"
WORKING_COPY_DIR="${PHD_ICLOUD_WORKING_COPY_DIR:-$ICLOUD_PROJECT_DIR/working-copy}"
DEFAULT_REMOTE_URL="https://github.com/sgwoods/phd-renovation.git"
REMOTE_URL="$(git -C "$ROOT_DIR" remote get-url origin 2>/dev/null || printf '%s\n' "$DEFAULT_REMOTE_URL")"
BRANCH="${PHD_WORKING_BRANCH:-main}"
VALIDATE=0
STARTUP_ARGS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --validate)
      VALIDATE=1
      shift
      ;;
    *)
      STARTUP_ARGS+=("$1")
      shift
      ;;
  esac
done

mkdir -p "$ICLOUD_PROJECT_DIR"

if [[ ! -d "$WORKING_COPY_DIR/.git" ]]; then
  echo "Creating iCloud-backed working clone:"
  echo "  $WORKING_COPY_DIR"
  git clone "$REMOTE_URL" "$WORKING_COPY_DIR"
fi

echo "Refreshing iCloud-backed working clone:"
echo "  $WORKING_COPY_DIR"

git -C "$WORKING_COPY_DIR" fetch origin
git -C "$WORKING_COPY_DIR" checkout "$BRANCH"
git -C "$WORKING_COPY_DIR" merge --ff-only "origin/$BRANCH"

echo
echo "Working copy ready:"
echo "  $WORKING_COPY_DIR"

if [[ "$VALIDATE" -eq 1 ]]; then
  echo
  echo "Running startup validation from iCloud-backed working copy..."
  bash "$WORKING_COPY_DIR/scripts/start-codex-new-mac.sh" "${STARTUP_ARGS[@]}"
else
  echo
  echo "Next suggested step:"
  echo "  cd \"$WORKING_COPY_DIR\""
  echo "  bash scripts/start-codex-new-mac.sh"
fi
