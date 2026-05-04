# Cross-Project Reporting Coordination

This file records the shared reporting and project-summary model we want to
keep stable across Steven Woods projects as they move to the newer machine.

The intent is simple:

- there should be one default starting point for project summaries,
- that starting point should link to each project's deeper docs and status,
- new ingestion and migration work should not break that shared view,
- and every migrated project should rejoin the same reporting surface cleanly.

## Default Starting Point

The default starting point for cross-project status and summaries is the
shared `sgwoods/public` site and repo.

That shared surface is where we want to be able to see, in one place:

- a project-level summary,
- current status/build line/focus,
- links to the detailed project page,
- links to the dashboard,
- links to the readable handbook or equivalent documentation,
- and any other project-specific deeper references.

This is the coordination layer above any single repo.

## Core Coordination Rule

Each standalone project should maintain:

1. its own durable GitHub repo as source of truth,
2. its own local status/version markers,
3. its own bootstrap and handoff documentation,
4. and its own public-facing exported status artifacts.

The shared `public` repo should then act as the common presentation layer that
surfaces those per-project outputs in one place.

That means:

- **project repos own their own truth**
- **the shared public repo owns the cross-project summary surface**

## Reporting Surface By Project Type

### 1. Standalone project repo

Examples:

- `phd-renovation`
- `mmath-renovation`
- `sci-fi-ai-dystopian-project`

Expected reporting pattern:

- a tracked project-status source in the repo
- generated local outputs such as:
  - dashboard
  - public project page
  - public status manifest
  - readable handbook, if used by that project
- a sync path into the shared `public` repo

### 2. Companion/supporting repo

Examples:

- `public`
- `abtweak-experiments-ui`

Expected reporting pattern:

- do not duplicate a fake standalone project-summary model unless the repo is
  actually intended to present as its own project
- document clearly which standalone projects depend on it

### 3. Shared-public subproject

Examples:

- `canberra-research`
- `google-canada-research`
- `inovia-research`
- `sei-pittsburgh-research`
- `steven-woods-research`
- `quack`
- `kinitos-neoedge`

Expected reporting pattern:

- these are coordinated primarily through the shared `public` repo itself
- they should not be treated automatically as full independent migration
  targets unless we deliberately decide to split them into standalone repos
- their summaries and pages should remain coherent within the shared public
  navigation model

## What Must Stay Intact During Migration

When a project is migrated to `Projects-All`, we must preserve all of:

1. repo-local truth
2. local bootstrap/startup/recovery clarity
3. public-facing status export
4. cross-project summary visibility
5. links from the summary layer to the detailed layer

In practice, for a standalone project, that means checking:

- the repo can build and validate locally,
- the local project page/dashboard/handbook generation still works,
- the public export path is still understood,
- and the shared public summary surface can still point to it.

## Migration Checklist Add-On

Use this extra checklist alongside the normal project migration process.

For each migrated project, confirm:

1. What is the canonical public/project-summary entry point for this project?
2. Does the repo generate its own public-facing status artifacts?
3. Where do those artifacts sync into the shared `public` repo?
4. Does the shared public surface still link correctly to:
   - the project page
   - the dashboard
   - the handbook or equivalent deep docs
5. If the project is a shared-public subproject rather than a standalone repo,
   should it stay that way or be split in the future?

## Recommended Ongoing Model

Going forward:

- `Projects-All` should hold the canonical active clones:
  - standalone project repos
  - supporting repos like `public` and `abtweak-experiments-ui`
- `public` should remain the one shared cross-project summary/presentation
  layer
- each standalone project migration should end with a quick reporting check to
  ensure it has rejoined that shared surface

## Current Practical Read

At this checkpoint:

- `phd-renovation` has a defined project page, dashboard, handbook, and public
  status manifest flow
- `mmath-renovation` uses the shared `public` repo as part of its continuity
  and release/public drill path
- the shared-public research subprojects are still primarily `public`-repo
  concerns rather than true standalone repos

So the next reporting goal is not to invent a second coordination layer.
It is to keep the shared `public` layer healthy while each standalone project
becomes more portable and explicit.

## Big-Picture Rule

We want one stable pattern:

- GitHub repo per true standalone project = durable project truth
- shared `public` repo = durable cross-project summary and presentation layer
- migration work must preserve both layers together
