# OpenCode Configuration Guide

## How to Disable oh-my-opencode Plugin

To run OpenCode without the oh-my-opencode plugin:

### Option 1: Remove from config
Edit your `opencode.json` file and remove the plugin from the `plugin` array:

```json
{
  "plugin": []
}
```

### Option 2: Comment out in JSONC
If you use `opencode.jsonc`, you can comment out the plugin:

```jsonc
{
  // "plugin": [
  //   "oh-my-opencode@latest"
  // ]
}
```

### Option 3: Use a different config profile
Create a new profile without the plugin:

```bash
opencode profile create no-omo
```

Then edit the new profile's config to remove the plugin.

## How to Update oh-my-opencode

To update the oh-my-opencode plugin to the latest version:

```bash
bun update
```

This will check for newer versions of all dependencies including `@opencode-ai/plugin` and update your `bun.lock` file accordingly.

To update a specific package:

```bash
bun update @opencode-ai/plugin
```

After updating, restart OpenCode to apply the changes.

## How to Suppress Ghost Text

The ghost text `"[config-context] getConfigContext() called before initConfigContext(); defaulting to CLI paths."` comes from the oh-my-opencode plugin. To fix it:

1. **Remove the plugin** (as above)
2. **Update the plugin** to a newer version if available
3. **Use a different plugin** if you need extended features

## Important Notes

- OpenCode supports both `.json` and `.jsonc` (JSON with Comments) formats
- `.jsonc` is checked before `.json` for config files
- The ghost text is a bug in oh-my-opencode — removing the plugin is the most reliable fix

## Example: Config without oh-my-opencode

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "*": "deny",
    "read": "allow",
    "write": "allow",
    "edit": "allow",
    "list": "allow",
    "glob": "allow",
    "grep": "allow",
    "webfetch": "allow",
    "todoread": "allow",
    "todowrite": "allow",
    "task": "allow",
    "lsp": "allow",
    "websearch": "allow",
    "codesearch": "allow",
    "skill": {
      "*": "allow",
      "internal-*": "deny",
      "experimental-*": "ask"
    },
    "call_omo_agent": "allow",
    "background_output": "allow",
    "background_cancel": "allow",
    "look_at": "allow",
    "interactive_bash": "allow",
    "skill_mcp": "allow",
    "session_list": "allow",
    "session_read": "allow",
    "session_search": "allow",
    "session_info": "allow",
    "task_create": "allow",
    "task_get": "allow",
    "task_list": "allow",
    "task_update": "allow",
    "ast_grep_search": "allow",
    "ast_grep_replace": "allow",
    "lsp_diagnostics": "allow",
    "lsp_prepare_rename": "allow",
    "lsp_rename": "allow",
    "lsp_goto_definition": "allow",
    "lsp_find_references": "allow",
    "lsp_symbols": "allow",
    "bash": {
      "*": "allow",
      "rm *": "ask",
      "rm -rf *": "ask",
      "docker *": "ask",
      "ssh *": "ask",
      "git push *": "ask",
      "git push --force *": "deny",
      "git rebase *": "ask",
      "git reset --hard *": "ask"
    }
  },
  "provider": {
    "Dartmouth": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Dartmouth Chat",
      "options": {
        "baseURL": "https://chat.dartmouth.edu/api",
        "apiKey": "{env:DARTMOUTH_CHAT_API_KEY}"
      },
      "models": {
        "openai.gpt-oss-120b": {
          "name": "GPT-OSS 120b",
          "attachment": true,
          "reasoning": true,
          "tool_call": true
        },
        "qwen.qwen3-vl-32b-instruct-fp8": {
          "name": "Qwen3-VL 32b",
          "attachment": true,
          "tool_call": true
        },
        "anthropic.claude-haiku-4-5-20251001": {
          "name": "Claude Haiku 4.5 2025-10-01",
          "attachment": true,
          "reasoning": true,
          "tool_call": true
        },
        "anthropic.claude-sonnet-4-5-20250929": {
          "name": "Claude Sonnet 4.5 2025-09-29",
          "attachment": true,
          "reasoning": true,
          "tool_call": true
        },
        "anthropic.claude-opus-4-6": {
          "name": "Claude Opus 4.6",
          "attachment": true,
          "reasoning": true,
          "tool_call": true
        },
        "mistral.mistral-large-2512": {
          "name": "Mistral Large 3",
          "attachment": true,
          "tool_call": true
        },
        "mistral.devstral-2512": {
          "name": "Mistral Devstral 2",
          "attachment": true
        }
      }
    }
  },
  "skills": {
    "paths": [
      "./skills"
    ]
  },
  "plugin": []
}
```

## Quick Fix for Ghost Text

The ghost text will disappear when you remove the oh-my-opencode plugin. To do this immediately:

1. Run: `opencode config set plugin []`
2. Restart OpenCode

This will remove the plugin and eliminate the ghost text.

## Switching Between Model Providers (Dartmouth vs Copilot)

### The Problem
When using the `opencode-weave` plugin for intelligent model routing, you may want to switch between different model providers (e.g., Dartmouth vs Copilot) based on which service has available tokens.

### The Solution
Use separate weave config files and a shell script to switch between them:

**Files:**
- `weave-opencode-dartmouth.jsonc` - Dartmouth-only model configuration
- `weave-opencode-copilot.jsonc` - Copilot-only model configuration
- `weave-opencode.jsonc` - Symlink to active config (git-tracked)
- `~/.scripts/apps/opencode/opencode-weave-switch-config.sh` - Switcher script

**Usage:**
```bash
# Switch to Dartmouth models
~/.scripts/apps/opencode/opencode-weave-switch-config.sh dartmouth

# Switch to Copilot models
~/.scripts/apps/opencode/opencode-weave-switch-config.sh copilot

# Check which provider is active
~/.scripts/apps/opencode/opencode-weave-switch-config.sh status
```

**Optional alias** (add to `.bashrc`, `.zshrc`, etc.):
```bash
alias opencode-weave-switch='~/.scripts/apps/opencode/opencode-weave-switch-config.sh'
```

Then use: `opencode-weave-switch dartmouth` or `opencode-weave-switch copilot`

**How it works:**
- The script creates a symlink from `weave-opencode.jsonc` to the selected provider config
- The symlink is tracked in git, so you can see which provider is active
- Weave plugin reads the symlinked config on startup
- No copying files, no manual edits needed

**Why this approach:**
- Declarative: Both configs are version-controlled
- Clean: One command to switch providers
- Visible: Git shows which provider is active via the symlink
- Fast: No manual file editing or copying
