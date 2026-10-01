#!/usr/bin/env bash
# Local setup on your PC: links global CLAUDE.md and prints plugin install commands.
set -eu
KIT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$HOME/.claude"

target="$HOME/.claude/CLAUDE.md"
if [ -e "$target" ] && [ ! -L "$target" ]; then
  echo "~/.claude/CLAUDE.md already exists (not a symlink) — merge manually from $KIT/global/CLAUDE.md"
else
  ln -sfn "$KIT/global/CLAUDE.md" "$target"
  echo "linked $target -> $KIT/global/CLAUDE.md"
fi

cat <<MSG

Now in Claude Code run:
  /plugin marketplace add $KIT
  /plugin install terraform-platform@bukovyak-kit
  /plugin install arch-research@bukovyak-kit

Local-path marketplace = edits to skills are picked up without pushing
(run /plugin marketplace update bukovyak-kit if something looks stale).
MSG
