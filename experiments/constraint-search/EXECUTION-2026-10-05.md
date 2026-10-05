# Approved execution sequence, 2026-10-05

1. Save and reconcile the research checkpoint: complete. Commit `eaa29b6`
   preserves the research; merge `f10e262` retains remote coordination docs and
   regenerates the combined handbooks. Pushed to `codex/fix-artifact-pipeline`.
2. Fixed-weight ablation: complete as `table-degree`, committed/pushed at
   `3179718`. Historical solver code, defaults and goldens are unchanged.
3. Repeated measurement: 1,600/1,600 completed with no errors or UNKNOWNs;
   800 exact enumeration sets and 800 first-witness/exhaustive-UNSAT results.
   Frozen/adaptive degree tie on nodes/checks throughout. Host load was variable;
   quiet-host latency validation remains open, not replaced by a speedup claim.
   See [the ablation report](results/2026-10-05-ablation-report.md).
4. Memory-CSP: 22 audits pass index recall, per-index completions and union
   equality. Both native anchors agree with original memory-search; 20 generated
   cases are labeled ADT composition, not native random-noise reproduction.
5. Modern-AI demonstrations: eight restricted-language programs and an offline
   interactive explanation now separate recognition, semantics and translation.
   Scripted proposals are labeled. No model ran. Browser visual QA is blocked by
   local-file URL policy; provider/model/budget approval is needed for paid trials.

The expanded FiveAM suite passes 2,621 checks with CP-SAT, including the Memory-CSP
and semantic/mutation contracts. All 150 original core/AO assertions and the
archive/provenance/dashboard gates pass. See [the extension report](results/2026-10-05-extension-report.md).

## Next bounded package

Author distinct feedback-sensitive plan families, freeze family-level splits,
then measure a small local ranker with exact fallback. Preserve the current
negative ablation result; do not select only new cases on which weights win.
Run a quiet-host timing campaign separately. External model trials and publication
remain explicit decisions, not implicit follow-ons from the offline demonstration.

No public-site deployment or historical-default promotion is authorized by this
sequence. Generated documentation uses an isolated nonexistent public-site path.
