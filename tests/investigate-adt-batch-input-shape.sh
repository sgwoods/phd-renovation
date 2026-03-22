#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== ADT batch input-shape investigation =="
echo "This inspects the generated ij2 input state before search starts."

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

bridge_dir="$tmp_dir/csp-bridge"
mkdir -p "$bridge_dir/ADT-Random"

for path in csp/*.lisp; do
  ln -s "$ROOT_DIR/$path" "$bridge_dir/$(basename "$path")"
done

random_source="${PHD_ADT_BRIDGE_RANDOM_SOURCE:-$ROOT_DIR/qcsp3/ADT-Random/Rnddefault}"
cp "$random_source" "$bridge_dir/ADT-Random/Rnddefault"
random_sha="$(shasum -a 256 "$random_source" | awk '{print substr($1,1,12)}')"
cache_dir="$tmp_dir/cache"
mkdir -p "$cache_dir"

echo "Using Rnddefault source: $random_source"
echo "Rnddefault sha: $random_sha"

PHD_ADT_BRIDGE_WORKDIR="$bridge_dir/" \
XDG_CACHE_HOME="$cache_dir" \
sbcl --non-interactive --load "$ROOT_DIR/tests/run-adt-batch-input-shape-ij2.lisp"

echo "ADT batch input-shape investigation completed."
