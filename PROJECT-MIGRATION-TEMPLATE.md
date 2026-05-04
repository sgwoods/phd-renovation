# Project Migration Template

This file is the reusable migration playbook for moving one of our projects
from an older machine to a newer one while keeping GitHub as the durable
source of truth.

Use it when we want to migrate a sister project such as `mmath-renovation`
without re-learning the same lessons from scratch.

## Core Operating Model

The migration target is:

- GitHub repo is the durable source of truth.
- `main` should land on the correct stable baseline.
- The active working clone should live in a normal non-iCloud folder.
- iCloud should be used for intake, backup-oriented material, and convenience
  paths, not the preferred live Git worktree.
- We want clear root-level status/version markers so we can tell at a glance
  what state a folder is in.
- We want setup knowledge, validation paths, and machine-handoff rules
  documented in the repo itself.

## Reusable Codex Prompt

Use this prompt as the default starting point for another project migration.
Adjust the project name, any companion repo references, and any known
language/runtime differences.

```text
We are migrating this project off an older Mac onto a newer machine and want GitHub to be the definitive stable source of truth going forward.

Please use the same migration strategy we developed for the PhD renovation project, adapted to this repo. The goal is not just to make this repo work today, but to make it portable, explicit, low-confusion, and safe to continue from a different machine without hidden local knowledge.

Use the checked-in migration playbook at PROJECT-MIGRATION-TEMPLATE.md as the reference model for both the process and the expected end state.

Core operating model:
- GitHub repo is the durable source of truth.
- main should land on the correct stable baseline.
- Active working clone should live in a normal non-iCloud folder.
- iCloud should be used for intake, backup-oriented material, and convenience paths, not the preferred live Git worktree.
- We want clear project-status/version markers so we can tell at a glance what state a folder is in.
- We want all important setup knowledge, validation paths, and handoff steps documented in the repo.

Goals:
1. Confirm the current repo on this machine is healthy, clean, and fully understood.
2. Identify what is tracked, what is untracked by design, and what external dependencies or companion repos are required.
3. Make the project portable to a fresh non-iCloud clone on another Mac.
4. Ensure GitHub main lands on the correct stable baseline.
5. Create or update the following project artifacts as appropriate:
   - BOOTSTRAP-CHECKLIST.md
   - NEW-MAC-HANDOFF.md
   - MACHINE-DEPRECATION-CHECKLIST.md
   - RECOVERY-AND-REPRODUCIBILITY.md
   - PROJECT-STATUS.json
   - PROJECT-STATUS.md
   - scripts/show-project-version.sh
   - scripts/start-codex-new-mac.sh
   - scripts/bootstrap-project-macos.sh
6. Validate that a fresh non-iCloud clone on the other machine can run the project successfully.
7. Make the handoff state explicit so the old machine can be deprecated safely.

Detailed migration strategy:
1. Audit the current machine.
   - Verify branch, commit, cleanliness, remotes.
   - Run the project’s real validation/build/test path.
   - Document any missing dependencies or companion repos.

2. Inventory what matters.
   - Produce a tracked-file inventory or equivalent repo audit.
   - Identify external dependencies:
     - system tools
     - language/runtime package managers
     - companion public/publish repos
     - machine-local paths
   - Separate:
     - tracked source of truth
     - generated but tracked artifacts
     - generated and intentionally ignored artifacts
     - deprecated/manual helpers

3. Add root clarity.
   - Add PROJECT-STATUS.json
   - Add PROJECT-STATUS.md
   - Add scripts/show-project-version.sh
   - Make “what folder is this, what branch is this, what commit is this, is it clean?” answerable instantly.

4. Build the bootstrap path.
   - Add scripts/bootstrap-project-macos.sh
   - Add scripts/start-codex-new-mac.sh
   - Make them:
     - install/verify dependencies
     - find the right runtime/interpreter
     - preserve the current branch when run from an existing checkout
     - avoid dirtying tracked generated artifacts during normal validation

5. Write the handoff docs.
   - BOOTSTRAP-CHECKLIST.md
   - NEW-MAC-HANDOFF.md
   - MACHINE-DEPRECATION-CHECKLIST.md
   - RECOVERY-AND-REPRODUCIBILITY.md

6. Prove a fresh non-iCloud clone on the new machine.
   - Use a normal folder such as ~/Projects-all/<project>-working
   - Do not use an iCloud live Git worktree as the preferred active clone
   - Run the bootstrap/startup scripts there
   - Verify the project can actually build/test/run

7. Fix what the proof exposes.
   - Handle missing dependencies
   - Remove hidden machine assumptions
   - Fix bootstrap branch-reset behavior if present
   - Fix tracked generated artifacts that become dirty during routine validation

8. Promote the proven state.
   - Push the working branch
   - Fast-forward main
   - Push main
   - Reconfirm clean state

9. Document the retirement state.
   - Make it explicit whether the other Mac is now a valid active home
   - Mark any deprecated live worktree experiments or abandoned local paths clearly
   - Keep the ongoing working model simple and explicit

Please proceed step by step, keep the overall plan updated as we go, remind me of the big picture as we progress, and recommend the next few steps after each checkpoint.
```

## Migration Strategy Checklist

Use this as the operator-facing version of the same plan.

### 1. Audit the current machine

- Verify branch, commit, cleanliness, and remotes.
- Run the real validation/build/test path for the project.
- Record machine-specific dependencies or companion repos.

### 2. Inventory tracked versus external state

- Produce a tracked-file inventory or equivalent audit.
- Identify:
  - system tool dependencies
  - language/runtime package manager dependencies
  - companion publish/public repos
  - machine-local paths
- Separate:
  - tracked source of truth
  - tracked generated artifacts
  - ignored generated artifacts
  - deprecated/manual helpers

### 3. Add root-level status clarity

- Add `PROJECT-STATUS.json`
- Add `PROJECT-STATUS.md`
- Add `scripts/show-project-version.sh`

The goal is to make the folder answer these questions instantly:

- What project is this?
- What branch is this?
- What commit is this?
- Is the working tree clean?
- What is the stable baseline?
- What is the current focus?

### 4. Build the bootstrap path

- Add `scripts/bootstrap-project-macos.sh`
- Add `scripts/start-codex-new-mac.sh`

They should:

- install or verify dependencies
- find the correct runtime/interpreter
- preserve the current branch when run from an existing checkout
- avoid dirtying tracked generated artifacts during routine validation

### 5. Write the handoff and retirement docs

- `BOOTSTRAP-CHECKLIST.md`
- `NEW-MAC-HANDOFF.md`
- `MACHINE-DEPRECATION-CHECKLIST.md`
- `RECOVERY-AND-REPRODUCIBILITY.md`

### 6. Prove a fresh non-iCloud clone

Recommended pattern:

- active working clone in something like:
  `~/Projects-all/<project>-working`
- do not use an iCloud live worktree as the preferred active clone
- use iCloud for intake and backup-oriented convenience only

### 7. Fix what the proof exposes

Common failures to correct:

- missing Homebrew packages
- runtime package manager assumptions
- bootstrap script resetting to the wrong branch
- tracked generated files becoming dirty after normal validation
- hidden companion-repo assumptions

### 8. Promote the proven state

- push the working branch
- fast-forward `main`
- push `main`
- reconfirm the project is clean

### 9. Document the final working model

The desired end state is:

- GitHub is the durable source of truth
- `main` lands on the correct stable baseline
- a fresh non-iCloud clone is a valid active home
- iCloud is used for intake/backups, not the preferred live worktree
- the old machine is no longer the only place the project “really works”

## Definition Of Done

For a project migration to be considered complete, we should be able to say:

1. A fresh clone from GitHub works.
2. `main` is current and trustworthy.
3. The new machine has a clean non-iCloud active clone.
4. The bootstrap/startup scripts work there.
5. The project can be continued without hidden local knowledge.
6. The old machine can be treated as secondary or retired safely.
