#!/bin/bash
set -euo pipefail

# Omarchy Session Restore - Installer
# Works for any user on Omarchy Linux (Arch + Hyprland)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
HOOK_DIR="$HOME/.config/omarchy/hooks/post-boot.d"
CONFIG_DIR="$HOME/.config/omarchy/session"

echo "=========================================="
echo "  Installing Omarchy Session Restore"
echo "=========================================="

# Check requirements
for cmd in python3 hyprctl omarchy notify-send; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: Required command '$cmd' is not installed or not in PATH." >&2
        exit 1
    fi
done

# Ensure directories exist
mkdir -p "$BIN_DIR"
mkdir -p "$HOOK_DIR"
mkdir -p "$CONFIG_DIR"

# Install binary
echo "• Installing omarchy-session to $BIN_DIR/omarchy-session..."
cp "$REPO_DIR/bin/omarchy-session" "$BIN_DIR/omarchy-session"
chmod +x "$BIN_DIR/omarchy-session"

# Install shutdown & reboot wrappers
echo "• Installing shutdown and reboot hooks to $BIN_DIR..."
cp "$REPO_DIR/system/omarchy-system-shutdown" "$BIN_DIR/omarchy-system-shutdown"
cp "$REPO_DIR/system/omarchy-system-reboot" "$BIN_DIR/omarchy-system-reboot"
chmod +x "$BIN_DIR/omarchy-system-shutdown" "$BIN_DIR/omarchy-system-reboot"

# Install post-boot hook
echo "• Installing boot restore prompt to $HOOK_DIR..."
cp "$REPO_DIR/hooks/post-boot.d/90-session-restore.sh" "$HOOK_DIR/90-session-restore.sh"
chmod +x "$HOOK_DIR/90-session-restore.sh"

# Ensure PATH includes ~/.local/bin
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "Notice: Please make sure $HOME/.local/bin is in your PATH."
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "How it works:"
echo "1. On reboot or shutdown, your open apps & workspaces are saved automatically."
echo "2. At next boot, a macOS-style menu prompts to restore your session."
echo ""
echo "Commands:"
echo "  omarchy-session status   # View current session status"
echo "  omarchy-session save     # Manually snapshot active session"
echo "  omarchy-session restore  # Manually restore last session"
echo "  omarchy-session prompt   # Test the boot prompt"
echo "  omarchy-session clear    # Discard saved session"
echo "=========================================="
