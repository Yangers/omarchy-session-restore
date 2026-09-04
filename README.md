# 🍏 Omarchy Session Restore

> **macOS-style session save & restore for Omarchy (Hyprland + Wayland)**  
> Automatically saves all open windows, workspaces, terminal working directories, and browser tabs before reboot/shutdown, and prompts you at login to reopen everything exactly where you left off.

---

## ✨ Features

- **macOS-Style Boot Prompt**: Sleek, native Omarchy menu prompt at login asking whether to restore your session or start fresh.
- **Chromium & PWAs Support**: Restores all browser windows and tabs cleanly (`--restore-last-session`), mapping standalone PWAs (e.g., Gmail, web apps) back to their designated workspaces.
- **Terminal Working Directory (`cwd`) & Agent Recovery**:
  - Restores active terminals (`foot`, `ghostty`, `alacritty`, `kitty`) to the exact directory they were open in.
  - Automatically identifies and relaunches [Herdr](https://herdr.dev) AI agent workspace sessions.
- **VS Code**: Restores projects and window workspaces.
- **Multi-Workspace Layout**: Routes all general apps (Telegram, Spotify, Discord, Slack, etc.) back to their respective Hyprland workspace numbers without focus stealing.
- **Zero Configuration Required**: Works out of the box with safe user-level scripts. Never modifies `/usr/share/omarchy/`.

---

## 🚀 Quick Install

To install on any Omarchy machine:

```bash
git clone https://github.com/Yangers/omarchy-session-restore.git
cd omarchy-session-restore
./install.sh
```

*(You can also share this exact command with anyone running Omarchy!)*

---

## 🖥️ How It Works

1. **Before Shutdown / Reboot**:
   - Running `omarchy system shutdown`, `omarchy system reboot`, or clicking power options in the Omarchy desktop menu automatically snapshots all clients via `hyprctl clients -j`.
   - Captures window classes, process IDs, terminal paths (`/proc/<pid>/cwd`), and workspaces to `~/.config/omarchy/session/last-session.json`.
   - Closes apps gracefully so browsers write their session databases to disk.

2. **At Boot (Login)**:
   - Omarchy triggers the `post-boot.d` hook.
   - An interactive desktop menu appears:
     ```text
     ┌────────────────────────────────────────────────────────┐
     │  Restore Previous Session?                             │
     │                                                        │
     │  ✨ Reopen Previous Windows (5 apps across 5 workspaces)│
     │  ❌ Start Fresh (Discard saved session)                │
     │  ⚙️ Always Reopen at Boot without asking               │
     │  🚫 Disable Session Restore                            │
     └────────────────────────────────────────────────────────┘
     ```
   - Selecting **Reopen** injects temporary workspace placement rules and launches each application directly into its original workspace.

---

## 🛠️ CLI Commands

You can also run or test the session manager manually from any terminal:

```bash
omarchy-session status   # View current session status & saved windows
omarchy-session save     # Manually snapshot active desktop session
omarchy-session restore  # Manually restore last saved session
omarchy-session prompt   # Trigger the macOS-style interactive boot prompt
omarchy-session clear    # Discard saved session
```

---

## ⚙️ Configuration

Settings are saved in `~/.config/omarchy/session/config.json`:

```json
{
  "enabled": true,
  "auto_restore": false,
  "clean_delay_sec": 7,
  "ignored_classes": [
    "quickshell",
    "org.quickshell",
    "hyprland-share-picker",
    "omarchy-osd",
    "xwaylandvideobridge"
  ]
}
```

- Set `"auto_restore": true` if you prefer to automatically restore windows at boot without the prompt.

---

## 🗑️ Uninstall

To cleanly remove everything:

```bash
cd omarchy-session-restore
./uninstall.sh
```

---

## 📄 License

MIT License © 2026 Yangers Puentes
