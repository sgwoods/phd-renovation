# Scripts

This directory holds the maintained machine-bootstrap and working-copy helper
scripts for the project.

## Current Scripts

### `bootstrap-project-macos.sh`

Preferred from-scratch bootstrap path for a new Mac.

Use this when you want one script to:

1. verify or optionally install Homebrew,
2. install the command-line dependencies,
3. ensure Python has `matplotlib`,
4. create or refresh the recommended non-iCloud active clone,
5. optionally clone the companion public repo,
6. install Quicklisp if needed, and
7. hand off to the validated startup/validation path.

Typical use:

```bash
bash scripts/bootstrap-project-macos.sh
```

Useful options:

```bash
bash scripts/bootstrap-project-macos.sh --clone-public
bash scripts/bootstrap-project-macos.sh --target-dir "$HOME/Projects/phd-renovation-working"
bash scripts/bootstrap-project-macos.sh --skip-validation
bash scripts/bootstrap-project-macos.sh --install-homebrew
```

### `start-codex-new-mac.sh`

Lower-level startup/validation helper once the repo already exists locally.

Use this when the machine is mostly prepared and you want to:

1. verify the expected commands,
2. verify Python + `matplotlib`,
3. ensure the iCloud intake path exists,
4. install Quicklisp if requested,
5. and run the supported validation spine.

Typical use:

```bash
bash scripts/start-codex-new-mac.sh
```

If Quicklisp is missing:

```bash
bash scripts/start-codex-new-mac.sh --install-quicklisp
```

### `use-icloud-working-copy.sh`

Reference-clone helper for the iCloud-backed convenience copy.

Use this only to maintain or refresh the backup/reference clone. It is not the
preferred active-clone model for day-to-day Git work.
