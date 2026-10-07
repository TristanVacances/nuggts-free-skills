#!/usr/bin/env bash
# Pre-publish gate: private-data leaks, frontmatter validity, zip structure.
# Usage: scripts/check.sh [dir]   (default: repo root). Exit 1 on any failure.
set -uo pipefail
ROOT="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
fail=0

# 1. Leak scan: generic patterns (paths, emails, secrets) + an optional PRIVATE deny-list
#    kept outside the repo (one regex per line): $NUGGTS_DENYLIST or ~/.config/nuggts/free-skills-denylist.txt
LEAK='/Users/|@gmail\.com|sk-[A-Za-z0-9]{20}|sk_live_|ghp_[A-Za-z0-9]{20}|AKIA[0-9A-Z]{16}'
DENY="${NUGGTS_DENYLIST:-$HOME/.config/nuggts/free-skills-denylist.txt}"
if [ -f "$DENY" ]; then LEAK="$LEAK|$(grep -v '^\s*$' "$DENY" | paste -sd'|' -)"; else echo "note: no private deny-list at $DENY (generic scan only)"; fi
hits=$(grep -rnIE "$LEAK" "$ROOT/skills" "$ROOT"/*.md 2>/dev/null | grep -v 'github.com/TristanVacances/nuggts-free-skills')
if [ -n "$hits" ]; then echo "LEAK:"; echo "$hits"; fail=1; else echo "leak scan: clean"; fi

# 2. Frontmatter: valid YAML, name == folder, description present and <= 1024 chars
for f in "$ROOT"/skills/*/SKILL.md; do
  dir=$(basename "$(dirname "$f")")
  uv run -q --with pyyaml python3 - "$f" "$dir" <<'PY' || fail=1
import sys, yaml
path, folder = sys.argv[1], sys.argv[2]
text = open(path).read()
if not text.startswith('---\n'): sys.exit(f"{path}: no frontmatter")
fm = yaml.safe_load(text.split('---\n')[1])
name, desc = fm.get('name'), fm.get('description', '')
errs = []
if name != folder: errs.append(f"name '{name}' != folder '{folder}'")
if not desc or len(desc) > 1024: errs.append(f"description length {len(desc)}")
if errs: sys.exit(f"{path}: " + "; ".join(errs))
print(f"frontmatter ok: {folder} ({len(desc)} chars)")
PY
done

# 3. Zips (if built): each contains <name>/SKILL.md at the top level
if ls "$ROOT"/dist/*.zip >/dev/null 2>&1; then
  for z in "$ROOT"/dist/*.zip; do
    n=$(basename "$z" .zip)
    if unzip -l "$z" | grep -q " $n/SKILL.md$"; then echo "zip ok: $n"; else echo "ZIP BAD: $z lacks $n/SKILL.md"; fail=1; fi
  done
fi

[ $fail -eq 0 ] && echo "ALL CHECKS PASSED" || echo "CHECKS FAILED"
exit $fail
