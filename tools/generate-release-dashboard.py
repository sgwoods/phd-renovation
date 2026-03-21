#!/usr/bin/env python3
"""Generate the visual release dashboard from structured source data."""

from __future__ import annotations

import json
from html import escape
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = ROOT / "docs" / "release-dashboard-data.json"
OUTPUT_PATH = ROOT / "docs" / "release-dashboard.html"

STATUS_CLASS = {
    "done": "done",
    "active": "in_progress",
    "pending": "up_next",
}


CSS = """
:root{
      --bg:#07131f;
      --bg2:#10253b;
      --card:rgba(7,19,31,0.72);
      --line:rgba(135,197,255,0.26);
      --text:#eff7ff;
      --muted:#9cc4df;
      --done:#67e6a8;
      --doing:#ffd66b;
      --next:#79b8ff;
      --shadow:0 18px 40px rgba(0,0,0,0.28);
    }
    *{box-sizing:border-box}
    body{
      margin:0;
      color:var(--text);
      font-family:"Avenir Next","Segoe UI",sans-serif;
      background:
        radial-gradient(circle at top left, rgba(103,230,168,0.18), transparent 26%),
        radial-gradient(circle at top right, rgba(121,184,255,0.22), transparent 32%),
        linear-gradient(160deg, var(--bg), var(--bg2));
      min-height:100vh;
    }
    a{color:#d9f7ff}
    .shell{
      max-width:1100px;
      margin:0 auto;
      padding:40px 20px 72px;
    }
    .hero{
      position:relative;
      overflow:hidden;
      padding:36px 34px 32px;
      border:1px solid rgba(177,222,255,0.18);
      border-radius:28px;
      background:
        linear-gradient(160deg, rgba(12,34,54,0.88), rgba(7,19,31,0.72)),
        radial-gradient(circle at 20% 0%, rgba(103,230,168,0.14), transparent 32%);
      box-shadow:var(--shadow);
    }
    .eyebrow{
      display:inline-flex;
      align-items:center;
      gap:10px;
      padding:7px 12px;
      border-radius:999px;
      background:rgba(255,255,255,0.08);
      color:#d7ecff;
      font-size:12px;
      letter-spacing:.14em;
      text-transform:uppercase;
    }
    h1{
      margin:18px 0 10px;
      font-size:clamp(34px,5vw,58px);
      line-height:.95;
      letter-spacing:-0.04em;
    }
    .hero p{
      max-width:760px;
      font-size:18px;
      line-height:1.6;
      color:var(--muted);
    }
    .meta{
      display:grid;
      grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
      gap:14px;
      margin-top:28px;
    }
    .metaCard{
      padding:16px 18px;
      border-radius:18px;
      background:rgba(255,255,255,0.05);
      border:1px solid rgba(255,255,255,0.08);
    }
    .metaLabel{
      display:block;
      color:#8fb3cc;
      font-size:12px;
      letter-spacing:.12em;
      text-transform:uppercase;
      margin-bottom:6px;
    }
    .metaValue{
      font-size:18px;
      font-weight:600;
    }
    .metaNote{
      margin-top:8px;
      color:var(--muted);
      font-size:13px;
      line-height:1.5;
    }
    .sectionLead{
      margin:26px 4px 0;
      color:#cce4f6;
      font-size:14px;
      line-height:1.6;
      letter-spacing:.04em;
      text-transform:uppercase;
    }
    .timeline{
      position:relative;
      margin:28px 0 34px;
      display:grid;
      gap:18px;
    }
    .timeline::before{
      content:"";
      position:absolute;
      left:18px;
      top:16px;
      bottom:16px;
      width:2px;
      background:linear-gradient(to bottom, rgba(103,230,168,0.7), rgba(121,184,255,0.22));
    }
    .step{
      position:relative;
      margin-left:44px;
      padding:18px 20px 18px 22px;
      border-radius:20px;
      border:1px solid rgba(255,255,255,0.08);
      background:var(--card);
      box-shadow:var(--shadow);
    }
    .step::before{
      content:"";
      position:absolute;
      left:-36px;
      top:24px;
      width:18px;
      height:18px;
      border-radius:50%;
      border:3px solid currentColor;
      background:#091520;
      box-shadow:0 0 0 7px rgba(9,21,32,0.95);
    }
    .step.done{color:var(--done)}
    .step.in_progress{color:var(--doing)}
    .step.up_next{color:var(--next)}
    .stepHeader{
      display:flex;
      justify-content:space-between;
      gap:16px;
      align-items:flex-start;
      margin-bottom:8px;
    }
    .stepTitle{
      margin:0;
      color:var(--text);
      font-size:22px;
      line-height:1.1;
    }
    .stepMeta{
      margin-bottom:8px;
      color:#8fb3cc;
      font-size:12px;
      letter-spacing:.14em;
      text-transform:uppercase;
    }
    .badge{
      flex:0 0 auto;
      padding:7px 11px;
      border-radius:999px;
      font-size:11px;
      letter-spacing:.14em;
      text-transform:uppercase;
      background:rgba(255,255,255,0.08);
      color:inherit;
    }
    .step p{
      margin:0;
      color:var(--muted);
      line-height:1.55;
    }
    .supportGrid{
      display:grid;
      grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
      gap:14px;
      margin-top:6px;
    }
    .supportCard{
      padding:18px 18px 16px;
      border-radius:20px;
      background:rgba(255,255,255,0.05);
      border:1px solid rgba(255,255,255,0.08);
      box-shadow:var(--shadow);
    }
    .supportCard h2{
      margin:8px 0 8px;
      font-size:20px;
      letter-spacing:-0.02em;
    }
    .supportCard p{
      margin:0;
      color:var(--muted);
      line-height:1.55;
    }
    .legend{
      margin-top:42px;
      padding:28px 28px 18px;
      border-radius:24px;
      background:rgba(255,255,255,0.05);
      border:1px solid rgba(255,255,255,0.08);
      box-shadow:var(--shadow);
    }
    .legend h2{
      margin:0 0 16px;
      font-size:22px;
      letter-spacing:-0.02em;
    }
    .legendGrid{
      display:grid;
      grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
      gap:14px;
    }
    .legendItem{
      padding:14px 16px;
      border-radius:16px;
      background:rgba(7,19,31,0.52);
      border:1px solid rgba(255,255,255,0.06);
    }
    .legendItem strong{
      display:block;
      margin-bottom:6px;
      font-size:14px;
      letter-spacing:.08em;
      text-transform:uppercase;
      color:#dbf3ff;
    }
    .legendItem span{
      color:var(--muted);
      line-height:1.5;
      font-size:14px;
    }
    .footer{
      margin-top:22px;
      font-size:13px;
      color:#8db0c8;
      line-height:1.6;
    }
    @media (max-width: 720px){
      .shell{padding:20px 14px 54px}
      .hero{padding:26px 22px 24px}
      .step{margin-left:34px}
      .timeline::before{left:12px}
      .step::before{left:-28px}
      .stepHeader{flex-direction:column}
    }
"""


def render_metrics(items: list[dict[str, str]]) -> str:
    blocks = []
    for item in items:
        blocks.append(
            f"""          <div class="metaCard">
            <span class="metaLabel">{escape(item["label"])}</span>
            <span class="metaValue">{escape(item["value"])}</span>
            <div class="metaNote">{escape(item["note"])}</div>
          </div>"""
        )
    return "\n".join(blocks)


def render_timeline(items: list[dict[str, str]]) -> str:
    blocks = []
    for item in items:
        status = STATUS_CLASS[item["status"]]
        blocks.append(
            f"""    <article class="step {status}">
      <div class="stepMeta">{escape(item["phase"])}</div>
      <div class="stepHeader">
        <h2 class="stepTitle">{escape(item["title"])}</h2>
        <span class="badge">{escape(item["status_label"])}</span>
      </div>
      <p>{escape(item["summary"])}</p>
    </article>"""
        )
    return "\n\n".join(blocks)


def render_support(items: list[dict[str, str]]) -> str:
    blocks = []
    for item in items:
        blocks.append(
            f"""      <article class="supportCard">
        <span class="eyebrow">{escape(item["label"])}</span>
        <h2>{escape(item["title"])}</h2>
        <p>{escape(item["summary"])}</p>
      </article>"""
        )
    return "\n".join(blocks)


def render_legend(items: list[dict[str, str]]) -> str:
    blocks = []
    for item in items:
        blocks.append(
            f"""        <article class="legendItem">
          <strong>{escape(item["title"])}</strong>
          <span>{escape(item["summary"])}</span>
        </article>"""
        )
    return "\n".join(blocks)


def build_page(data: dict[str, object]) -> str:
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{escape(data["title"])}</title>
  <style>
{CSS}
  </style>
</head>
<body>
  <!-- Generated by tools/generate-release-dashboard.py from docs/release-dashboard-data.json -->
  <main class="shell">
      <section class="hero">
        <span class="eyebrow">{escape(data["eyebrow"])}</span>
        <h1>{escape(data["headline"])}</h1>
        <p>{escape(data["summary"])}</p>
        <div class="meta">
{render_metrics(data["metrics"])}
        </div>
      </section>
      <p class="sectionLead">{escape(data["timeline_note"])}</p>
      <section class="timeline">
{render_timeline(data["timeline"])}
      </section>
      <section class="supportGrid">
{render_support(data["parallel_cards"])}
      </section>
      <section class="legend">
        <h2>Legend</h2>
        <div class="legendGrid">
{render_legend(data["legend"])}
        </div>
        <p class="footer">{data["footer_html"]}</p>
      </section>
  </main>
</body>
</html>
"""


def main() -> None:
    data = json.loads(DATA_PATH.read_text(encoding="utf-8"))
    html = build_page(data)
    OUTPUT_PATH.write_text(html, encoding="utf-8")


if __name__ == "__main__":
    main()
