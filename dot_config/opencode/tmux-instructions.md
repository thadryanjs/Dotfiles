# Tmux Integration for oh-my-opencode-slim

Watch agents work in real-time in separate panes.

---

## Quick Start

1. **Start tmux:**
   ```bash
   tmux
   ```

2. **Launch OpenCode with port flag:**
   ```bash
   opencode --port 4096
   ```

3. **Give a task** - agents spawn in their own panes as the Orchestrator delegates work.

---

## Why `--port 4096`?

Upstream bug ([opencode#9099](https://github.com/anomalyco/opencode/issues/9099)) - tmux pane spawning only works with an explicit port. `4096` is default, any free port works.

---

## Without Tmux

If you run `opencode` normally (no tmux or no `--port`):
- Everything still works
- Agents run in background
- You only see final results

---

## Navigation

| Keys | Action |
|------|--------|
| `Ctrl+B` then arrow keys | Switch between panes |
| `Ctrl+B z` | Zoom/unzoom current pane |
| `Ctrl+B d` | Detach (keep running in background) |
| `tmux attach` | Reattach later |

---

## Troubleshooting

**Panes not spawning?**
1. Verify you're in tmux: `echo $TMUX` (should return something)
2. Verify port flag: `opencode --port 4096`
3. Check config has tmux enabled in `oh-my-opencode-slim.json`

---

## Current Config

```json
"tmux": {
  "enabled": true,
  "layout": "main-vertical",
  "main_pane_size": 60
}
```

- `main-vertical`: Your session on left (60%), agents stack on right
- Other layouts: `main-horizontal`, `tiled`, `even-horizontal`, `even-vertical`
