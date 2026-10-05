# Two-stage matching audit

Run `python3 experiments/constraint-search/memory/run.py` from the repository root.
The FiveAM research suite also runs the audit and adversarial result mutations.
No historical source, defaults or golden files are changed.

The two native anchors are `quilici-i1` and `q-i2`: the adapter's union must equal
the original `qcsp3:memory-search` result and direct full matching. The native
function returns a list of solution sets, not a flat assignment list.

The 20 controlled near-plan cases use an explicitly labeled two-stage adapter:
original ADT on the index template, followed by original ADT with each partial
mapping pinned in the full template. The original `memory-search` has no
`override-situation` parameter, so these are **not** native Memory-CSP noise runs.
Their `original_memory_search_parity` field is null, never true by analogy.

Both templates are exported through the reviewed predicate allowlist. Every
unary-filtered Cartesian assignment is audited against original predicates;
each exported model is then exhaustively enumerated within 100,000 assignments.
The checks require:

- Original index search equals the complete index oracle.
- Every full match extends an index candidate (candidate recall).
- Each candidate's completions equal precisely the oracle full matches extending it.
- The concatenated completion sets equal direct full matching without duplicates.
- Native historical anchors agree with the original Memory-CSP entry point.

Index false positives are legitimate: a small index can match an incomplete plan.
Report their number, rather than mistaking retrieval for proof of a full match.
Removing a candidate is unsafe without a recall argument; merely reordering them
can preserve completeness if all candidates are eventually completed.

Each case runs in a fresh process with a 60-second outer wall limit. The controlled
ADT stages have 10-second CPU limits; the native historical entry point retains
its defaults but is contained by the outer process limit. A timeout or incomplete
parity audit is ERROR here, not UNSAT. This audit is a correctness gate, not a
timing comparison between differently configured phases.

Scope remains one reviewed index/full plan pair, two native situations, and one
controlled decoy family. It is not arbitrary Memory-CSP template coverage, legacy
random-noise reconstruction, or evidence of cross-family learned generalization.
