# Pattern, meaning, and verified proposals

These eight newly authored examples implement a bounded slice of E3/E5 from the
research plan. They are not recovered thesis/Y2K source or measured neural output.

```sh
python3 experiments/constraint-search/demos/leap_year.py
python3 experiments/constraint-search/demos/render.py /tmp/leap-year.html
sbcl --non-interactive --load tests/constraint-search-suite.lisp
```

The HTML is self-contained, offline and interactive. No external fonts, libraries,
model calls, credential lookup or telemetry are used. Its downloadable evidence
includes exact input and semantic-checker source hashes.

The initial browser inspection was blocked by the browser's local-file URL
policy. Do not treat source/data validation as completed visual or interaction QA;
that preview check remains open. No alternate browser or proxy was used to bypass
the restriction.

## Three different questions

1. **Recognition:** a deliberately tiny structural matcher, allowing commuted
   Boolean operands, identifies known plan shapes. It can miss a factored but
   equivalent program. This is a pedagogical baseline, not QCSP3 running on C.
2. **Correctness:** an independent Gregorian specification checks all 400 residues.
   The language admits only divisibility by 4/100/400 and Boolean composition.
   Each atom is 400-periodic; induction over the expression gives a complete
   equivalence check for mathematical integer years. Arbitrary C parsing, finite
   integer overflow and calendar adoption are outside scope.
3. **Translation:** a scripted proposer always returns the correct Gregorian tree.
   That proposal solves the wrong problem when the source is buggy. Equivalence
   with the original DSL is checked separately from the proposal's correctness.

The misleading identifier `leap_year_trust_me`, missing-century correction,
swapped dependency, unknown plan, renaming, reordering, factoring and tautological
clause exercise these distinctions. Century probes include 1900/2000/2100/2400.
Malformed/unsupported DSLs are rejected rather than evaluated as arbitrary code.

## What is still an experiment, not a result

No model training, neural inference or LLM quality claim is included. The proposal
checker is ready for recorded model output, but provider/model choice, a spending
ceiling and the exact sendable dataset need approval before external calls.

For learned candidate ranking, first author at least three genuinely different
program-plan families. Keep all variants of a base family in one split, train a
small ranker only on training traces, and freeze it before the held-out evaluation.
Compare random, handcrafted, learned and deliberately poor orders. Retain every
candidate and exact fallback; report feature/training/inference/checking cost
separately. The current noise seeds are not independent families and must not be
split across train and test to manufacture generalization.

Then compare direct model proposals with checked proposals and exact fallback.
Keep invalid translations, abstentions, UNKNOWNs, costs and counterexamples in the
denominator. Treat ranking as guidance, not sound pruning, and retrieval as
candidate generation, not a correctness certificate.
