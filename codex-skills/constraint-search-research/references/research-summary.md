# From heuristic program understanding to modern constraint and learned search

**As of 2026-10-03.** A selective, source-checked research map, not a systematic
review or a claim that one solver dominates every problem. Source IDs refer to the
[annotated publications](publications.md); recommendations are our hypotheses,
not measured results on this repository.

## What the thesis contributed and what followed directly

Woods's 1996 thesis frames program understanding as finding assignments from plan
roles to program objects under constraints, then assembling local explanations
into coherent hierarchical interpretations. Memory-CSP uses a smaller indexing
problem to seed full matching. Chapters 5-7 cover this local-search story;
chapters 8-9 cover global and hierarchical explanations. The practical insight is
to exploit domain structure rather than enumerate a huge space indiscriminately.
[Thesis, S01](../../../docs/phd-renovation-thesis.pdf).

The immediate lineage includes Woods and Yang's ICSE paper, the Woods/Quilici/Yang
design-recovery book, and Quilici/Woods/Zhang's experiments with program-plan
matching. The later empirical work matters because synthetic noise and real
program structure need not produce the same scaling. A particularly good bridge
to an accessible modern demonstration is van Deursen/Quilici/Woods's recognition
of correct and incorrect leap-year computations for Y2K tools.
[S02](https://doi.org/10.1109/ICSE.1996.493397),
[S03](https://link.springer.com/book/10.1007/978-1-4615-5461-5),
[S04](https://doi.org/10.1016/S0167-6423(99)00039-8),
[S05](https://ir.cwi.nl/pub/62/).

## The largest algorithmic advances

**Learning from failure, not only choosing a promising branch.** Failure-weighted
ordering such as dom/wdeg adapts within a solve. SAT conflict learning records
reasons for dead ends; lazy clause generation combines these deductions with CP
propagation. This is substantially more than ordinary backjumping. CP-SAT is the
first modern engine to benchmark here: it combines several techniques, so a
performance win would not identify a single causal improvement.
[S07](https://www.cril.univ-artois.fr/~boussemart/home/publis.html),
[S08](https://eprints.soton.ac.uk/262032/),
[S09](https://people.eng.unimelb.edu.au/pstuckey/papers/cp07a.pdf),
[S16](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CP.2023.3).

The 2026 MiniZinc Challenge awarded CP-SAT gold in Fixed, Free, Parallel, and Open
categories, but a different solver won Local Search. These are strong external
reasons to include it, not evidence of a win on our matching instances. Current
research includes modular SAT/LCG interfaces, better explanations, and certified
solving. The 2026 LCG retrospective also makes clear that representation and
learning language matter: clause learning is not automatically beneficial.
[S18](https://www.minizinc.org/challenge/),
[S17](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CP.2025.42),
[S10](https://link.springer.com/article/10.1007/s10601-026-09390-9).

**Exploit structure more efficiently.** Global `allDifferent` filtering captures
injectivity more strongly than pairwise inequalities; its landmark algorithm
predates this thesis, so it is an alternative from that era, not a later invention.
Compact-Table offers efficient support maintenance. AND/OR search and caching
exploit separability; graph matching is a natural alternative when a plan is a
labeled relational pattern. SMT is useful when arithmetic or bit-vector semantics
matter. These methods attack different sources of difficulty, not merely raw size.
[S06](https://cse.unl.edu/~choueiry/Documents/ReginAAAI-1994.pdf),
[S11](https://arxiv.org/abs/1604.06641),
[S12](https://doi.org/10.1016/j.artint.2006.11.003),
[S15](https://pmc.ncbi.nlm.nih.gov/articles/PMC7314700/),
[S13](https://www.microsoft.com/en-us/research/project/z3-3/publications/).

## What modern AI changes

NeuroSAT learns representations useful for SAT reasoning; learned branching can
guide an exact solver; GraphCodeBERT learns code/data-flow representations; and
DreamCoder learns reusable program libraries. These are independent developments,
not established descendants of Woods's work. The shared idea is to spend effort
on promising parts of a structured space. The major difference is where the bias
comes from: explicit plans and constraints versus parameters learned across data.
[S20](https://arxiv.org/abs/1802.03685),
[S21](https://papers.nips.cc/paper_files/paper/2019/hash/d14c2267d848abeb81fd590f371d39bd-Abstract.html),
[S19](https://arxiv.org/abs/2009.08366),
[S22](https://people.csail.mit.edu/asolar/papers/EllisWNSMHCST21.pdf).

| Mechanism | Similarity to the thesis | Important difference |
|---|---|---|
| Retrieval-augmented generation | Retrieve candidates before expensive processing | Neural retrieval can miss relevant items; Memory-CSP's index is explicitly constrained. This is an analogy, not a lineage claim. |
| LLM tree search | Expand, evaluate, and backtrack over alternatives | Textual self-evaluation is not a sound constraint propagator. |
| Learned branching | Prioritize search choices | Model inference costs and distribution shift matter; completeness survives only with an exact search and fallback. |
| LLM-to-solver modeling | Separate proposing a representation from solving it | A solver can perfectly solve the wrong translation. |
| RL reasoning and formal proof search | Use feedback to improve future search | Statistical weight updates differ from logically entailed nogoods; proof checking applies only to the formal statement. |

These comparisons draw on RAG, Tree of Thoughts, Logic-LM, DeepSeek-R1,
and AlphaProof [S23-S27 in the ledger](publications.md). Our synthesis is that an
important current direction combines learned proposals with formal checks, rather
than simply replacing search. The 2026 survey of constrained generative models maps
several such combinations; DCP-Bench-Open and SATBench provide useful evaluation
ideas, not direct replacements for our program-understanding tests.
[S30](https://www.ijcai.org/proceedings/2026/864),
[S28](https://arxiv.org/abs/2506.06052v3),
[S29](https://aclanthology.org/2025.emnlp-main.1716/).

**Recommendation:** build a common checked benchmark, then compare preserved Lisp,
improved Lisp, modern exact solvers, learned guidance, and direct model answers.
Show both successes and counterexamples. Neither neural inference nor clever
heuristics remove worst-case combinatorial complexity; the interesting empirical
question is which structure each approach exploits, at what total cost, and with
which guarantees.
