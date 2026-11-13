---
name: agentic-workflow-logging
description: "Lightweight session logging for easy pickup and transparency. Focuses on high-level conceptual shifts and state recovery over granular activity."
compatibility: opencode
---

# agentic-workflow-logging

Maintain a session log in `context/log.md` to ensure any agent (or human) can resume work instantly without parsing git history or guessing intent.

## Log Format

New entries go at the **top** of `context/log.md`. Push old entries down.

```yaml
YYYY-MM-DD:
    summary: One sentence overview of the session.
    conceptual: High-level shifts in approach, restructuring, or architecture decisions.
    events:
        - Created [file/component]
        - Edited [file] to [do x]
    key files: [List of load-bearing files edited; not a full git status]
    resume: Last commands run, pending tasks, and environment state (e.g., "Running on GPU server X").
```

## Guidance

- **Small Sessions**: If the work was trivial, a single `summary` line is enough.
- **Pickup First**: The `resume` section is the most critical—it should allow the next agent to pick up exactly where you left off.
- **Load-Bearing Only**: In `key files`, list only the files that define the logic or contract, not every single boilerplate file.
- **Frequency**: Update the log at the end of a session or after a significant conceptual pivot.
- **Breaks**: If user mentions taking a break, ask if log entry is needed.
