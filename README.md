# PhD Research: Program Understanding via Constraint Satisfaction

Modernized codebase from the PhD thesis *"A Method of Program Understanding using Constraint Satisfaction"* (Steven Woods, University of Waterloo, CS-96-33).

Originally developed in Allegro Common Lisp on SPARC, renovated for SBCL on modern hardware.

## What This Is

A constraint satisfaction approach to automated program understanding. Given a program's abstract syntax, the system matches it against a library of programming plans (templates) using CSP techniques to identify algorithmic patterns.

Three CSP solving strategies are implemented and compared:

- **MAP-CSP** (`adt`): Direct CSP matching with backtracking, forward checking, and dynamic rearrangement
- **Memory-CSP** (`memory-search`): Two-phase approach using a memory of previously solved problems to guide search
- **Quilici Search**: Memory-based retrieval with similarity metrics

## Project Structure

```
csp/                    Base CSP solver (backtracking, AC-3, queens, ADT, MPR)
qcsp3/                  Extended solver (memory-CSP, GSAT, Quilici search)
Q-Batch/                Original experiment results (Allegro CL, SPARC)
Q-Batch-SBCL/           Replicated experiments (SBCL, M4 Mac)
  Graph/                Data extraction and comparison plots
tests/                  FiveAM test suites
src/                    Entry point
Publications/           Thesis PDF
```

## ASDF Systems

| System | Directory | Description |
|--------|-----------|-------------|
| `:phd-research` | `csp/` | Base CSP solver with queens, ADT, MPR domains |
| `:qcsp3` | `qcsp3/` | Extended solver with memory-CSP and Quilici search |
| `:qcsp-may29-1996` | `qcsp-may29-1996/` | Historical snapshot (May 1996) |
| `:qcsp-alex-sep16-1997` | `qcsp-alex-sep16-1997/` | Historical snapshot (Sep 1997) |

## Quick Start

Requires [SBCL](http://www.sbcl.org/) and [Quicklisp](https://www.quicklisp.org/).

```bash
# Interactive REPL
sbcl --load "src/main.lisp"

# Run tests (requires FiveAM via Quicklisp)
sbcl --non-interactive --load "tests/run.lisp"

# Try it
# (qc 4)              ;; 4-Queens
# (qc 8)              ;; 8-Queens
# (adt)               ;; ADT pattern recognition
# (memory-search)     ;; Two-phase memory-based search
```

## Experiments

Three experiment series evaluate CSP search efficiency under increasing noise (50-1000 extraneous program statements):

| Series | Method | Description |
|--------|--------|-------------|
| ij2 | `memory-search` | Baseline: BT + FC/DR with advance sort |
| ij3 | `memory-search` | Both phases with FC/DR and advance sort |
| ij4 | `adt` (direct) | Direct matching with FC/DR and advance sort |

Each series: 20 noise levels x 10 random seeds = 200 runs.

### Running experiments

```bash
bash Q-Batch-SBCL/ij2.sh    # ~2 minutes
bash Q-Batch-SBCL/ij3.sh    # ~2 minutes
bash Q-Batch-SBCL/ij4.sh    # ~10 seconds
```

### Extracting data and generating plots

```bash
python3 Q-Batch-SBCL/Graph/extract-data.py       # Extract CIs from outputs
python3 Q-Batch-SBCL/Graph/compare-plots.py      # Generate comparison PDFs (requires matplotlib)
gnuplot Q-Batch-SBCL/Graph/compare-all.gp        # Or use gnuplot
```

### Results

The SBCL results on M4 Mac statistically match the original Allegro CL results on SPARC, confirming the algorithmic correctness of the port. Key finding: direct CSP matching (ij4) is 10-100x more efficient than the two-phase memory approach (ij2) in constraint checks, but the memory approach provides adaptability benefits not captured by this metric.

## License

Academic research code. See `Publications/` for the thesis.
