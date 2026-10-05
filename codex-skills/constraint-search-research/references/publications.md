# Annotated research sources

Checked **2026-10-03**. This is a selective primary-source ledger. "Abstract" means
metadata and abstract were inspected; "sections" means selected full-text passages,
not a cover-to-cover technical replication. No paper's reported gain is a measured
gain on this repository. Shortened author lists use "et al." deliberately.

Discovery followed three tracks: Woods/Quilici/Yang and Y2K follow-ons; propagation,
failure learning, decomposition and solver competitions; learned code/search,
constraint modeling and verified generative reasoning. A later refresh should
extend citation chains and inspect full methods before implementing a paper.

## Thesis and direct continuation

**S01. Steven Woods (1996). _A Method of Program Understanding using Constraint
Satisfaction for Software Reverse Engineering_. University of Waterloo, CS-96-33.**
[Preserved PDF](../../../docs/phd-renovation-thesis.pdf).
Depth: title, abstract and contents, cross-checked against local Lisp/tests.
Chapters 5-7 situate Memory-CSP and MAP-CSP; chapters 8-9 situate global PU-CSP and
hierarchical CSPs. Printed page numbers differ from PDF indices. Original baseline,
not evidence that every thesis experiment is currently rerunnable.

**S02. Steven Woods and Qiang Yang (1996). "The Program Understanding Problem:
Analysis and a Heuristic Approach." ICSE, 6-15.**
[DOI](https://doi.org/10.1109/ICSE.1996.493397),
[university-hosted paper](https://www.cs.kent.edu/~jmaletic/cs69995-PC/papers/Woods%20and%20Yang%20-%20The%20program%20understanding%20problem%20analysis%20a.pdf).
Depth: metadata/abstract. Companion formulation and heuristic approach. Use the
conference year, not an inconsistent year in an institutional catalog.

**S03. Steven G. Woods, Alexander E. Quilici and Qiang Yang (1998).
_Constraint-Based Design Recovery for Software Reengineering: Theory and Experiments_.**
[Publisher and contents](https://link.springer.com/book/10.1007/978-1-4615-5461-5).
Depth: metadata/contents. Direct continuation into design recovery. Copyright is
1998; the publisher separately lists a 1997 hardback release and 2012 eBook date.
Do not treat it as a 2012 research breakthrough.

**S04. Alex Quilici, Steven Woods and Yongjun Zhang (2000). "Program plan matching:
experiments with a constraint-based approach." _Science of Computer Programming_
36(2-3), 285-302.**
[Publisher](https://www.sciencedirect.com/science/article/pii/S0167642399000398).
Depth: abstract; introductory sections of its
[1997 WCRE precursor](https://citeseerx.ist.psu.edu/document?doi=5442844a31e7d49cece769a942d5370e81e5262d&repid=rep1&type=pdf).
Direct empirical follow-on. Motivates separating artificial noise tests from real
program constraints rather than extrapolating a single scaling curve.

**S05. Arie van Deursen, Alex Quilici and Steve Woods (2000). "Program plan
recognition for year 2000 tools." _Science of Computer Programming_ 36(2-3), 303-324.**
[CWI record](https://ir.cwi.nl/pub/62/), [paper](https://ir.cwi.nl/pub/62/0062D.pdf).
Depth: abstract/introduction. Direct application lineage: recognize correct and
incorrect leap-year computations. Basis for the proposed leap-year demonstration;
not a claim that its original source corpus is already recovered here.

## Constraint algorithms and alternative representations

**S06. Jean-Charles Regin (1994). "A Filtering Algorithm for Constraints of
Difference in CSPs." AAAI, 362-367.**
[Paper](https://cse.unl.edu/~choueiry/Documents/ReginAAAI-1994.pdf).
Depth: abstract/algorithm overview. Matching-based global injectivity filtering.
Contemporary alternative, not post-thesis work. Test Hall-set pruning against the
current pairwise distinctness semantics.

**S07. Frederic Boussemart, Fred Hemery, Christophe Lecoutre and Lakhdar Sais (2004).
"Boosting Systematic Search by Weighting Constraints." ECAI, 146-150.**
[Author publication record](https://www.cril.univ-artois.fr/~boussemart/home/publis.html).
Depth: abstract/introductory sections. Failure-weighted constraints and variable
selection motivate dom/wdeg. Define attribution when several constraints cause a
domain wipeout; compare against existing dynamic rearrangement.
Link rechecked 2026-10-04: the former proceedings URL now redirects to unrelated
content; use the verified author record for bibliographic identity. This refresh
did not reacquire the full paper. The implemented table-FC weighting variant is
inspired by this work, not a claimed replication of its exact experiments.

**S08. Joao P. Marques-Silva and Karem A. Sakallah (1999). "GRASP: A Search Algorithm
for Propositional Satisfiability." _IEEE Transactions on Computers_ 48(5), 506-521.**
[Author institutional record](https://eprints.soton.ac.uk/262032/),
[paper](https://people.eecs.berkeley.edu/~alanmi/courses/2005_290A/papers/grasp.pdf).
Depth: abstract/overview. Conflict analysis, learning and nonchronological search.
Journal version of earlier work; ordinary backjumping alone is not equivalent to
retaining conflict clauses.

**S09. Olga Ohrimenko, Peter J. Stuckey and Michael Codish (2007). "Propagation =
Lazy Clause Generation." CP, 544-558.**
[Author paper](https://people.eng.unimelb.edu.au/pstuckey/papers/cp07a.pdf).
Depth: abstract/overview. Constraint propagators supply explanations to a SAT-style
learning process. Supports a modern backend comparison; implementing sound
explanations for arbitrary Lisp callbacks is a separate engineering task.

**S10. Olga Ohrimenko, Peter J. Stuckey and Michael Codish (2026). "Lazy clause
generation in retrospect." _Constraints_, online 9 July.**
[Open article](https://link.springer.com/article/10.1007/s10601-026-09390-9).
Depth: selected full-text sections. Research directions include explanations,
learning languages, modular engines and certification. Also discusses limits of
learning and tradeoffs in decomposing global constraints. A contemporary
perspective from the original authors, not a universal performance theorem.

**S11. Jordan Demeulenaere et al. (2016). "Compact-Table: Efficiently Filtering
Table Constraints with Reversible Sparse Bit-Sets." CP.**
[Paper record](https://arxiv.org/abs/1604.06641).
Depth: abstract. Efficient extensional-constraint filtering suggests support
caching and bitsets for repeated compatibility tests. Account for table-generation
time and space; large or context-dependent relations may not suit this encoding.

**S12. Rina Dechter and Robert Mateescu (2007). "AND/OR search spaces for graphical
models." _Artificial Intelligence_ 171(2-3), 73-106.**
[Publisher](https://www.sciencedirect.com/science/article/pii/S000437020600138X),
[author paper](https://www.paradise.caltech.edu/~mateescu/papers/andor_search_spaces.pdf).
Depth: abstract/overview. Structural independence and context caching can change
effective search complexity. Related structurally to hierarchical explanation,
but not the same as the thesis's AND/OR representation or a proven direct descent.

**S13. Leonardo de Moura and Nikolaj Bjorner (2008). "Z3: an efficient SMT solver."
TACAS.**
[Official publication record](https://www.microsoft.com/en-us/research/project/z3-3/publications/).
Depth: metadata and solver overview. SMT offers an alternative for arithmetic,
arrays and bit-vector semantics. A faithful program semantics encoding is still
required; choosing SMT does not provide one automatically.

**S14. Lin Xu, Frank Hutter, Holger H. Hoos and Kevin Leyton-Brown (2008).
"SATzilla: Portfolio-based Algorithm Selection for SAT." _JAIR_ 32, 565-606.**
[Paper record](https://arxiv.org/abs/1111.2249).
Depth: abstract. Instance features can select complementary algorithms. Include
feature cost and out-of-distribution tests. The arXiv upload is 2011; publication
is 2008. A portfolio should follow, not precede, credible individual baselines.

**S15. Ciaran McCreesh, Patrick Prosser and James Trimble (2020). "The Glasgow
Subgraph Solver: Using Constraint Programming to Tackle Hard Subgraph Isomorphism
Problem Variants." ICGT, 316-324.**
[Open paper](https://pmc.ncbi.nlm.nih.gov/articles/PMC7314700/),
[implementation](https://github.com/ciaranm/glasgow-subgraph-solver).
Depth: abstract/selected sections. Strong structural matching alternative. Compare
labels, direction, injectivity, and induced versus non-induced semantics explicitly;
arbitrary program constraints are not necessarily subgraph constraints.

**S16. Laurent Perron, Frederic Didier and Steven Gay (2023). "The CP-SAT-LP Solver."
CP, invited talk, 3:1-3:2.**
[Official proceedings](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CP.2023.3).
Depth: extended abstract. Describes the combination of CP/SAT techniques, linear
relaxation and portfolio search. This is an invited extended abstract, not a full
controlled benchmark paper.

**S17. Jip J. Dekker, Alexey Ignatiev, Peter J. Stuckey and Allen Z. Zhong (2025).
"Towards Modern and Modular SAT for LCG (Short Paper)." CP, 42:1-42:12.**
[Official proceedings](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CP.2025.42).
Depth: abstract/selected full text. Huub and a modular SAT interface illustrate
ongoing solver architecture research. A research alternative after establishing
CP-SAT parity, not a required dependency of this project.

**S18. MiniZinc Challenge (2026). Official results, announced 23 July.**
[Challenge and medal table](https://www.minizinc.org/challenge/).
Depth: official table. CP-SAT won Fixed, Free, Parallel and Open; QiuQi-MIXSolver
won Local Search. Categories and instance selection matter. These results justify
baseline selection, not speedup estimates for thesis cases.

## Learned search and modern AI

**S19. Daya Guo et al. (2021). "GraphCodeBERT: Pre-training Code Representations with
Data Flow." ICLR; preprint 2020.**
[Paper record](https://arxiv.org/abs/2009.08366).
Depth: abstract. Data-flow-aware representations are candidates for plan retrieval
and similarity features. Code similarity is not semantic equivalence or an exact
match certificate; test misleading names and altered dependencies.

**S20. Daniel Selsam et al. (2019). "Learning a SAT Solver from Single-Bit
Supervision." ICLR; preprint 2018.**
[Paper record](https://arxiv.org/abs/1802.03685).
Depth: abstract. NeuroSAT learns a message-passing process with SAT supervision.
A decoded assignment can be checked; a neural prediction of unsatisfiability is
not an UNSAT proof. Use as a research comparator, not the default exact solver.

**S21. Maxime Gasse, Didier Chetelat, Nicola Ferroni, Laurent Charlin and Andrea
Lodi (2019). "Exact Combinatorial Optimization with Graph Convolutional Neural
Networks." NeurIPS.**
[Official paper](https://papers.nips.cc/paper_files/paper/2019/hash/d14c2267d848abeb81fd590f371d39bd-Abstract.html).
Depth: abstract/overview. Imitation learning guides branching in a mixed-integer
solver. Demonstrates a learned-policy/exact-engine separation; transfer to program
matching is a hypothesis, not a result of this paper.

**S22. Kevin Ellis et al. (2021). "DreamCoder: Bootstrapping Inductive Program
Synthesis with Wake-Sleep Library Learning." PLDI.**
[Author paper](https://people.csail.mit.edu/asolar/papers/EllisWNSMHCST21.pdf).
Depth: abstract/overview. Learns libraries and search guidance for synthesis.
Useful analogy to reusable plan knowledge, but synthesizing a program and
recognizing a plan in an existing program are different tasks.

**S23. Patrick Lewis et al. (2020). "Retrieval-Augmented Generation for
Knowledge-Intensive NLP Tasks." NeurIPS.**
[Paper record](https://arxiv.org/abs/2005.11401).
Depth: abstract. Retrieval plus generation is an architectural comparison for
two-stage search. It neither establishes a historical connection to Memory-CSP
nor guarantees complete retrieval or factual correctness.

**S24. Liangming Pan, Alon Albalak, Xinyi Wang and William Wang (2023). "Logic-LM:
Empowering Large Language Models with Symbolic Solvers for Faithful Logical
Reasoning." Findings of EMNLP, 3806-3824.**
[Official paper](https://aclanthology.org/2023.findings-emnlp.248/).
Depth: abstract. LLM formalization, symbolic solving and error-guided refinement
motivate a modeling-assistant track. Check formalization separately from solving.

**S25. Shunyu Yao et al. (2023). "Tree of Thoughts: Deliberate Problem Solving with
Large Language Models." NeurIPS.**
[Proceedings paper](https://proceedings.neurips.cc/paper/2023/file/271db9922b8d1f4dd7aaef84ed5ac703-Paper-Conference.pdf).
Depth: abstract/overview. Search over generated intermediate candidates connects
explicit heuristic search to model-guided exploration. Textual self-evaluation
does not inherit the soundness of constraint propagation.

**S26. DeepSeek-AI et al. (2025; revised 2026). "DeepSeek-R1: Incentivizing
Reasoning Capability in LLMs via Reinforcement Learning."**
[Version 2, 4 January 2026](https://arxiv.org/abs/2501.12948v2).
Depth: abstract and version metadata. Relevant for reinforcement-trained reasoning
and verifiable rewards. Do not equate statistical learning with logical nogoods,
or omit model training cost when discussing the source of capability. The related
2025 Nature article has a different title; this citation identifies the preprint.

**S27. Thomas Hubert et al. (2026). "Olympiad-level formal mathematical reasoning
with reinforcement learning." _Nature_ 651, 607-613; online 12 November 2025.**
[Article](https://www.nature.com/articles/s41586-025-09833-y).
Depth: abstract/selected sections. AlphaProof combines learned search with Lean
checking. A powerful illustrative parallel, not a program-matching benchmark.
Keep the formal statement boundary and substantial training/inference compute
visible when explaining its guarantees.

**S28. Kostis Michailidis, Dimos Tsouros and Tias Guns (2026).
"DCP-Bench-Open: Evaluating LLMs for Constraint Modelling of Discrete Combinatorial
Problems." arXiv:2506.06052v3, 28 January.**
[Version 3](https://arxiv.org/abs/2506.06052v3),
[CP-Bench version 2](https://arxiv.org/abs/2506.06052v2).
Depth: abstract/version notes. V3 is marked under review; v2 is the CP-Bench paper
accepted at ECAI 2025. Do not merge the names, publication status, dataset scope or
accuracy figures. Inspires translation tests across modeling systems.

**S29. Anjiang Wei et al. (2025). "SATBench: Benchmarking LLMs' Logical Reasoning
via Automated Puzzle Generation from SAT Formulas." EMNLP, 33832-33849.**
[Official paper](https://aclanthology.org/2025.emnlp-main.1716/).
Depth: abstract. Ground puzzles in SAT formulas and vary difficulty. Useful
evaluation design, but text rendering can introduce a second semantic boundary;
do not assume a generated puzzle faithfully expresses its source formula.

**S30. Alexandre Bonlarron, Francois Pachet, Pierre Roy and Jean-Charles Regin
(2026). "Constraining Generative Models: A Survey from the Constraint Programming
Perspective." IJCAI, 7777-7786.**
[Official proceedings](https://www.ijcai.org/proceedings/2026/864).
Depth: abstract. Maps links between generative models, constraints, compilation
and probabilistic representations. Constraining output syntax is not the same as
guaranteeing a program's meaning. Read full methods before choosing an integration.

## Learning specifications and software representations

**S31. Christian Bessiere, Frederic Koriche, Nadjib Lazaar and Barry O'Sullivan
(2017). "Constraint acquisition." _Artificial Intelligence_ 244, 315-342.**
[Publisher](https://www.sciencedirect.com/science/article/pii/S0004370215001162).
Depth: abstract. Learning constraints from examples and queries offers a route to
expanding plan libraries. Finite examples can underdetermine the intended model;
use negative examples and counterexamples rather than treating fit as proof.

**S32. Armando Solar-Lezama, Liviu Tancau, Rastislav Bodik, Vijay Saraswat and
Sanjit Seshia (2006). "Combinatorial Sketching for Finite Programs." ASPLOS, 404-415.**
[Author paper](https://people.csail.mit.edu/asolar/papers/asplos06-final.pdf).
Depth: abstract/overview. Counterexample-guided synthesis suggests a way to refine
candidate plan predicates. Guarantees are relative to the encoded finite program
domain; this is a synthesis alternative, not a direct recognition successor.

**S33. Fabian Yamaguchi, Nico Golde, Daniel Arp and Konrad Rieck (2014). "Modeling
and Discovering Vulnerabilities with Code Property Graphs." IEEE S&P, 590-604.**
[Proceedings paper](https://www.ieee-security.org/TC/SP2014/papers/ModelingandDiscoveringVulnerabilitieswithCodePropertyGraphs.pdf).
Depth: abstract/overview. Unified syntax, control and dependence graphs offer a
modern frontend and query-based alternative to plan matching. Structural matches
are still not unrestricted semantic equivalence proofs.

## Gaps worth resolving next

Before implementation, read the full algorithm/evaluation sections for the selected
method and pin an implementation version and license. Expand proof-logging,
weighted MaxSAT/ASP, e-graph/abstract-interpretation, and recent constraint
acquisition coverage when those tracks become active. We have not reproduced any
external paper's results or surveyed every 2026 preprint. No quantitative
cross-paper leaderboard is implied by this ledger.
