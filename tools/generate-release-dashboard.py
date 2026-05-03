#!/usr/bin/env python3
"""Generate the visual release dashboard from structured source data."""

from __future__ import annotations

import json
import os
import shutil
import subprocess
from html import escape
from pathlib import Path

from generate_project_handbook import generate_handbook_outputs


ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = ROOT / "docs" / "release-dashboard-data.json"
DASHBOARD_OUTPUT_PATH = ROOT / "docs" / "release-dashboard.html"
PUBLIC_PAGE_OUTPUT_PATH = ROOT / "docs" / "public-phd-renovation.html"
PUBLIC_STATUS_OUTPUT_PATH = ROOT / "docs" / "public-status-phd-renovation.json"
THESIS_SOURCE_PDF_PATH = (
    ROOT
    / "data"
    / "thesis"
    / "Woods PHD CS-96-33 A Method of Program Understanding using Constraint Satisfaction.pdf"
)
THESIS_OUTPUT_PDF_PATH = ROOT / "docs" / "phd-renovation-thesis.pdf"
THESIS_OUTPUT_PS_PATH = ROOT / "docs" / "phd-renovation-thesis.ps"
DEFAULT_PUBLIC_SITE_DIR = Path.home() / "GitPages" / "public"
PUBLIC_SITE_DIR = Path(
    os.environ.get("PHD_PUBLIC_SITE_DIR", str(DEFAULT_PUBLIC_SITE_DIR))
).expanduser()
PUBLIC_SITE_DASHBOARD_PATH = PUBLIC_SITE_DIR / "phd-renovation-dashboard.html"
PUBLIC_SITE_PAGE_PATH = PUBLIC_SITE_DIR / "phd-renovation.html"
PUBLIC_SITE_STATUS_PATH = PUBLIC_SITE_DIR / "data" / "projects" / "phd-renovation.json"
PUBLIC_SITE_THESIS_PDF_PATH = PUBLIC_SITE_DIR / THESIS_OUTPUT_PDF_PATH.name
PUBLIC_SITE_THESIS_PS_PATH = PUBLIC_SITE_DIR / THESIS_OUTPUT_PS_PATH.name

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
    .heroTop{
      display:flex;
      align-items:flex-start;
      justify-content:space-between;
      gap:16px;
      margin-bottom:18px;
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
    .heroParentLink{
      display:inline-flex;
      align-items:center;
      justify-content:center;
      padding:16px 28px;
      border-radius:999px;
      background:rgba(255,255,255,0.08);
      border:1px solid rgba(255,255,255,0.12);
      color:#d7ecff;
      text-decoration:none;
      font-size:13px;
      letter-spacing:.12em;
      text-transform:uppercase;
      white-space:nowrap;
      box-shadow:inset 0 0 0 1px rgba(177,222,255,0.06);
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
      min-width:0;
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
      line-height:1.25;
      overflow-wrap:anywhere;
      word-break:break-word;
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
      .heroTop{flex-direction:column;align-items:flex-start}
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


def render_public_cards(items: list[dict[str, str]]) -> str:
    blocks = []
    for item in items:
        blocks.append(
            f"""                <article class="card">
                    <h3>{escape(item["title"])}</h3>
                    <p>{escape(item["summary"])}</p>
                </article>"""
        )
    return "\n".join(blocks)


def render_public_links(items: list[dict[str, str]]) -> str:
    blocks = []
    for item in items:
        blocks.append(
            f"""                <a class="button" href="{escape(item["href"], quote=True)}">{escape(item["label"])}</a>"""
        )
    return "\n".join(blocks)


def build_public_status_manifest(data: dict[str, object]) -> str:
    public_status = data["public_status"]
    metrics = data["metrics"]
    manifest = {
        "schema_version": public_status["schema_version"],
        "project_id": public_status["project_id"],
        "active": public_status["active"],
        "display_name": public_status["display_name"],
        "project_page_path": public_status["project_page_path"],
        "repo_url": public_status["repo_url"],
        "dashboard_url": public_status["dashboard_url"],
        "experience_url": public_status["experience_url"],
        "repo_pushed_at": public_status["repo_pushed_at"],
        "status_generated_at": public_status["status_generated_at"],
        "status_label": public_status["status_label"],
        "status_value": metrics[2]["value"],
        "focus_label": public_status["focus_label"],
        "focus_value": metrics[1]["value"],
    }
    return json.dumps(manifest, indent=2, ensure_ascii=False) + "\n"


def build_page(
    data: dict[str, object],
    footer_html: str,
    *,
    parent_href: str,
    parent_label: str,
) -> str:
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
        <div class="heroTop">
          <span class="eyebrow">{escape(data["eyebrow"])}</span>
          <a class="heroParentLink" href="{escape(parent_href, quote=True)}">{escape(parent_label)}</a>
        </div>
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
        <p class="footer">{footer_html}</p>
      </section>
  </main>
</body>
</html>
"""


def build_public_page(data: dict[str, object]) -> str:
    public = data["public_page"]
    metrics = data["metrics"]
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{escape(public["browser_title"])}</title>
    <style>
        :root {{
            --bg: #07131f;
            --bg2: #10253b;
            --card: rgba(7, 19, 31, 0.72);
            --line: rgba(135, 197, 255, 0.24);
            --text: #eff7ff;
            --muted: #9cc4df;
            --shadow: 0 18px 40px rgba(0, 0, 0, 0.28);
        }}

        * {{
            box-sizing: border-box;
        }}

        body {{
            margin: 0;
            color: var(--text);
            font-family: "Avenir Next", "Segoe UI", sans-serif;
            background:
                radial-gradient(circle at top left, rgba(103, 230, 168, 0.18), transparent 26%),
                radial-gradient(circle at top right, rgba(121, 184, 255, 0.22), transparent 32%),
                linear-gradient(160deg, var(--bg), var(--bg2));
            min-height: 100vh;
        }}

        a {{
            color: #d9f7ff;
        }}

        .shell {{
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 20px 72px;
        }}

        .hero,
        .panel {{
            border: 1px solid rgba(177, 222, 255, 0.18);
            border-radius: 28px;
            background:
                linear-gradient(160deg, rgba(12, 34, 54, 0.88), rgba(7, 19, 31, 0.72)),
                radial-gradient(circle at 20% 0%, rgba(103, 230, 168, 0.14), transparent 32%);
            box-shadow: var(--shadow);
        }}

        .hero {{
            position: relative;
            padding: 36px 34px 32px;
        }}

        .heroTop {{
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 18px;
        }}

        .eyebrow {{
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 16px 24px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.08);
            color: #d7ecff;
            font-size: 13px;
            letter-spacing: .16em;
            text-transform: uppercase;
        }}

        .heroHomeLink {{
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 16px 28px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.12);
            color: #d7ecff;
            text-decoration: none;
            font-size: 13px;
            letter-spacing: .12em;
            text-transform: uppercase;
            white-space: nowrap;
            box-shadow: inset 0 0 0 1px rgba(177, 222, 255, 0.06);
        }}

        h1 {{
            margin: 18px 0 10px;
            font-size: clamp(34px, 5vw, 58px);
            line-height: .95;
            letter-spacing: -0.04em;
        }}

        .hero p,
        .panel p {{
            color: var(--muted);
            line-height: 1.6;
        }}

        .hero p {{
            max-width: 760px;
            font-size: 18px;
        }}

        .meta {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 14px;
            margin-top: 28px;
        }}

        .metaCard {{
            padding: 16px 18px;
            min-width: 0;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }}

        .metaLabel {{
            display: block;
            color: #8fb3cc;
            font-size: 12px;
            letter-spacing: .12em;
            text-transform: uppercase;
            margin-bottom: 6px;
        }}

        .metaValue {{
            font-size: 18px;
            font-weight: 600;
            line-height: 1.25;
            overflow-wrap: anywhere;
            word-break: break-word;
        }}

        .metaNote {{
            margin-top: 8px;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.5;
        }}

        .panel {{
            margin-top: 22px;
            padding: 28px;
            background: rgba(7, 19, 31, 0.68);
        }}

        .panel h2 {{
            margin: 0 0 12px;
            font-size: 24px;
            letter-spacing: -0.02em;
        }}

        .grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 16px;
        }}

        .card {{
            padding: 18px 18px 16px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }}

        .card h3 {{
            margin: 0 0 8px;
            font-size: 18px;
        }}

        .links {{
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 18px;
        }}

        .button {{
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 11px 16px;
            border-radius: 999px;
            background: rgba(121, 184, 255, 0.18);
            border: 1px solid rgba(121, 184, 255, 0.28);
            color: #eff7ff;
            text-decoration: none;
            font-size: 14px;
            letter-spacing: 0.04em;
        }}

        .footer {{
            margin-top: 18px;
            color: #8db0c8;
            font-size: 13px;
            line-height: 1.6;
        }}

        @media (max-width: 720px) {{
            .shell {{
                padding: 20px 14px 54px;
            }}

            .hero,
            .panel {{
                padding: 24px 22px;
            }}

            .heroTop {{
                flex-direction: column;
                align-items: flex-start;
            }}
        }}
    </style>
</head>
<body>
    <!-- Generated by tools/generate-release-dashboard.py from docs/release-dashboard-data.json -->
    <main class="shell">
        <section class="hero">
            <div class="heroTop">
                <span class="eyebrow">{escape(public["eyebrow"])}</span>
                <a class="heroHomeLink" href="https://sgwoods.github.io/public">Steven Woods</a>
            </div>
            <h1>{escape(public["title"])}</h1>
            <p>{escape(public["summary"])}</p>
            <div class="meta">
                <div class="metaCard">
                    <span class="metaLabel">{escape(metrics[0]["label"])}</span>
                    <span class="metaValue">{escape(metrics[0]["value"])}</span>
                    <div class="metaNote">{escape(metrics[0]["note"])}</div>
                </div>
                <div class="metaCard">
                    <span class="metaLabel">{escape(metrics[2]["label"])}</span>
                    <span class="metaValue">{escape(metrics[2]["value"])}</span>
                    <div class="metaNote">{escape(metrics[2]["note"])}</div>
                </div>
                <div class="metaCard">
                    <span class="metaLabel">{escape(metrics[1]["label"])}</span>
                    <span class="metaValue">{escape(metrics[1]["value"])}</span>
                    <div class="metaNote">{escape(metrics[1]["note"])}</div>
                </div>
                <div class="metaCard">
                    <span class="metaLabel">{escape(metrics[3]["label"])}</span>
                    <span class="metaValue">{escape(metrics[3]["value"])}</span>
                    <div class="metaNote">{escape(metrics[3]["note"])}</div>
                </div>
            </div>
            <div class="links">
{render_public_links(public["links"][:2])}
            </div>
        </section>

        <section class="panel">
            <h2>Current state</h2>
            <div class="grid">
{render_public_cards(public["cards"])}
            </div>
        </section>

        <section class="panel">
            <h2>Where to look</h2>
            <div class="links">
{render_public_links(public["links"])}
            </div>
            <p class="footer">{escape(public["footer"])}</p>
        </section>
    </main>
</body>
</html>
"""


def sync_binary_file(source_path: Path, output_path: Path) -> None:
    output_path.parent.mkdir(parents=True, exist_ok=True)
    if output_path.exists() and source_path.read_bytes() == output_path.read_bytes():
        return
    shutil.copyfile(source_path, output_path)


def generate_postscript_from_pdf(pdf_path: Path, ps_path: Path) -> None:
    ps_path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = ps_path.with_suffix(ps_path.suffix + ".tmp")
    try:
        subprocess.run(
            [
                "gs",
                "-q",
                "-dNOPAUSE",
                "-dBATCH",
                "-sDEVICE=ps2write",
                f"-sOutputFile={tmp_path}",
                str(pdf_path),
            ],
            check=True,
        )
    except FileNotFoundError as exc:
        raise RuntimeError("Ghostscript (gs) is required to generate the thesis PostScript.") from exc

    if ps_path.exists() and tmp_path.read_bytes() == ps_path.read_bytes():
        tmp_path.unlink()
        return
    tmp_path.replace(ps_path)


def sync_thesis_assets() -> None:
    if not THESIS_SOURCE_PDF_PATH.exists():
        raise FileNotFoundError(
            f"Canonical thesis PDF is missing: {THESIS_SOURCE_PDF_PATH}"
        )

    sync_binary_file(THESIS_SOURCE_PDF_PATH, THESIS_OUTPUT_PDF_PATH)
    generate_postscript_from_pdf(THESIS_SOURCE_PDF_PATH, THESIS_OUTPUT_PS_PATH)

    if PUBLIC_SITE_DIR.exists():
        try:
            sync_binary_file(THESIS_OUTPUT_PDF_PATH, PUBLIC_SITE_THESIS_PDF_PATH)
            sync_binary_file(THESIS_OUTPUT_PS_PATH, PUBLIC_SITE_THESIS_PS_PATH)
        except PermissionError:
            # CI and sandboxed runs still validate the repo-local outputs.
            pass


def main() -> None:
    data = json.loads(DATA_PATH.read_text(encoding="utf-8"))
    sync_thesis_assets()
    dashboard_html = build_page(
        data,
        data["footer_html"],
        parent_href="../README.md",
        parent_label="PhD Renovation",
    )
    public_dashboard_html = build_page(
        data,
        data["public_footer_html"],
        parent_href="phd-renovation.html",
        parent_label="PhD Renovation",
    )
    public_page_html = build_public_page(data)
    public_status_manifest = build_public_status_manifest(data)
    generate_handbook_outputs(data)
    DASHBOARD_OUTPUT_PATH.write_text(dashboard_html, encoding="utf-8")
    PUBLIC_PAGE_OUTPUT_PATH.write_text(public_page_html, encoding="utf-8")
    PUBLIC_STATUS_OUTPUT_PATH.write_text(public_status_manifest, encoding="utf-8")
    if PUBLIC_SITE_DIR.exists():
        try:
            PUBLIC_SITE_DASHBOARD_PATH.write_text(public_dashboard_html, encoding="utf-8")
            PUBLIC_SITE_PAGE_PATH.write_text(public_page_html, encoding="utf-8")
            PUBLIC_SITE_STATUS_PATH.parent.mkdir(parents=True, exist_ok=True)
            PUBLIC_SITE_STATUS_PATH.write_text(public_status_manifest, encoding="utf-8")
        except PermissionError:
            # CI and sandboxed runs still validate the repo-local outputs.
            pass


if __name__ == "__main__":
    main()
