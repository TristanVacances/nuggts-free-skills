#!/usr/bin/env bash
# Build one upload-ready zip per skill: dist/<name>.zip containing <name>/SKILL.md (+ references/).
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
for d in skills/*/; do
  name=$(basename "$d")
  out="dist/$name.zip"
  # -FS syncs an existing archive with the folder (drops entries deleted since last build)
  (cd skills && zip -qr -FS "../$out" "$name" -x "$name/README.md" "*.DS_Store")
  echo "built $out"
done
