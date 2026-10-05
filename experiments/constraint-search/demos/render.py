"""Build a self-contained offline explanation from the verified DSL report."""
import argparse
import json
from pathlib import Path
from leap_year import build_report

TEMPLATE = '''<!doctype html>
<html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Pattern / Meaning / Proof</title>
<style>
:root{--ink:#142e3b;--paper:#f4efe3;--amber:#e7ad38;--green:#236650;--red:#a13d2a}
*{box-sizing:border-box}body{margin:0;color:var(--ink);background:radial-gradient(ellipse at 90% 0,#ecd7a6,transparent 48%),var(--paper);font:17px Georgia,serif;line-height:1.5}
main{max-width:1200px;margin:auto;padding:48px 5vw}header{border-bottom:3px solid var(--ink);padding-bottom:24px}.eyebrow{font:12px monospace;letter-spacing:2px;text-transform:uppercase}
h1{font-size:clamp(42px,7vw,84px);letter-spacing:-3px;line-height:1.02;margin:18px 0}h2{font-size:26px;margin:0 0 12px}p{max-width:80ch}.intro{font-size:21px;max-width:63ch}
select{padding:12px;width:100%;font:16px monospace;background:var(--paper);border:1px solid var(--ink);color:var(--ink)}label{display:block;margin:26px 0 8px;font-weight:bold}
.cards{display:grid;grid-template-columns:repeat(3,1fr);gap:18px;margin:24px 0}.card{border-top:6px solid var(--amber);padding:20px;background:#fffaf0;box-shadow:0 3px 12px #142e3b0a}
.n{font:12px monospace;letter-spacing:2px;margin-bottom:12px}.answer{font-size:22px;font-weight:bold}.pass{color:var(--green)}.fail{color:var(--red)}pre{padding:20px;background:var(--ink);color:var(--paper);overflow:auto;font-size:14px;white-space:pre-wrap;word-break:break-word}
.grid{display:grid;grid-template-columns:repeat(40,1fr);gap:3px;margin:20px 0}.year{aspect-ratio:1;background:#ddd4c2}.year.leap{background:var(--green)}.year.wrong{background:var(--red);outline:1px solid var(--red)}
.legend{font:13px monospace}.notice{border-left:6px solid var(--amber);padding:12px 20px;background:#ebdfc5}footer{border-top:1px solid;margin-top:32px;padding-top:18px;font-size:14px}button{padding:10px 18px;background:var(--ink);color:var(--paper);border:0;cursor:pointer;font:15px Georgia,serif}
@media(max-width:760px){main{padding:28px 20px}.cards{grid-template-columns:1fr}.grid{grid-template-columns:repeat(20,1fr)}h1{letter-spacing:-1px}}@media(prefers-reduced-motion:no-preference){header{animation:arrive .6s ease-out}@keyframes arrive{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:none}}}
</style>
<main><header><div class="eyebrow">Constraint search laboratory / newly authored examples</div>
<h1>Pattern.<br>Meaning. Proof.</h1><p class="intro">A familiar-looking program is not necessarily correct. A correct proposed model is not necessarily a faithful translation.</p></header>
<label for="case">Choose a program</label><select id="case"></select><pre id="code"></pre>
<section class="cards" aria-live="polite">
<article class="card"><div class="n">01 / RECOGNITION</div><h2>Do I know this shape?</h2><p id="pattern" class="answer"></p><p>A tiny structural matcher permits operand reordering, but does not perform algebra. This is not the thesis's complete recognizer.</p></article>
<article class="card"><div class="n">02 / SEMANTICS</div><h2>Does it mean leap year?</h2><p id="semantic" class="answer"></p><p id="counter"></p><p>Independent Gregorian specification, checked over a complete 400-year residue cycle.</p></article>
<article class="card"><div class="n">03 / PROPOSAL CHECK</div><h2>Is the suggestion faithful?</h2><p id="proposal" class="answer"></p><p>The scripted proposer always returns the correct Gregorian model, even for buggy source. A checker must detect that change of meaning.</p></article>
</section>
<h2>Every residue, not just a few examples</h2><p id="probes"></p><div id="years" class="grid" aria-label="Year-by-year semantic check, 2000 through 2399"></div>
<p class="legend">Green: correct leap year. Sand: correct common year. Red: disagreement. Hover a cell for its year.</p>
<div class="notice"><strong>Scope is the guarantee.</strong> These inputs are Boolean combinations of divisibility by 4, 100 and 400. Each atom repeats every 400 years, and Boolean composition preserves that period. The result covers mathematical integer years in this restricted language, not arbitrary C, overflow, side effects, or historical calendar adoption.</div>
<footer><p><strong>No neural model ran.</strong> Proposals here are scripted interface tests. Learned ranking and LLM-generated translations remain separate experiments with held-out families, model provenance and explicit cost limits.</p><p>Historical Memory-CSP retrieves candidates symbolically, then completes exact matching. A learned ranker can change which candidate is tried first; it must retain exhaustive fallback to preserve completeness. A model that removes candidates or constraints needs additional justification.</p><button id="download">Download evidence JSON</button><p>Offline artifact. Input/source hashes and bounded proof scope are embedded in the evidence.</p></footer></main>
<script id="evidence" type="application/json">__REPORT__</script>
<script>
const report=JSON.parse(document.getElementById('evidence').textContent), sel=document.getElementById('case');
report.cases.forEach((c,i)=>{const o=document.createElement('option');o.value=i;o.textContent=c.id.replaceAll('_',' ');sel.append(o)});
function text(id,value){document.getElementById(id).textContent=value}
function verdict(id,ok,yes,no){const e=document.getElementById(id);e.textContent=ok?yes:no;e.className='answer '+(ok?'pass':'fail')}
function show(){const c=report.cases[Number(sel.value)];text('code',c.code);text('pattern',c.structural_plans.join(', ')||'None of the known plans');verdict('semantic',c.semantically_gregorian,'Equivalent to Gregorian rule','Not equivalent');text('counter',c.counterexamples.length?'Counterexample years: '+c.counterexamples.join(', '):'No counterexample in the complete cycle.');verdict('proposal',c.scripted_reference_proposal.translation_equivalent,'Translation accepted','Translation rejected');text('probes',Object.entries(c.century_probes).map(([y,v])=>y+': '+(v.actual?'leap':'common')+(v.actual===v.expected?' (correct)':' (wrong)')).join(' / '));const grid=document.getElementById('years');grid.replaceChildren();c.cycle_signature.forEach((leap,i)=>{const y=2000+i,e=document.createElement('div'),wrong=c.counterexamples.includes(y);e.className='year'+(leap?' leap':'')+(wrong?' wrong':'');e.title=y+': '+(leap?'leap':'common')+(wrong?' / wrong':' / correct');grid.append(e)})}
sel.addEventListener('change',show);show();
document.getElementById('download').addEventListener('click',()=>{const u=URL.createObjectURL(new Blob([JSON.stringify(report,null,2)],{type:'application/json'}));const a=document.createElement('a');a.href=u;a.download='leap-year-evidence.json';a.click();setTimeout(()=>URL.revokeObjectURL(u),1000)});
</script></html>'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    report = build_report()
    data = json.dumps(report, sort_keys=True).replace("<", "\\u003c").replace(">", "\\u003e")
    args.output.write_text(TEMPLATE.replace("__REPORT__", data))


if __name__ == "__main__":
    main()
