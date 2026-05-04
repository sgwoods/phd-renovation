# New Mac Handoff

This file is the shortest practical guide for bringing the project up on a
different Mac and retiring the current machine safely.

The canonical durable state is the Git repo and its pushed branches, not any
single local machine or iCloud working copy.

## Current Portability Goal

We want to be able to:

1. clone the repo on a different Mac,
2. install or verify the required dependencies,
3. run one startup script,
4. validate the supported baseline,
5. and continue work without reconstructing local context by hand.

## Current Local State

At the current portability checkpoint:

- the active working branch is `codex/fix-artifact-pipeline`
- that branch and `main` are both aligned to the durable baseline
- the full startup script has been proven successfully from a fresh local
  clone on this machine, but an iCloud-backed live worktree showed Git status
  hangs on another Mac and should not currently be treated as the preferred
  active-clone model
- the repo-local raw intake landing path is `incoming/_landing/`
- the preferred iCloud-backed raw intake path is:
  `/Users/stevenwoods/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/incoming-landing/`

## Required Dependencies

For the shortest explicit setup order, see `BOOTSTRAP-CHECKLIST.md`.

The supported startup path expects:

- `git`
- `sbcl`
- `python3`
- Python `matplotlib`
- `Ghostscript` (`gs`)
- `ripgrep` (`rg`)
- `curl`
- `Quicklisp`

On macOS, this often means a Homebrew Python rather than only the Apple
Command Line Tools `python3`.
If needed, set `PHD_PYTHON` to the interpreter that has `matplotlib`.

## Start Script

For the cleanest from-scratch machine setup now available, prefer:

```bash
bash scripts/bootstrap-project-macos.sh
```

That script can install the machine dependencies, create or refresh the
recommended non-iCloud active clone, and then hand off to the validated startup
path below. If you run it from an existing project checkout, it now preserves
that checkout's current branch unless you explicitly override it with
`--branch`.

The lower-level startup script remains:

Use:

```bash
bash scripts/start-codex-new-mac.sh
```

If Quicklisp is not installed yet:

```bash
bash scripts/start-codex-new-mac.sh --install-quicklisp
```

If you want to manage the iCloud-backed reference clone, use:

```bash
bash scripts/use-icloud-working-copy.sh
```

The script:

1. checks required commands,
2. finds a Python interpreter that actually has `matplotlib`,
3. creates the preferred iCloud intake path,
4. optionally installs Quicklisp,
5. detects the public Pages checkout if present,
6. and runs the full supported validation spine unless `--skip-validation` is
   passed.

The artifact-validation part of that spine now has two honest modes:

- full regeneration mode when preserved local experiment run trees are present
- fresh-clone portability mode when those ignored run-tree caches are absent

Routine startup/validation now reuses the checked-in thesis PostScript file so
healthy clones stay clean. Regenerate that `.ps` asset only deliberately.

## What Still Needs Deliberate Care

1. Keep the active working branch pushed.
2. Keep `main` aligned with the durable current state.
3. Keep the companion public repo pushed when public-facing outputs change.
4. Put all new finds through `incoming/` or the iCloud landing path.
5. Do not rely on ignored random/situation workspaces as if they were the only
   surviving copy of anything important.

## Deprecating The Current MacBook

Before retiring this MacBook, the safest minimum is:

1. push the active branch,
2. align and push `main`,
3. verify the startup script and validation spine on the new Mac,
4. verify the iCloud-backed intake path exists there,
5. and only then treat the old machine as non-authoritative.

That proof has now been completed once from the iCloud-backed working clone on
this machine, which means the remaining retirement task is operational
discipline rather than missing setup knowledge.

The practical machine-retirement gate now lives in
`MACHINE-DEPRECATION-CHECKLIST.md`, and the current portability caveats are
recorded in `REPO-INVENTORY-AUDIT.md`.
