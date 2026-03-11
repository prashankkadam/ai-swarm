#!/usr/bin/env bash
# AI Swarm — Install global Claude Code commands
# Usage: git clone <repo> && cd ai-swarm && ./install.sh

set -e

CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/commands"

echo "AI Swarm — Installing global Claude Code commands"
echo "================================================="

# Check source files exist
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: commands/ directory not found in $(pwd)"
    exit 1
fi

# Create target directory
mkdir -p "$COMMANDS_DIR"

# Install commands (with backup if existing)
for file in "$SOURCE_DIR"/*.md; do
    filename=$(basename "$file")
    target="$COMMANDS_DIR/$filename"

    if [ -f "$target" ]; then
        echo "  Backing up existing $filename → $filename.bak"
        cp "$target" "$target.bak"
    fi

    cp "$file" "$target"
    echo "  Installed: $filename"
done

echo ""
echo "Done! Commands installed to $COMMANDS_DIR"
echo ""
echo "Available commands (in any project):"
echo "  /swarm <task>      Full pipeline: research → implement → cross-review"
echo "  /research <query>  Research only, no code"
echo "  /review [files]    Dual independent code review"
echo ""
echo "To uninstall: ./uninstall.sh"
