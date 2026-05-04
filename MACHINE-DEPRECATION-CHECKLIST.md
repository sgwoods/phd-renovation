# Machine Deprecation Checklist

This file is the practical answer to:

**When is the current MacBook no longer the authoritative home of this
project?**

Use it when we want to retire a local machine confidently without losing
project state, setup knowledge, or historical material.

## Goal

We want a state where:

1. the durable baseline is in git and on the remote,
2. the preferred local working copy lives in an iCloud-backed location,
3. the supported startup path works from that location,
4. intake and preservation workflows are documented there too,
5. and the old machine can be treated as secondary without anxiety.

## Current Read

At the current checkpoint:

- `main` and `codex/fix-artifact-pipeline` are aligned to the durable current
  baseline.
- the supported startup script has passed from the iCloud-backed working copy.
- the iCloud-backed intake landing path exists.
- the thesis graph tables and comparison PDFs needed for fresh-clone artifact
  validation are now tracked.

That means the current MacBook is no longer the only place where the project
"really works."

## Retirement Gate

Treat the old machine as non-authoritative only when all of the following are
true:

1. `main` is pushed and current.
2. any newer working-branch changes are also pushed.
3. the iCloud-backed working copy has been refreshed to the intended commit.
4. `bash scripts/start-codex-new-mac.sh` has passed from the iCloud-backed
   working copy.
5. the preferred intake path exists:
   `/Users/stevenwoods/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/incoming-landing`
6. public-site publication, if needed, is already pushed from the companion
   public repo.

## Preferred Ongoing Local Home

Going forward, the preferred local working location on this machine is:

`/Users/stevenwoods/Library/Mobile Documents/com~apple~CloudDocs/Projects/phd-renovation/working-copy`

The helper script for refreshing or creating that clone is:

`scripts/use-icloud-working-copy.sh`

Use:

```bash
bash scripts/use-icloud-working-copy.sh
```

Or, to refresh the iCloud clone and immediately run the supported startup
validation:

```bash
bash scripts/use-icloud-working-copy.sh --validate
```

## What The Old Machine Still Matters For

Once the retirement gate above is satisfied, the old machine should be treated
as:

- a temporary convenience copy,
- a place to verify nothing unexpected was left behind,
- but not the source of truth for day-to-day continuation.

## Big-Picture Rule

The project should remain:

- git-backed,
- iCloud-backed locally,
- preservation-first,
- and recoverable from a fresh checkout plus documented dependencies.

If that remains true, machine retirement is an operational change, not a
project risk.
