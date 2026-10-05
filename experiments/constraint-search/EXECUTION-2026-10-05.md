# Approved execution sequence, 2026-10-05

1. Save and reconcile the research checkpoint: complete. Commit `eaa29b6`
   preserves the research; merge `f10e262` retains remote coordination docs and
   regenerates the combined handbooks. Pushed to `codex/fix-artifact-pipeline`.
2. Fixed-weight ablation: implemented as `table-degree`. All 2,620 FiveAM checks
   pass with CP-SAT enabled. Historical solver code, defaults and goldens unchanged.
3. Repeated measurement: next, 20 fixtures x 8 policies x 2 modes x 5 repetitions
   = 1,600 runs. This expands the old seven-policy protocol to include the control.
   Keep 10-second outer / 5-second solver budgets and retain all failures/UNKNOWNs.
   Record host load at both ends of each run; do not infer speed from cold starts.
4. Memory-CSP: independently check index recall, per-index completions and union
   equality against direct full matching. Anchor any controlled-input adapter to
   the original two-stage entry point before expanding beyond historical cases.
5. Modern-AI demonstrations: implement bounded semantic and proposal verification
   first. Keep scripted suggestions distinct from measured learned or neural output.
   External model/provider/budget choices require a decision before paid API runs.

No public-site deployment or historical-default promotion is authorized by this
sequence. Generated documentation uses an isolated nonexistent public-site path.
