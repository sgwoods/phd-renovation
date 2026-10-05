# Cross-Project Migration Map

This file is the cross-project coordination map for moving Steven Woods
projects from the current MacBook onto a cleaner `Projects-All` layout on the
other machine while keeping GitHub as the durable source of truth.

The main lesson from the PhD and MMath migrations is that **not every named
"project" is a standalone GitHub repo**. Some are true independent repos, and
some are sparse or single-purpose local clones of the shared `sgwoods/public`
repo. We should classify each one before moving it.

## Current Migration State

The current proven state is:

- `phd-renovation` has a clean non-iCloud active clone on the other Mac at:
  `/Users/steven/Projects-All/phd-renovation-working`
- `mmath-renovation` has a clean non-iCloud active clone on the other Mac at:
  `/Users/steven/Projects-All/mmath-renovation-working`
- the companion `public` repo already exists on the other Mac under
  `Projects-All`
- the companion `abtweak-experiments-ui` repo already exists on the other Mac
  under `Projects-All`

That means the new-machine pattern is now proven and should be reused rather
than re-invented.

## Core Rule

Before migrating any additional project, classify it as one of:

1. `Standalone GitHub repo`
2. `Companion/supporting repo`
3. `Shared-public subproject inside sgwoods/public`
4. `Unknown or local-only project that needs audit first`

This classification step is mandatory because the migration path is different
for each class.

## Class 1: Standalone GitHub Repos

These should each get their own active working clone under `Projects-All`.

Current confirmed examples:

| Project | Current local path | Remote | Recommended target on other Mac |
|---|---|---|---|
| `phd-renovation` | `/Users/stevenwoods/phd-renovation` | `https://github.com/sgwoods/phd-renovation.git` | `/Users/steven/Projects-All/phd-renovation-working` |
| `mmath-renovation` | `/Users/stevenwoods/mmath-renovation` | `https://github.com/sgwoods/mmath-renovation.git` | `/Users/steven/Projects-All/mmath-renovation-working` |
| `sci-fi-ai-dystopian-project` | `/Users/stevenwoods/SciFi AI Dystopian Project` | `https://github.com/sgwoods/sci-fi-ai-dystopian-project.git` | `/Users/steven/Projects-All/sci-fi-ai-dystopian-project-working` |

For these, the correct path is:

- audit current repo state
- create/update bootstrap and handoff docs if needed
- prove a fresh non-iCloud clone
- promote the proven state to `main`

## Class 2: Companion / Supporting Repos

These are not just optional archives; they support other active projects.

Current confirmed examples:

| Project | Purpose | Remote | Recommended target on other Mac |
|---|---|---|---|
| `public` | shared public Pages/publication repo | `https://github.com/sgwoods/public.git` | `/Users/steven/Projects-All/public` |
| `abtweak-experiments-ui` | companion hosted UI for MMath / AbTweak | `https://github.com/sgwoods/abtweak-experiments-ui.git` | `/Users/steven/Projects-All/abtweak-experiments-ui` |

These should usually live once, canonically, in `Projects-All`, not as
multiple ad hoc copies.

## Class 3: Shared-Public Subprojects

These currently appear locally as separate Git clones, but they all point to
the same remote:

- `https://github.com/sgwoods/public.git`

Confirmed current examples:

| Local path on this MacBook | Nature |
|---|---|
| `/Users/stevenwoods/Documents/GitPages/canberra-research` | sparse/single-purpose clone of `public` |
| `/Users/stevenwoods/Documents/GitPages/google-canada-research` | sparse/single-purpose clone of `public` |
| `/Users/stevenwoods/Documents/GitPages/inovia-research` | sparse/single-purpose clone of `public` |
| `/Users/stevenwoods/Documents/GitPages/sei-pittsburgh-research` | sparse/single-purpose clone of `public` |
| `/Users/stevenwoods/Documents/GitPages/steven-woods-research` | sparse/single-purpose clone of `public` |
| `/Users/stevenwoods/Documents/GitPages/quack` | sparse/single-purpose clone of `public` |
| `/Users/stevenwoods/Documents/GitPages/kinitos-neoedge` | sparse/single-purpose clone of `public` |

The important implication is:

- these should **not** be treated automatically as independent top-level repos
  in `Projects-All`
- the preferred long-term model is one canonical `public` clone in
  `Projects-All`, with these subprojects managed inside that repo
- we should only keep separate local clones for one of these if there is a
  clear operational reason

### Current caution

Some of these sparse/single-purpose clones already contain local changes on
this MacBook. Examples observed during the audit:

- `google-canada-research`
  - modified: `google-canada-research/README.md`
  - untracked: `google-canada-research/WORKING_STATE_PLAN.md`
- `inovia-research`
  - untracked: `inovia-research/PLAN.md`
- `steven-woods-research`
  - untracked: `WORKING_STATE_RECOVERY_PLAN.md`

That means we should review them one by one before deleting or normalizing
those local clones.

## Class 4: Unknown / Needs Audit First

These names were mentioned as likely migration candidates but are not yet
fully classified from the current filesystem scan:

- `sgwoods`
- any remaining "danglers" not yet tied to a clear Git remote
- any local-only project folders, Drive folders, or unpublished archives that
  may still need preservation before migration

For these, the next step is not cloning. The next step is audit:

- find the local folder
- verify whether it is a Git repo
- identify the remote, if any
- determine whether it is standalone, companion, shared-public, or local-only

## Recommended Projects-All Layout

The target shape on the other Mac should be:

```text
~/Projects-All/
  phd-renovation-working
  mmath-renovation-working
  sci-fi-ai-dystopian-project-working
  abtweak-experiments-ui
  public
```

And then:

- work on `canberra-research`, `google-canada-research`, `inovia-research`,
  `sei-pittsburgh-research`, `steven-woods-research`, `quack`, and
  `kinitos-neoedge` inside the canonical `public` repo unless there is a
  deliberate reason not to
- do not casually create additional top-level clones for those subprojects

## Migration Method By Class

### Standalone GitHub repo

1. audit current repo state
2. document dependencies and bootstrap path
3. prove clean non-iCloud clone in `Projects-All`
4. promote stable state to `main`
5. document handoff and machine-retirement state

### Companion / supporting repo

1. determine which project(s) depend on it
2. ensure one canonical `Projects-All` clone exists
3. document how dependent projects point to it
4. avoid duplicate clones unless there is a concrete need

### Shared-public subproject

1. verify the subproject currently lives inside `sgwoods/public`
2. review whether the separate local clone contains unique unpushed work
3. if not, prefer working inside the canonical `Projects-All/public` clone
4. if yes, reconcile the local differences first, then normalize

### Unknown / local-only project

1. locate it
2. identify whether it is a Git repo
3. identify the remote
4. classify it into one of the other three classes
5. only then choose a migration path

## Recommended Next Order

The current recommended migration order is:

1. stabilize the cross-project map
2. keep `public` and `abtweak-experiments-ui` as canonical supporting clones
   in `Projects-All`
3. migrate `SciFi AI Dystopian Project` as the next standalone repo
4. review the shared-public subprojects one by one, starting with any that
   already have local modifications
5. audit the remaining unknown/dangler projects after that

For the shared reporting and one-place project-summary model that should remain
intact across those moves, see `CROSS-PROJECT-REPORTING-COORDINATION.md`.

## Big-Picture Rule

The point of this map is to prevent category mistakes.

We want:

- GitHub to remain the durable source of truth,
- `Projects-All` to contain a clean set of active working clones,
- iCloud to remain for intake and backup-oriented convenience,
- and local project names to stop implying false independence when they are
  really views into a shared repo.
