#!/bin/bash
# One-click install: copy the skill to your Claude Code global skills directory

SKILL_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$SKILL_DIR"
cp "$SCRIPT_DIR/setup-unity-mcp.skill.md" "$SKILL_DIR/setup-unity-mcp.md"

echo "Skill installed to $SKILL_DIR/setup-unity-mcp.md"
echo "Now open Claude Code and say: 帮我配置 Unity MCP"
