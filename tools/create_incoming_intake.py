#!/usr/bin/env python3
"""Create a new intake batch scaffold under incoming/ and register it."""

from __future__ import annotations

import argparse
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
INCOMING_DIR = ROOT / "incoming"
INDEX_PATH = INCOMING_DIR / "INDEX.md"
REVIEW_TEMPLATE_PATH = INCOMING_DIR / "REVIEW-TEMPLATE.md"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Create a new incoming intake directory and index row."
    )
    parser.add_argument(
        "slug",
        help=(
            "Folder name to create under incoming/, for example "
            "'2026-05-03-lacie1' or 'misc-paper-scan'."
        ),
    )
    parser.add_argument(
        "--source",
        default="unknown",
        help="Short source description for incoming/INDEX.md.",
    )
    parser.add_argument(
        "--type",
        dest="apparent_type",
        default="mixed / unknown",
        help="Apparent material type for incoming/INDEX.md.",
    )
    parser.add_argument(
        "--status",
        default="landed",
        help="Initial intake status for incoming/INDEX.md. Defaults to 'landed'.",
    )
    parser.add_argument(
        "--next-action",
        default="Review and classify",
        help="Next action note for incoming/INDEX.md.",
    )
    parser.add_argument(
        "--added",
        default="TBD",
        help="Added date for incoming/INDEX.md, usually YYYY-MM-DD.",
    )
    return parser.parse_args()


def load_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def write_text(path: Path, content: str) -> None:
    path.write_text(content, encoding="utf-8")


def build_batch_note(slug: str, args: argparse.Namespace) -> str:
    template = load_text(REVIEW_TEMPLATE_PATH)
    replacements = {
        "- Intake path:": f"- Intake path: incoming/{slug}/",
        "- Original dump name:": f"- Original dump name: {slug}",
        "- Review date:": f"- Review date: {args.added}",
        "- Source / where it came from:": f"- Source / where it came from: {args.source}",
    }
    note = template
    for old, new in replacements.items():
        note = note.replace(old, new, 1)
    return note


def update_index(slug: str, args: argparse.Namespace) -> None:
    contents = load_text(INDEX_PATH)
    new_row = (
        f"| `incoming/{slug}/` | {args.added} | {args.source} | "
        f"{args.apparent_type} | {args.status} | {args.next_action} |"
    )
    placeholder = "| _none yet_ | - | - | - | - | Add the first reviewed intake here |"
    if placeholder in contents:
        contents = contents.replace(placeholder, new_row, 1)
    elif new_row not in contents:
        header = "| Intake path | Added | Source | Apparent type | Status | Next action |\n"
        contents = contents.replace(header, header + new_row + "\n", 1)
    write_text(INDEX_PATH, contents)


def main() -> int:
    args = parse_args()
    intake_dir = INCOMING_DIR / args.slug
    if intake_dir.exists():
        raise SystemExit(f"Intake directory already exists: {intake_dir}")

    intake_dir.mkdir(parents=True)
    note_path = intake_dir / "README.md"
    write_text(note_path, build_batch_note(args.slug, args))
    update_index(args.slug, args)

    print(f"Created {intake_dir}")
    print(f"Created {note_path}")
    print(f"Updated {INDEX_PATH}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
