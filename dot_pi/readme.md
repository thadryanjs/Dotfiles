# Pi Configuration

## Permission System

### @pi-lab/permissions (Session-Scoped Permissions)

**Status:** ✅ Working

**Features:**
- **Allow** - Approve once
- **Allow always** - Approve for rest of session (NOT persisted) ← **Key feature**
- **Deny** - Deny once
- **Deny always** - Deny for rest of session (NOT persisted)

**Installation:**
```bash
# Install pnpm (one-time)
sudo npm install -g pnpm

# Clone and build
pi install git:https://github.com/anthod0/pi-lab
cd ~/.pi/agent/git/github.com/anthod0/pi-lab/packages/permissions
pnpm install
pnpm build

# Symlink to extensions folder
ln -s ~/.pi/agent/git/github.com/anthod0/pi-lab/packages/permissions ~/.pi/agent/extensions/@pi-lab-permissions

# Reload pi
/reload
```

**Configuration:** (`settings.json`)
```json
{
  "permissions": {
    "rules": [
      { "message": "Block rm -rf", "priority": 100, "match": { "tool": "bash", "params": { "command": "rm\\s+-rf" } }, "action": "deny" },
      { "message": "Block sudo", "priority": 100, "match": { "tool": "bash", "params": { "command": "sudo" } }, "action": "deny" },
      { "message": "Allow reads", "priority": 50, "match": { "tool": "read" }, "action": "allow" },
      { "message": "Ask before edit", "priority": 50, "match": { "tool": "edit" }, "action": "ask" },
      { "message": "Ask before write", "priority": 50, "match": { "tool": "write" }, "action": "ask" }
    ]
  }
}
```

**Why not npm install?**
- `npm install -g` fails due to `/usr/lib/node_modules/` permissions
- `npm install -g --prefix ~/.pi` works but pi doesn't load from there
- Git + pnpm build + symlink is the reliable path

**Alternative: YOLO Mode**
- Press `F8` to toggle auto-approve all `ask` permissions for the session
- Too broad for granular control, but works as a fallback

---

## Niri Wayland Compositor

### Keybindings

**Move window to monitor (vim-style HJKL):**
- `Mod+Shift+Ctrl+H` - Move window to monitor left
- `Mod+Shift+Ctrl+J` - Move window to monitor down
- `Mod+Shift+Ctrl+K` - Move window to monitor up
- `Mod+Shift+Ctrl+L` - Move window to monitor right

**Focus monitor (existing):**
- `Mod+Shift+HJKL` - Focus monitor left/down/up/right

**Move column (existing):**
- `Mod+Shift+Left/Right/Up/Down` - Move column

**Config:** `/home/thadryan/Vaults/Projects/Dotfiles/.config/niri/config.kdl`

**Documentation:** `/home/thadryan/Vaults/Knowledge/Areas/Tooling/Niri/general.md`
