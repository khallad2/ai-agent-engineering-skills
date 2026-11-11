#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/khallad2/ai-agent-engineering-skills.git"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Installing AI Agent Engineering Skills Pack (by @Khallad-tech)..."

# If running via curl | bash (where skills/ is not in SCRIPT_DIR), clone to a temp dir
CLEANUP_DIR=""
if [ ! -d "$SCRIPT_DIR/skills" ] || [ ! -d "$SCRIPT_DIR/agents" ]; then
  CLEANUP_DIR="$(mktemp -d)"
  trap 'rm -rf "$CLEANUP_DIR"' EXIT
  echo "📥 Downloading latest skills & agents from GitHub..."
  git clone --depth 1 "$REPO_URL" "$CLEANUP_DIR/repo" >/dev/null 2>&1
  SOURCE_DIR="$CLEANUP_DIR/repo"
else
  SOURCE_DIR="$SCRIPT_DIR"
fi

# 1. Install Global Skills & Agents for Google Antigravity / Gemini CLI
GEMINI_SKILLS_DIR="$HOME/.gemini/config/skills"
GEMINI_AGENTS_DIR="$HOME/.gemini/config/agents"
mkdir -p "$GEMINI_SKILLS_DIR" "$GEMINI_AGENTS_DIR"
cp -R "$SOURCE_DIR/skills/"* "$GEMINI_SKILLS_DIR/"
cp -R "$SOURCE_DIR/agents/"* "$GEMINI_AGENTS_DIR/"
echo "✅ Installed 9 Skills -> $GEMINI_SKILLS_DIR"
echo "✅ Installed 5 Agents -> $GEMINI_AGENTS_DIR"

# 2. Install Global Skills & Agents for Claude Code (if ~/.claude exists or user wants universal setup)
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
CLAUDE_AGENTS_DIR="$HOME/.claude/agents"
mkdir -p "$CLAUDE_SKILLS_DIR" "$CLAUDE_AGENTS_DIR"
cp -R "$SOURCE_DIR/skills/"* "$CLAUDE_SKILLS_DIR/"
cp -R "$SOURCE_DIR/agents/"* "$CLAUDE_AGENTS_DIR/"
echo "✅ Installed Skills & Agents for Claude Code -> $HOME/.claude/"

# 3. Optional: Initialize current project directory if --project flag is passed or interactive
if [[ "${1:-}" == "--project" ]] || [[ "${1:-}" == "-p" ]]; then
  if [ ! -f "./AGENTS.md" ]; then
    cp "$SOURCE_DIR/AGENTS_TEMPLATE.md" "./AGENTS.md"
    echo "✅ Created ./AGENTS.md in current project"
  fi
  if [ ! -f "./GEMINI.md" ]; then
    cp "$SOURCE_DIR/AGENTS_TEMPLATE.md" "./GEMINI.md"
    echo "✅ Created ./GEMINI.md in current project"
  fi
  if [ ! -f "./.cursorrules" ]; then
    cp "$SOURCE_DIR/AGENTS_TEMPLATE.md" "./.cursorrules"
    echo "✅ Created ./.cursorrules in current project"
  fi
fi

echo ""
echo "🎉 Installation Complete! Your AI Agent now thinks like a Senior Engineer."
echo "💡 Tip: To add AGENTS.md to any project folder, run:"
echo "   curl -fsSL https://raw.githubusercontent.com/khallad2/ai-agent-engineering-skills/main/AGENTS_TEMPLATE.md -o AGENTS.md"
