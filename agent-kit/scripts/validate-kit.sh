#!/usr/bin/env bash
# Checks kit structure: JSON manifests, skill/agent frontmatter, name == folder.
set -u
cd "$(dirname "$0")/.."
rc=0
err() { echo "ERROR: $*"; rc=1; }

json_ok() { python3 -c 'import json,sys; json.load(open(sys.argv[1]))' "$1" 2>/dev/null; }

for f in .claude-plugin/marketplace.json plugins/*/.claude-plugin/plugin.json plugins/*/hooks/hooks.json; do
  [ -f "$f" ] || continue
  json_ok "$f" || err "$f: invalid JSON"
done

# every plugin in marketplace.json exists and has matching name
python3 - <<'PY' || rc=1
import json, os, sys
m = json.load(open(".claude-plugin/marketplace.json"))
bad = False
for p in m["plugins"]:
    pj = os.path.join(p["source"], ".claude-plugin", "plugin.json")
    if not os.path.isfile(pj):
        print(f"ERROR: {p['name']}: missing {pj}"); bad = True; continue
    if json.load(open(pj))["name"] != p["name"]:
        print(f"ERROR: {pj}: name != {p['name']}"); bad = True
sys.exit(1 if bad else 0)
PY

fm() { awk 'NR==1&&$0!="---"{exit} NR>1&&$0=="---"{exit} NR>1{print}' "$1"; }

for s in plugins/*/skills/*/SKILL.md; do
  dir=$(basename "$(dirname "$s")")
  name=$(fm "$s" | sed -n 's/^name: *//p')
  desc=$(fm "$s" | sed -n 's/^description: *//p')
  [ "$name" = "$dir" ] || err "$s: name '$name' != folder '$dir'"
  [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || err "$s: name must be kebab-case"
  [ -n "$desc" ] || err "$s: missing description"
  [ ${#desc} -le 1024 ] || err "$s: description > 1024 chars"
  lines=$(wc -l < "$s"); [ "$lines" -le 500 ] || err "$s: $lines lines (> 500)"
done

for a in plugins/*/agents/*.md; do
  name=$(fm "$a" | sed -n 's/^name: *//p')
  [ "$name" = "$(basename "$a" .md)" ] || err "$a: name '$name' != file name"
  fm "$a" | grep -q '^description:' || err "$a: missing description"
done

[ $rc -eq 0 ] && echo "kit OK"
exit $rc
