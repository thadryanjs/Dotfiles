# Claude Opus Backup Plan

If Claude Opus usage on the Orchestrator becomes too costly, use this guide to switch to a more conservative setup.

---

## Current Setup (Opus on Orchestrator)

| Agent | Model | Provider | Cost |
|-------|-------|----------|------|
| **Orchestrator** | claude-opus-4.5 | Copilot | Uses quota |
| **Oracle** | GPT-5.3 | Dartmouth | Free |
| **Librarian** | Gemini 3.1 Flash Lite | Dartmouth | Free |
| **Explorer** | GPT-4.1-mini | Dartmouth | Free |
| **Designer** | Gemini 2.5 Flash | Dartmouth | Free |
| **Fixer** | GPT-5.1 Codex | Dartmouth | Free |

**Copilot usage:** Only Orchestrator (+ fallbacks if needed)

---

## Agent Role Explanations

### Orchestrator (claude-opus-4.5)
**Role:** Master delegator - decides which agent handles what task, coordinates multi-step workflows.

**Why Opus?** This is the "brain" that sees your request and decides how to break it down. Poor decisions here cascade into wasted work downstream. It needs:
- Strong reasoning to understand complex requests
- Good judgment on which specialist to call
- Context retention across multi-step tasks

**Verdict:** Worth the Opus tokens. A bad orchestrator decision wastes more than it saves.

### Oracle (GPT-5.3 via Dartmouth)
**Role:** Strategic advisor, architecture decisions, complex debugging, code review.

**Why GPT-5.3?** Called for "hard thinking" problems. It doesn't need the absolute best model because:
- Consulted less frequently than orchestrator
- Tasks are well-defined by the time they reach Oracle
- GPT-5.3 is excellent at reasoning tasks

### Librarian (Gemini 3.1 Flash Lite via Dartmouth)
**Role:** External documentation lookup, library research, GitHub examples.

**Why Gemini Flash Lite?** This agent mostly does web searches and doc lookups. Needs:
- Fast responses (often called multiple times)
- Good at summarizing external content
- Doesn't need deep reasoning

### Explorer (GPT-4.1-mini via Dartmouth)
**Role:** Codebase search, finding files, pattern matching, answering "where is X?"

**Why GPT-4.1-mini?** Basically a search assistant. It:
- Runs grep/glob/read operations
- Summarizes what it finds
- Doesn't need complex reasoning

### Designer (Gemini 2.5 Flash via Dartmouth)
**Role:** UI/UX, styling, responsive design, visual polish.

**Why downgraded?** For data science projects, you rarely need a Designer agent. Kept on cheap Dartmouth model.

### Fixer (GPT-5.1 Codex via Dartmouth)
**Role:** Fast implementation - receives a spec and writes code.

**Why GPT-5.1 Codex?** This is the "hands" that actually writes code. Codex models are optimized for code generation.

---

## Backup Plan: Downgrade Orchestrator to Sonnet

If Opus usage is too high, edit `oh-my-opencode-slim.json`:

### Change Orchestrator model:
```json
"orchestrator": { 
  "model": "github-copilot/claude-sonnet-4.5",  // Changed from opus
  "variant": "high", 
  "skills": ["*"], 
  "mcps": ["websearch"] 
}
```

### Update fallback chain (Opus as first fallback):
```json
"chains": {
  "orchestrator": ["github-copilot/claude-opus-4.5", "Dartmouth/openai_responses.gpt-5.3-chat-latest"],
  ...
}
```

This way Opus only kicks in if Sonnet fails or times out.

---

## Quick Reference: Manual Agent Invocation

For quick tasks that don't need full orchestration overhead:

### Ask the main model directly
Just type your question - the main model handles simple requests without agent delegation.

### Invoke specific agents
```
/task explorer "Find all files that import numpy"
/task librarian "How do I use polars lazy frames?"
/task oracle "Review this architecture decision..."
/task fixer "Implement function X with spec Y"
```

### Available Agents
| Agent | Use Case |
|-------|----------|
| `explorer` | Find files, search codebase, "where is X?" |
| `librarian` | External docs, library research, GitHub examples |
| `oracle` | Architecture advice, debugging, code review |
| `designer` | UI/UX work (rarely needed for data science) |
| `fixer` | Quick implementation tasks |

### When to use which approach
- **Simple question** → Ask directly (no agent)
- **Find something in codebase** → `/task explorer`
- **Look up library docs** → `/task librarian`
- **Complex multi-step task** → Let Orchestrator decide (just describe what you need)

---

## Switching Presets via Environment Variable

To temporarily use a different preset without editing config:

```bash
export OH_MY_OPENCODE_SLIM_PRESET=my-other-preset
opencode
```

---

## Related Files
- `oh-my-opencode-slim.json` - Main config
- `oh-my-opencode.json.bkup` - Old oh-my-opencode config (archived)
- `opencode.json` - Base OpenCode config with Dartmouth provider
