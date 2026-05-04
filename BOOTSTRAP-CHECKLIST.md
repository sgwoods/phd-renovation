# Bootstrap Checklist

This file is the shortest explicit checklist for bringing the project up on a
new machine in the currently recommended way.

## Canonical Truth

The durable source of truth for the project is:

1. the Git history in `sgwoods/phd-renovation`,
2. `main` as the durable baseline branch,
3. the active working branch when newer unreleased work is intentionally in
   progress, and
4. the companion public repo `sgwoods/public` for mirrored public-site outputs.

The durable truth is **not** any single local machine, local cache, or iCloud
working copy.

## Recommended Local Layout

Use a normal non-iCloud working clone for day-to-day development:

```text
~/Projects/phd-renovation-working
```

Use iCloud for intake and backup-oriented convenience paths:

```text
~/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/incoming-landing
```

Do not currently treat an iCloud-backed live Git worktree as the preferred
active clone model.

## Machine Dependencies

Required commands/tools:

- `git`
- `sbcl`
- `python3`
- Python `matplotlib`
- `gs` (Ghostscript)
- `rg` (ripgrep)
- `curl`
- Quicklisp

## Suggested macOS Setup Order

1. Install or verify Homebrew if needed.
2. Install the command-line dependencies:

```bash
brew install sbcl ghostscript ripgrep curl
```

3. Ensure Python 3 is available and install `matplotlib` into the interpreter
   you expect the project to use:

```bash
python3 -m pip install matplotlib
```

If the machine has multiple Python interpreters, you can point the bootstrap
script at the correct one with:

```bash
export PHD_PYTHON="/path/to/python3"
```

4. Clone the repo outside iCloud:

```bash
mkdir -p ~/Projects
git clone https://github.com/sgwoods/phd-renovation.git ~/Projects/phd-renovation-working
cd ~/Projects/phd-renovation-working
```

5. Install Quicklisp through the project bootstrap path if needed:

```bash
bash scripts/start-codex-new-mac.sh --install-quicklisp
```

6. After Quicklisp exists, use the normal startup/validation path:

```bash
bash scripts/start-codex-new-mac.sh
```

## What The Startup Script Covers

`scripts/start-codex-new-mac.sh` currently:

1. checks the required commands,
2. finds a Python interpreter that actually has `matplotlib`,
3. ensures the iCloud intake path exists,
4. optionally installs Quicklisp,
5. detects the companion public-site checkout if present,
6. prints branch state, and
7. runs the full supported validation spine unless `--skip-validation` is
   passed.

## Supported Validation Spine

The supported baseline gate is:

- `sbcl --non-interactive --load tests/run.lisp`
- `bash tests/validate-artifacts.sh`
- `bash tests/validate-ff-provenance.sh`
- `bash tests/validate-adt-batch.sh`
- `bash tests/validate-csp-batch.sh`
- `bash tests/validate-ao.sh`
- `python3 tools/generate-release-dashboard.py`
- `bash tests/validate-dashboard.sh`

## Known Current Caveats

- An iCloud-backed live Git worktree showed `git status` hangs on another Mac.
  Use a non-iCloud active clone instead.
- A clone under `/tmp` exposed an SBCL/ASDF cache-path edge case during full
  validation. A normal home-directory non-iCloud clone passed.
- Quicklisp currently installs in the standard user-level location:
  `~/quicklisp/`.

## Companion Public Repo

If you need the public publishing workflow too:

```bash
git clone https://github.com/sgwoods/public ~/GitPages/public
export PHD_PUBLIC_SITE_DIR="$HOME/GitPages/public"
```

The project repo still builds and validates without that companion repo; only
the mirrored publication step depends on it.
