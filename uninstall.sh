#!/usr/bin/env bash
# AI Swarm — Remove global Claude Code commands

set -e

COMMANDS_DIR="$HOME/.claude/commands"
SWARM_FILES=("swarm.md" "research.md" "review.md")

echo "AI Swarm — Uninstalling global Claude Code commands"
echo "===================================================="

for file in "${SWARM_FILES[@]}"; do
    target="$COMMANDS_DIR/$file"
    if [ -f "$target" ]; then
        rm "$target"
        echo "  Removed: $file"
        # Restore backup if exists
        if [ -f "$target.bak" ]; then
            mv "$target.bak" "$target"
            echo "  Restored: $file from backup"
        fi
    fi
done

echo ""
echo "Done! Swarm commands removed."
