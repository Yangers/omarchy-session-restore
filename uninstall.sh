#!/bin/bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
HOOK_DIR="$HOME/.config/omarchy/hooks/post-boot.d"
CONFIG_DIR="$HOME/.config/omarchy/session"

echo "=========================================="
echo "  Uninstalling Omarchy Session Restore"
echo "=========================================="

rm -f "$BIN_DIR/omarchy-session"
rm -f "$BIN_DIR/omarchy-system-shutdown"
rm -f "$BIN_DIR/omarchy-system-reboot"
rm -f "$HOOK_DIR/90-session-restore.sh"

read -r -p "Remove saved session config and history? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    rm -rf "$CONFIG_DIR"
    echo "• Configuration directory removed."
fi

echo ""
echo "✅ Successfully uninstalled Omarchy Session Restore."
echo "=========================================="
