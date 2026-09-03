#!/usr/bin/env bash
# 把需求澄清工作流部署到 ~/.claude/
# 不会自动修改你的全局 CLAUDE.md —— 见 CLAUDE.md.snippet，手动追加。
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_HOME:-$HOME/.claude}"

echo "源: $SRC"
echo "目标: $DEST"

mkdir -p "$DEST/commands" "$DEST/agents" "$DEST/skills"

archive_existing() {
  local target="$1"
  if [[ ! -e "$target" ]]; then
    return
  fi

  local backup_dir="$DEST/backups/requirement-discovery"
  mkdir -p "$backup_dir"
  local backup="$backup_dir/$(basename "$target").bak-$(date +%Y%m%d)"
  if [[ -e "$backup" ]]; then
    backup="${backup}-$(date +%H%M%S)"
  fi
  mv "$target" "$backup"
  echo "已备份: $backup"
}

archive_existing "$DEST/commands/define-problem.md"
archive_existing "$DEST/agents/doc-generator.md"
archive_existing "$DEST/skills/requirement-discovery"
archive_existing "$DEST/skills/decision-context-interview"
archive_existing "$DEST/skills/management-context-interview"
archive_existing "$DEST/skills/venture-opportunity-review"

cp -v "$SRC/commands/define-problem.md" "$DEST/commands/"
cp -v "$SRC/agents/doc-generator.md" "$DEST/agents/"
cp -vR "$SRC/skills/requirement-discovery" "$DEST/skills/"
cp -vR "$SRC/skills/management-context-interview" "$DEST/skills/"
cp -vR "$SRC/skills/venture-opportunity-review" "$DEST/skills/"

echo
echo "✅ 已部署 requirement-discovery、management-context-interview 与 venture-opportunity-review。"
echo "⚠️  最后一步（手动）：在 $DEST/CLAUDE.md 的「需求澄清」段落追加 CLAUDE.md.snippet 中的一行。"
echo "   然后重载 Claude Code 窗口，即可使用 /define-problem"
