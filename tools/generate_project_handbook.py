#!/usr/bin/env python3
"""Generate the full project handbook from the repo's source documents."""

from __future__ import annotations

import json
import os
import re
from dataclasses import dataclass
from html import escape
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DOCS_DIR = ROOT / "docs"
DATA_PATH = DOCS_DIR / "release-dashboard-data.json"
HANDBOOK_OUTPUT_PATH = DOCS_DIR / "project-handbook.html"
PUBLIC_HANDBOOK_OUTPUT_PATH = DOCS_DIR / "public-phd-renovation-handbook.html"
DEFAULT_PUBLIC_SITE_DIR = Path.home() / "GitPages" / "public"
PUBLIC_SITE_DIR = Path(
    os.environ.get("PHD_PUBLIC_SITE_DIR", str(DEFAULT_PUBLIC_SITE_DIR))
).expanduser()
PUBLIC_SITE_HANDBOOK_PATH = PUBLIC_SITE_DIR / "phd-renovation-handbook.html"
PUBLIC_REPO_BASE = "https://github.com/sgwoods/phd-renovation/blob/main/"


@dataclass(frozen=True)
class HandbookSource:
    title: str
    path: str
    summary: str
    include_in_quick_index: bool = True


HANDBOOK_SOURCES = [
    HandbookSource(
        "Project Overview",
        "README.md",
        "High-level purpose, structure, supported workflows, and active experiment story.",
    ),
    HandbookSource(
        "Repository Status",
        "REPOSITORY-STATUS.md",
        "Repo-wide answer to what is indexed, integrated, automated, and publication-validated.",
    ),
    HandbookSource(
        "Work Area Status",
        "WORK-AREA-STATUS.md",
        "Quick map of what is current, reference, archive-only, or deprecated for day-to-day mainline use.",
    ),
    HandbookSource(
        "Recovery And Reproducibility",
        "RECOVERY-AND-REPRODUCIBILITY.md",
        "Explicit audit of branch reality, checked-in versus ignored artifacts, and new-machine recovery confidence.",
    ),
    HandbookSource(
        "Repository Inventory Audit",
        "REPO-INVENTORY-AUDIT.md",
        "Current tracked-vs-external inventory plus the deepest current portability assessment.",
    ),
    HandbookSource(
        "New Mac Handoff",
        "NEW-MAC-HANDOFF.md",
        "Shortest practical guide for standing the project up on a different Mac and retiring the current machine safely.",
    ),
    HandbookSource(
        "Machine Deprecation Checklist",
        "MACHINE-DEPRECATION-CHECKLIST.md",
        "Practical gate for moving day-to-day work to the iCloud-backed clone and treating the current MacBook as secondary.",
    ),
    HandbookSource(
        "Intake Roadmap",
        "INTAKE-ROADMAP.md",
        "Operational plan for post-1.0 ingestion, de-duplication, categorization, and promotion of newly found material.",
    ),
    HandbookSource(
        "Preservation Policy",
        "PRESERVATION-POLICY.md",
        "Standing rule that potentially useful code, data, publications, notes, and archive finds should be classified and preserved rather than discarded.",
    ),
    HandbookSource(
        "Validation Matrix",
        "VALIDATION-MATRIX.md",
        "Current historical domain and result-family coverage against the project's main goals.",
    ),
    HandbookSource(
        "1.0 Release Checklist",
        "RELEASE-1.0-CHECKLIST.md",
        "Concrete release-hardening gate for the first 1.0 tag.",
    ),
    HandbookSource(
        "1.0.0 Release Notes Draft",
        "RELEASE-1.0.0-NOTES.md",
        "Working draft of the first stable release notes.",
    ),
    HandbookSource(
        "Hanoi-4 Status",
        "HANOI-4-STATUS.md",
        "Bounded status record for the deferred Hanoi-4 lane: documented for 1.0, behaviorally unresolved for 2.0.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "M1 Readiness",
        "M1-READINESS.md",
        "Accepted first integration gate for the validated solver line.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Integration Deltas",
        "INTEGRATION-DELTAS.md",
        "Ledger of meaningful remaining differences between the integrated line and preserved snapshots.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Development Guide",
        "DEVELOPMENT.md",
        "Architecture, pitfalls, build commands, and day-to-day maintenance guidance.",
    ),
    HandbookSource(
        "qcsp3 Guide",
        "qcsp3/README.md",
        "Local guide to the primary integrated solver line, its entry points, and its AO support role.",
    ),
    HandbookSource(
        "csp ADT-Random Guide",
        "csp/ADT-Random/README.md",
        "Local guide to the earliest tracked solver root's direct-ADT seed workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "csp MPR-Random Guide",
        "csp/MPR-Random/README.md",
        "Local guide to the earliest tracked solver root's MPR seed workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "csp MPR-Situation Guide",
        "csp/MPR-Situation/README.md",
        "Local guide to the earliest tracked solver root's generated MPR situation workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "qcsp3 extras Guide",
        "qcsp3/extras/README.md",
        "Local guide to the bounded AO / test4 support layer that sits alongside the integrated solver line.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "qcsp3 ADT-Batch Guide",
        "qcsp3/ADT-Batch/README.md",
        "Local guide to the qcsp3 snapshot's direct-ADT batch-style workspace and how it differs from the canonical preserved archive.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "qcsp3 ADT-Random Guide",
        "qcsp3/ADT-Random/README.md",
        "Local guide to the maintained direct-ADT random-seed workspace and how it differs from preserved batch archives.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "qcsp3 ADT-Situation Guide",
        "qcsp3/ADT-Situation/README.md",
        "Local guide to the generated direct-ADT situation workspace used for maintained-line input state and bridge/debug analysis.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "qcsp3 MPR-Random Guide",
        "qcsp3/MPR-Random/README.md",
        "Local guide to the maintained MPR random-seed workspace and its role in reproducibility/debugging.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "qcsp3 MPR-Situation Guide",
        "qcsp3/MPR-Situation/README.md",
        "Local guide to the generated MPR situation workspace under the maintained solver line.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "May29 extras Guide",
        "qcsp-may29-1996/extras/README.md",
        "Local guide to the May29 snapshot's AO / test4 support layer and its role in the bounded AO baseline.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "May29 ADT-Random Guide",
        "qcsp-may29-1996/ADT-Random/README.md",
        "Local guide to the May29 snapshot's direct-ADT seed workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "May29 ADT-Situation Guide",
        "qcsp-may29-1996/ADT-Situation/README.md",
        "Local guide to the May29 snapshot's generated ADT situation workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "May29 ADT-SituationMar96 Guide",
        "qcsp-may29-1996/ADT-SituationMar96/README.md",
        "Local guide to the older preserved March 1996 ADT situation layer carried beside the May29 workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "May29 MPR-Random Guide",
        "qcsp-may29-1996/MPR-Random/README.md",
        "Local guide to the May29 snapshot's MPR seed workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "May29 MPR-Situation Guide",
        "qcsp-may29-1996/MPR-Situation/README.md",
        "Local guide to the May29 snapshot's generated MPR situation workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Alex MyBatch Guide",
        "qcsp-alex-sep16-1997/MyBatch/README.md",
        "Local guide to the Alex snapshot's preserved batch orchestration tree and why it remains provenance-only.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Alex Results Guide",
        "qcsp-alex-sep16-1997/testdata/Results/README.md",
        "Local guide to the main preserved Alex result-family tree.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Alex Results-Loop Guide",
        "qcsp-alex-sep16-1997/testdata/Results-Loop/README.md",
        "Local guide to the preserved loop-analysis result subtree inside the Alex snapshot.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Alex ADT-Random Guide",
        "qcsp-alex-sep16-1997/ADT-Random/README.md",
        "Local guide to the Alex snapshot's direct-ADT seed workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Alex ADT-Situation Guide",
        "qcsp-alex-sep16-1997/ADT-Situation/README.md",
        "Local guide to the Alex snapshot's direct-ADT situation workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Alex MPR-Random Guide",
        "qcsp-alex-sep16-1997/MPR-Random/README.md",
        "Local guide to the Alex snapshot's MPR seed workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Alex MPR-Situation Guide",
        "qcsp-alex-sep16-1997/MPR-Situation/README.md",
        "Local guide to the Alex snapshot's generated MPR situation workspace.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "src Guide",
        "src/README.md",
        "Interactive entry-point guide for loading the primary solver line in a REPL.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "tests Guide",
        "tests/README.md",
        "Authoritative validation-surface guide for the supported confidence gate.",
    ),
    HandbookSource(
        "Experiment Workspace Guide",
        "Q-Batch-SBCL/README.md",
        "How the modern experiment workspace, overlay plots, and generated run assets fit together.",
    ),
    HandbookSource(
        "Graph Workspace Guide",
        "Q-Batch-SBCL/Graph/README.md",
        "Local guide to the extracted CI tables, comparison scripts, and tracked overlay outputs.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "data Guide",
        "data/README.md",
        "Catalog of preserved datasets, baseline results, thesis artifacts, and archive holdings.",
    ),
    HandbookSource(
        "incoming Guide",
        "incoming/README.md",
        "How new finds enter the repo safely before review, promotion, or duplicate classification.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "incoming Review Template",
        "incoming/REVIEW-TEMPLATE.md",
        "Concrete first-pass checklist for reviewing and classifying each newly landed intake batch.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "incoming Landing Guide",
        "incoming/_landing/README.md",
        "Simple raw-drop handoff point for newly found material before Codex creates a proper intake batch.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Historical Finds Guide",
        "historical finds/README.md",
        "How reviewed archive/recovery material is separated from canonical data and the supported baseline.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Refine Guide",
        "historical finds/Refine/README.md",
        "Local guide to the archive-only Refine subtree and its likely context role.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Unravel Guide",
        "historical finds/Unravel/README.md",
        "Local guide to the recovered external Unravel tool distribution and why it remains context-only.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Unravel Changes Guide",
        "historical finds/Unravel-changes/README.md",
        "Local guide to the recovered Unravel-related notes subtree.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "ACL Baseline Guide",
        "data/acl-experiments/README.md",
        "How the preserved ACL experiment baseline feeds the supported thesis-result validation path.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Thesis Guide",
        "data/thesis/README.md",
        "How the thesis PDF relates to the repo's supported validation and publication goals.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Workflows",
        "WORKFLOWS.md",
        "Operator-facing workflow map: validation, experiments, docs sync, and intake.",
    ),
    HandbookSource(
        "docs Guide",
        "docs/README.md",
        "Which generated docs/status files are authoritative inputs versus build outputs.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "tools Guide",
        "tools/README.md",
        "Which generator scripts own the dashboard, handbook, public page, and status manifest.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Manual Helpers",
        "MANUAL-HELPERS.md",
        "Role of the root helper scripts and how they differ from the supported workflows.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "ADT Batch Integration",
        "ADT-BATCH-INTEGRATION.md",
        "Current bridge strategy and investigation state for the next post-M1 integration target.",
    ),
    HandbookSource(
        "Repository Structure Review",
        "REPOSITORY-STRUCTURE-REVIEW.md",
        "Filesystem review: supported line, reference snapshots, archives, and mixed-purpose areas.",
    ),
    HandbookSource(
        "Documentation Coverage Review",
        "DOCS-COVERAGE-REVIEW.md",
        "Repo-wide read on what is now well documented, what still feels thin, and where the next documentation passes should go.",
    ),
    HandbookSource(
        "Duplicates Review",
        "DUPLICATES-REVIEW.md",
        "Which reviewed historical overlaps are duplicates versus preserved provenance layers.",
        include_in_quick_index=False,
    ),
    HandbookSource(
        "Renovation Roadmap",
        "RENOVATION.md",
        "Migration history, current phase, roadmap, and long-form status narrative.",
    ),
]


HANDBOOK_CSS = """
:root{
  --bg:#07131f;
  --bg2:#10253b;
  --card:rgba(7,19,31,0.76);
  --card2:rgba(12,34,54,0.88);
  --line:rgba(135,197,255,0.22);
  --text:#eff7ff;
  --muted:#9cc4df;
  --done:#67e6a8;
  --next:#79b8ff;
  --focus:#ffd66b;
  --shadow:0 18px 40px rgba(0,0,0,0.28);
}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{
  margin:0;
  color:var(--text);
  font-family:"Avenir Next","Segoe UI",sans-serif;
  background:
    radial-gradient(circle at top left, rgba(103,230,168,0.16), transparent 24%),
    radial-gradient(circle at top right, rgba(121,184,255,0.2), transparent 30%),
    linear-gradient(160deg, var(--bg), var(--bg2));
  min-height:100vh;
}
a{color:#d9f7ff}
code{
  font-family:"SFMono-Regular","Menlo","Consolas",monospace;
  background:rgba(255,255,255,0.08);
  border-radius:8px;
  padding:0.12rem 0.36rem;
}
pre{
  overflow:auto;
  padding:16px 18px;
  border-radius:18px;
  background:rgba(4,12,20,0.88);
  border:1px solid rgba(255,255,255,0.08);
}
pre code{
  background:transparent;
  padding:0;
  border-radius:0;
}
.shell{
  max-width:1380px;
  margin:0 auto;
  padding:36px 20px 72px;
}
.hero{
  padding:36px 34px 32px;
  border:1px solid rgba(177,222,255,0.18);
  border-radius:30px;
  background:
    linear-gradient(160deg, rgba(12,34,54,0.9), rgba(7,19,31,0.74)),
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
  font-size:clamp(36px,5vw,62px);
  line-height:.95;
  letter-spacing:-0.04em;
}
.hero p{
  max-width:900px;
  font-size:18px;
  line-height:1.65;
  color:var(--muted);
}
.meta{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
  gap:14px;
  margin-top:28px;
}
.metaCard,.miniCard,.sectionCard,.toc,.noteCard{
  border-radius:22px;
  background:rgba(255,255,255,0.05);
  border:1px solid rgba(255,255,255,0.08);
  box-shadow:var(--shadow);
}
.metaCard{
  padding:16px 18px;
  min-width:0;
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
.quickGrid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
  gap:14px;
  margin-top:22px;
}
.miniCard{
  padding:18px;
}
.miniCard h2{
  margin:10px 0 8px;
  font-size:20px;
}
.miniCard p,.noteCard p{
  margin:0;
  color:var(--muted);
  line-height:1.6;
}
.contentLayout{
  display:grid;
  grid-template-columns:minmax(270px,320px) minmax(0,1fr);
  gap:20px;
  margin-top:24px;
  align-items:start;
}
.toc{
  position:sticky;
  top:18px;
  padding:22px 20px;
  background:rgba(7,19,31,0.82);
}
.toc h2{
  margin:0 0 12px;
  font-size:22px;
}
.toc p{
  margin:0 0 16px;
  color:var(--muted);
  line-height:1.6;
}
.toc ul{
  margin:0;
  padding-left:18px;
}
.toc li{
  margin:8px 0;
  color:var(--muted);
}
.toc a{
  text-decoration:none;
}
.toc .subtoc{
  margin-top:6px;
  padding-left:16px;
}
.mainContent{
  display:grid;
  gap:18px;
}
.sectionCard{
  padding:24px;
  background:var(--card);
}
.sectionHeader{
  display:flex;
  justify-content:space-between;
  gap:14px;
  align-items:flex-start;
  margin-bottom:14px;
}
.sectionTitleWrap h2{
  margin:0 0 8px;
  font-size:30px;
  letter-spacing:-0.03em;
}
.sectionSummary{
  margin:0;
  color:var(--muted);
  line-height:1.6;
}
.sectionMeta{
  display:flex;
  flex-wrap:wrap;
  gap:10px;
}
.pill{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  padding:8px 12px;
  border-radius:999px;
  background:rgba(121,184,255,0.16);
  border:1px solid rgba(121,184,255,0.28);
  color:var(--text);
  font-size:12px;
  letter-spacing:.06em;
  text-decoration:none;
  text-transform:uppercase;
}
.docBody{
  color:#eef7ff;
}
.docBody h3,.docBody h4,.docBody h5,.docBody h6{
  margin-top:1.6em;
  margin-bottom:0.6em;
  letter-spacing:-0.02em;
}
.docBody p,
.docBody li,
.docBody td,
.docBody th{
  line-height:1.7;
}
.docBody p,
.docBody ul,
.docBody ol,
.docBody table,
.docBody pre,
.docBody blockquote{
  margin-top:0.9em;
  margin-bottom:0.9em;
}
.docBody ul,
.docBody ol{
  padding-left:22px;
}
.docBody blockquote{
  margin-left:0;
  padding:14px 16px;
  border-left:4px solid rgba(121,184,255,0.45);
  background:rgba(255,255,255,0.04);
  border-radius:14px;
  color:var(--muted);
}
.docBody table{
  width:100%;
  border-collapse:collapse;
  overflow:hidden;
  border-radius:18px;
  border:1px solid rgba(255,255,255,0.08);
}
.docBody th,
.docBody td{
  padding:12px 14px;
  border-bottom:1px solid rgba(255,255,255,0.08);
  text-align:left;
  vertical-align:top;
}
.docBody th{
  background:rgba(121,184,255,0.12);
}
.docBody tr:last-child td{
  border-bottom:none;
}
.noteRow{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
  gap:14px;
  margin-top:22px;
}
.noteCard{
  padding:18px;
}
.noteCard h2{
  margin:0 0 8px;
  font-size:20px;
}
.footer{
  margin-top:28px;
  color:#8db0c8;
  font-size:13px;
  line-height:1.7;
}
@media (max-width: 980px){
  .contentLayout{
    grid-template-columns:1fr;
  }
  .toc{
    position:static;
  }
}
@media (max-width: 720px){
  .shell{padding:20px 14px 54px}
  .hero{padding:26px 22px 24px}
  .heroTop{flex-direction:column;align-items:flex-start}
  .sectionCard{padding:20px}
  .sectionHeader{flex-direction:column}
}
"""


def slugify(text: str) -> str:
    text = text.lower()
    text = re.sub(r"[^a-z0-9]+", "-", text)
    return text.strip("-") or "section"


def strip_leading_h1(markdown: str) -> str:
    lines = markdown.splitlines()
    if lines and lines[0].startswith("# "):
        return "\n".join(lines[1:]).lstrip("\n")
    return markdown


def split_href(value: str) -> tuple[str, str]:
    if "#" in value:
        path, fragment = value.split("#", 1)
        return path, fragment
    return value, ""


def resolve_href(raw_href: str, source_path: Path, public: bool) -> str:
    if raw_href.startswith(("http://", "https://", "mailto:", "#")):
        return raw_href

    raw_path, fragment = split_href(raw_href)
    candidate = (source_path.parent / raw_path).resolve() if raw_path else source_path

    try:
        relative = candidate.relative_to(ROOT)
    except ValueError:
        return raw_href

    public_doc_map = {
        Path("docs/release-dashboard.html"): "phd-renovation-dashboard.html",
        Path("docs/public-phd-renovation.html"): "phd-renovation.html",
        Path("docs/project-handbook.html"): "phd-renovation-handbook.html",
        Path("docs/public-phd-renovation-handbook.html"): "phd-renovation-handbook.html",
    }

    if public:
        if relative in public_doc_map:
            href = public_doc_map[relative]
        else:
            href = PUBLIC_REPO_BASE + relative.as_posix()
    else:
        href = os.path.relpath(candidate, DOCS_DIR).replace(os.sep, "/")

    if fragment:
        return f"{href}#{fragment}"
    return href


def format_inline(text: str, source_path: Path, public: bool) -> str:
    code_tokens: list[str] = []

    def stash_code(match: re.Match[str]) -> str:
        token = f"__CODE_TOKEN_{len(code_tokens)}__"
        code_tokens.append(f"<code>{escape(match.group(1))}</code>")
        return token

    def apply_style(value: str) -> str:
        value = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", value)
        value = re.sub(r"(?<!\*)\*(.+?)\*(?!\*)", r"<em>\1</em>", value)
        return value

    working = re.sub(r"`([^`]+)`", stash_code, text)
    escaped = escape(working)

    def replace_links(match: re.Match[str]) -> str:
        label = apply_style(match.group(1))
        resolved = resolve_href(match.group(2), source_path, public)
        return f'<a href="{escape(resolved, quote=True)}">{label}</a>'

    escaped = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", replace_links, escaped)
    escaped = apply_style(escaped)

    for index, code_html in enumerate(code_tokens):
        escaped = escaped.replace(f"__CODE_TOKEN_{index}__", code_html)

    return escaped


def is_table_delimiter(line: str) -> bool:
    stripped = line.strip()
    return bool(stripped) and set(stripped) <= {"|", "-", ":", " "}


def split_table_row(line: str) -> list[str]:
    stripped = line.strip().strip("|")
    return [cell.strip() for cell in stripped.split("|")]


def render_table(lines: list[str], source_path: Path, public: bool) -> str:
    headers = split_table_row(lines[0])
    rows = [split_table_row(line) for line in lines[2:]]
    head_html = "".join(
        f"<th>{format_inline(cell, source_path, public)}</th>" for cell in headers
    )
    body_rows = []
    for row in rows:
        cells = "".join(
            f"<td>{format_inline(cell, source_path, public)}</td>" for cell in row
        )
        body_rows.append(f"<tr>{cells}</tr>")
    return (
        "<table><thead><tr>"
        + head_html
        + "</tr></thead><tbody>"
        + "".join(body_rows)
        + "</tbody></table>"
    )


def render_markdown(
    markdown: str,
    source_path: Path,
    public: bool,
    anchor_prefix: str,
) -> tuple[str, list[tuple[int, str, str]]]:
    lines = strip_leading_h1(markdown).splitlines()
    html: list[str] = []
    toc_entries: list[tuple[int, str, str]] = []
    i = 0

    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        if not stripped:
            i += 1
            continue

        if stripped.startswith("```"):
            language = stripped[3:].strip()
            block: list[str] = []
            i += 1
            while i < len(lines) and not lines[i].strip().startswith("```"):
                block.append(lines[i])
                i += 1
            if i < len(lines):
                i += 1
            class_attr = (
                f' class="language-{escape(language, quote=True)}"' if language else ""
            )
            html.append(
                f"<pre><code{class_attr}>{escape(chr(10).join(block))}</code></pre>"
            )
            continue

        heading_match = re.match(r"^(#{2,6})\s+(.+)$", stripped)
        if heading_match:
            original_level = len(heading_match.group(1))
            heading_text = heading_match.group(2).strip()
            display_level = min(original_level + 1, 6)
            anchor = f"{anchor_prefix}-{slugify(heading_text)}"
            toc_entries.append((display_level, heading_text, anchor))
            html.append(
                f'<h{display_level} id="{escape(anchor, quote=True)}">'
                f"{format_inline(heading_text, source_path, public)}</h{display_level}>"
            )
            i += 1
            continue

        if stripped.startswith(">"):
            quote_lines: list[str] = []
            while i < len(lines) and lines[i].strip().startswith(">"):
                quote_lines.append(lines[i].strip()[1:].strip())
                i += 1
            html.append(
                f"<blockquote>{format_inline(' '.join(quote_lines), source_path, public)}</blockquote>"
            )
            continue

        if stripped.startswith("|") and i + 1 < len(lines) and is_table_delimiter(lines[i + 1]):
            table_lines = [lines[i], lines[i + 1]]
            i += 2
            while i < len(lines) and lines[i].strip().startswith("|"):
                table_lines.append(lines[i])
                i += 1
            html.append(render_table(table_lines, source_path, public))
            continue

        unordered_match = re.match(r"^[-*]\s+(.+)$", stripped)
        ordered_match = re.match(r"^\d+\.\s+(.+)$", stripped)
        if unordered_match or ordered_match:
            ordered = bool(ordered_match)
            tag = "ol" if ordered else "ul"
            items: list[str] = []
            pattern = r"^\d+\.\s+(.+)$" if ordered else r"^[-*]\s+(.+)$"
            while i < len(lines):
                candidate = lines[i].strip()
                match = re.match(pattern, candidate)
                if not match:
                    break
                items.append(
                    f"<li>{format_inline(match.group(1).strip(), source_path, public)}</li>"
                )
                i += 1
            html.append(f"<{tag}>{''.join(items)}</{tag}>")
            continue

        paragraph_lines = [stripped]
        i += 1
        while i < len(lines):
            candidate = lines[i].strip()
            if not candidate:
                break
            if candidate.startswith(("```", ">", "|", "#")):
                break
            if re.match(r"^[-*]\s+.+$", candidate) or re.match(r"^\d+\.\s+.+$", candidate):
                break
            paragraph_lines.append(candidate)
            i += 1
        html.append(
            f"<p>{format_inline(' '.join(paragraph_lines), source_path, public)}</p>"
        )

    return "\n".join(html), toc_entries


def build_quick_index() -> str:
    cards = []
    for source in HANDBOOK_SOURCES:
        if not source.include_in_quick_index:
            continue
        section_id = f"section-{slugify(source.title)}"
        cards.append(
            f"""      <article class="miniCard">
        <span class="eyebrow">Included guide</span>
        <h2><a href="#{escape(section_id, quote=True)}">{escape(source.title)}</a></h2>
        <p>{escape(source.summary)}</p>
      </article>"""
        )
    return "\n".join(cards)


def build_toc(section_entries: list[dict[str, object]]) -> str:
    items = []
    for section in section_entries:
        subsections = []
        for level, title, anchor in section["subsections"]:
            if level > 4:
                continue
            subsections.append(
                f'<li><a href="#{escape(anchor, quote=True)}">{escape(title)}</a></li>'
            )
        subtoc = (
            f'<ul class="subtoc">{"".join(subsections)}</ul>' if subsections else ""
        )
        items.append(
            f"""        <li>
          <a href="#{escape(section["id"], quote=True)}">{escape(section["title"])}</a>
          {subtoc}
        </li>"""
        )
    return "\n".join(items)


def render_sections(public: bool) -> tuple[str, str]:
    section_cards: list[str] = []
    toc_entries: list[dict[str, object]] = []

    for source in HANDBOOK_SOURCES:
        source_path = ROOT / source.path
        markdown = source_path.read_text(encoding="utf-8")
        section_id = f"section-{slugify(source.title)}"
        body_html, subsections = render_markdown(markdown, source_path, public, section_id)
        source_href = resolve_href(source.path, source_path, public)
        toc_entries.append(
            {"id": section_id, "title": source.title, "subsections": subsections}
        )
        section_cards.append(
            f"""      <section class="sectionCard" id="{escape(section_id, quote=True)}">
        <div class="sectionHeader">
          <div class="sectionTitleWrap">
            <span class="eyebrow">Source document</span>
            <h2>{escape(source.title)}</h2>
            <p class="sectionSummary">{escape(source.summary)}</p>
          </div>
          <div class="sectionMeta">
            <a class="pill" href="{escape(source_href, quote=True)}">Open source</a>
          </div>
        </div>
        <div class="docBody">
{body_html}
        </div>
      </section>"""
        )

    return "\n".join(section_cards), build_toc(toc_entries)


def build_handbook_page(data: dict[str, object], public: bool) -> str:
    metrics = data["metrics"]
    sections_html, toc_html = render_sections(public)
    public_link = (
        "phd-renovation-handbook.html" if public else "public-phd-renovation-handbook.html"
    )
    dashboard_link = (
        "phd-renovation-dashboard.html" if public else "release-dashboard.html"
    )
    public_page_link = "phd-renovation.html" if public else "public-phd-renovation.html"
    parent_page_link = "phd-renovation.html" if public else "../README.md"
    root_link = "https://github.com/sgwoods/phd-renovation" if public else "../README.md"
    generated_note = "Public handbook" if public else "Repository handbook"
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PhD Renovation Handbook</title>
  <style>
{HANDBOOK_CSS}
  </style>
</head>
<body>
  <!-- Generated by tools/generate-project-handbook.py -->
  <main class="shell">
    <section class="hero">
      <div class="heroTop">
        <span class="eyebrow">PhD Renovation • Complete Handbook</span>
        <a class="heroParentLink" href="{escape(parent_page_link, quote=True)}">PhD Renovation</a>
      </div>
      <h1>Readable handbook for the full project state.</h1>
      <p>
        This page gathers the project's core documentation into one indexed,
        linkable handbook. It is meant to be the human-readable companion to the
        dashboard: architecture, status, workflows, validation scope, integration
        targets, archive posture, and roadmap live here in one place.
      </p>
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
      <div class="quickGrid">
{build_quick_index()}
      </div>
      <div class="noteRow">
        <article class="noteCard">
          <h2>What this includes</h2>
          <p>
            The handbook assembles the repo overview, status matrix, validation
            scope, workflows, development guide, integration notes, structure
            review, duplication policy, and long-form roadmap into one page.
          </p>
        </article>
        <article class="noteCard">
          <h2>How it stays current</h2>
          <p>
            This page is generated during the same docs/status build cadence as
            the release dashboard and public project page. Updating the source
            docs and regenerating the project docs refreshes the handbook too.
          </p>
        </article>
        <article class="noteCard">
          <h2>Fast links</h2>
          <p>
            <a href="{escape(dashboard_link, quote=True)}">Release dashboard</a>,
            <a href="{escape(public_page_link, quote=True)}">project page</a>,
            <a href="{escape(public_link, quote=True)}">public handbook</a>,
            <a href="{escape(root_link, quote=True)}">repository root</a>.
          </p>
        </article>
      </div>
    </section>
    <div class="contentLayout">
      <aside class="toc">
        <h2>Table of contents</h2>
        <p>
          Use this index to jump through the current documentation set without
          losing the relationship between status, code, experiments, and archive
          material.
        </p>
        <ul>
{toc_html}
        </ul>
      </aside>
      <div class="mainContent">
{sections_html}
      </div>
    </div>
    <p class="footer">
      {generated_note} generated from tracked markdown sources under the project
      root and <code>docs/release-dashboard-data.json</code>. Regenerate with
      <code>python3 tools/generate-release-dashboard.py</code>.
    </p>
  </main>
</body>
</html>
"""


def generate_handbook_outputs(data: dict[str, object] | None = None) -> None:
    if data is None:
        data = json.loads(DATA_PATH.read_text(encoding="utf-8"))

    handbook_html = build_handbook_page(data, public=False)
    public_handbook_html = build_handbook_page(data, public=True)
    HANDBOOK_OUTPUT_PATH.write_text(handbook_html, encoding="utf-8")
    PUBLIC_HANDBOOK_OUTPUT_PATH.write_text(public_handbook_html, encoding="utf-8")

    if PUBLIC_SITE_DIR.exists():
        try:
            PUBLIC_SITE_HANDBOOK_PATH.write_text(public_handbook_html, encoding="utf-8")
        except PermissionError:
            pass


def main() -> None:
    generate_handbook_outputs()


if __name__ == "__main__":
    main()
