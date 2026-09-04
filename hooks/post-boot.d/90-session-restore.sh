#!/bin/bash
# Omarchy post-boot hook: prompt to restore previous session (macOS style)

# Wait 1.5s for Omarchy shell to finish initializing
sleep 1.5

if command -v omarchy-session >/dev/null 2>&1; then
    omarchy-session prompt
elif [[ -x "$HOME/.local/bin/omarchy-session" ]]; then
    "$HOME/.local/bin/omarchy-session" prompt
fi
