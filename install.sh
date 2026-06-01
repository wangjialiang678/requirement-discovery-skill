#!/usr/bin/env bash
# 把需求澄清工作流部署到 ~/.claude/
# 不会自动修改你的全局 CLAUDE.md —— 见 CLAUDE.md.snippet，手动追加。
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_HOME:-$HOME/.claude}"

echo "源: $SRC"
echo "目标: $DEST"

mkdir -p "$DEST/commands" "$DEST/agents" "$DEST/skills"

cp -v "$SRC/commands/define-problem.md" "$DEST/commands/"
cp -v "$SRC/agents/doc-generator.md"    "$DEST/agents/"
rm -rf "$DEST/skills/requirement-discovery"
cp -vR "$SRC/skills/requirement-discovery" "$DEST/skills/"

echo
echo "✅ 已部署。"
echo "⚠️  最后一步（手动）：在 $DEST/CLAUDE.md 的「需求澄清」段落追加 CLAUDE.md.snippet 中的一行。"
echo "   然后重载 Claude Code 窗口，即可使用 /define-problem"
