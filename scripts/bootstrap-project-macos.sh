#!/usr/bin/env bash
set -euo pipefail

DEFAULT_TARGET_DIR="${HOME}/Projects/phd-renovation-working"
DEFAULT_PUBLIC_DIR="${HOME}/GitPages/public"
DEFAULT_REPO_URL="https://github.com/sgwoods/phd-renovation.git"
DEFAULT_PUBLIC_REPO_URL="https://github.com/sgwoods/public.git"

TARGET_DIR="$DEFAULT_TARGET_DIR"
PUBLIC_DIR="$DEFAULT_PUBLIC_DIR"
REPO_URL="$DEFAULT_REPO_URL"
PUBLIC_REPO_URL="$DEFAULT_PUBLIC_REPO_URL"
BRANCH="main"
INSTALL_HOMEBREW=0
CLONE_PUBLIC=0
SKIP_VALIDATION=0
INSTALL_QUICKLISP=1
BRANCH_EXPLICIT=0

usage() {
  cat <<'EOF'
Usage:
  bash scripts/bootstrap-project-macos.sh [options]

Options:
  --target-dir DIR         Active non-iCloud working clone path
  --branch BRANCH          Branch to check out after cloning/updating (default: main)
  --repo-url URL           Repo URL to clone/update
  --public-dir DIR         Companion public repo path
  --public-repo-url URL    Companion public repo URL
  --clone-public           Clone/update the companion public repo too
  --skip-validation        Skip the final startup validation pass
  --skip-quicklisp         Do not auto-install Quicklisp if missing
  --install-homebrew       Install Homebrew first if it is missing
  --help                   Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-dir)
      TARGET_DIR="$2"
      shift 2
      ;;
    --branch)
      BRANCH="$2"
      BRANCH_EXPLICIT=1
      shift 2
      ;;
    --repo-url)
      REPO_URL="$2"
      shift 2
      ;;
    --public-dir)
      PUBLIC_DIR="$2"
      shift 2
      ;;
    --public-repo-url)
      PUBLIC_REPO_URL="$2"
      shift 2
      ;;
    --clone-public)
      CLONE_PUBLIC=1
      shift
      ;;
    --skip-validation)
      SKIP_VALIDATION=1
      shift
      ;;
    --skip-quicklisp)
      INSTALL_QUICKLISP=0
      shift
      ;;
    --install-homebrew)
      INSTALL_HOMEBREW=1
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return 0
  fi

  if [[ "$INSTALL_HOMEBREW" -ne 1 ]]; then
    echo "Homebrew is required but not installed." >&2
    echo "Either install Homebrew first or re-run with --install-homebrew." >&2
    exit 1
  fi

  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

brew_prefix() {
  brew --prefix
}

ensure_brew_package() {
  local package="$1"
  if brew list "$package" >/dev/null 2>&1; then
    echo "brew package present: $package"
    return 0
  fi

  echo "Installing brew package: $package"
  brew install "$package"
}

detect_default_branch() {
  if [[ "$BRANCH_EXPLICIT" -eq 1 ]]; then
    return 0
  fi

  if git -C "$(pwd)" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local current_branch
    current_branch="$(git -C "$(pwd)" branch --show-current 2>/dev/null || true)"
    if [[ -n "$current_branch" ]]; then
      BRANCH="$current_branch"
    fi
  fi
}

pick_bootstrap_python() {
  local candidates=()
  local prefix

  if [[ -n "${PHD_PYTHON:-}" ]]; then
    candidates+=("$PHD_PYTHON")
  fi

  prefix="$(brew_prefix)"
  if [[ -x "${prefix}/bin/python3" ]]; then
    candidates+=("${prefix}/bin/python3")
  fi

  if command -v python3 >/dev/null 2>&1; then
    candidates+=("$(command -v python3)")
  fi

  local candidate
  for candidate in "${candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

ensure_matplotlib() {
  local python_cmd="$1"

  if "$python_cmd" -c 'import importlib.util, sys; sys.exit(0 if importlib.util.find_spec("matplotlib") else 1)' >/dev/null 2>&1; then
    echo "matplotlib available via: $python_cmd"
    return 0
  fi

  if brew list matplotlib >/dev/null 2>&1; then
    echo "matplotlib package already installed via Homebrew"
  else
    echo "Installing matplotlib via Homebrew"
    brew install matplotlib
  fi

  if "$python_cmd" -c 'import importlib.util, sys; sys.exit(0 if importlib.util.find_spec("matplotlib") else 1)' >/dev/null 2>&1; then
    echo "matplotlib available via: $python_cmd"
    return 0
  fi

  echo "matplotlib is still not visible to: $python_cmd" >&2
  echo "Set PHD_PYTHON to the Python interpreter that has matplotlib." >&2
  exit 1
}

clone_or_update_repo() {
  local repo_url="$1"
  local target_dir="$2"
  local branch="$3"

  mkdir -p "$(dirname "$target_dir")"

  if [[ ! -d "$target_dir/.git" ]]; then
    echo "Cloning repo into: $target_dir"
    git clone "$repo_url" "$target_dir"
  fi

  echo "Refreshing repo: $target_dir"
  git -C "$target_dir" fetch origin
  git -C "$target_dir" checkout "$branch"
  git -C "$target_dir" merge --ff-only "origin/$branch"
}

main() {
  detect_default_branch

  echo "== PhD Renovation macOS bootstrap =="
  echo "Target repo: $TARGET_DIR"
  echo "Branch: $BRANCH"

  if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required to bootstrap this machine." >&2
    exit 1
  fi

  ensure_homebrew
  ensure_brew_package git
  ensure_brew_package python
  ensure_brew_package sbcl
  ensure_brew_package ghostscript
  ensure_brew_package ripgrep
  ensure_brew_package curl

  local python_cmd
  python_cmd="$(pick_bootstrap_python)" || {
    echo "No usable Python 3 interpreter was found after package installation." >&2
    exit 1
  }

  ensure_matplotlib "$python_cmd"

  clone_or_update_repo "$REPO_URL" "$TARGET_DIR" "$BRANCH"

  if [[ "$CLONE_PUBLIC" -eq 1 ]]; then
    clone_or_update_repo "$PUBLIC_REPO_URL" "$PUBLIC_DIR" main
    export PHD_PUBLIC_SITE_DIR="$PUBLIC_DIR"
  fi

  export PHD_PYTHON="$python_cmd"

  local startup_args=()
  if [[ "$INSTALL_QUICKLISP" -eq 1 ]]; then
    startup_args+=(--install-quicklisp)
  fi
  if [[ "$SKIP_VALIDATION" -eq 1 ]]; then
    startup_args+=(--skip-validation)
  fi

  echo
  echo "Handing off to startup validation..."
  bash "$TARGET_DIR/scripts/start-codex-new-mac.sh" "${startup_args[@]}"
}

main "$@"
