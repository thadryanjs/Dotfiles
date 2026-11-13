---
description: "High-level session logging for global activity across multiple projects, configurations, and general knowledge work. Maintains the global history in `~/Vaults/Knowledge/global-log.md`."
---

# general-global-logging

Maintain a high-level record of activity that transcends a single project or worktree. Use this to track progress on multiple fronts, configuration tweaks, and general system evolution.

## Target File
All entries are recorded in: `~/Vaults/Knowledge/global-log.md`

## Log Format

New entries go at the **top** of the file. Push old entries down.

```yaml
YYYY-MM-DD:
    summary: One sentence overview of the session/day.
    conceptual: High-level shifts in approach, new tools adopted, or architecture decisions.
    events:
        - Worked on [Project X]: [What was achieved]
        - Tweaked [Config/Tool]: [What changed and why]
        - Researched [Topic]: [Key finding]
    key files: [List of significant files edited across the vault or system]
    resume: Next steps, pending tasks, or environment state for the next session.
```

## Guidance

- **Scope**: Use this for "cross-cutting" work. If you spend the day jumping between three different projects and then fixing a Neovim plugin, this is where it goes.
- **Granularity**: Lower than `agentic-workflow-logging`. Focus on *outcomes* and *shifts* rather than specific code changes.
- **Pickup**: Like the project log, the `resume` section is critical for recovering context after a break from the machine.
- **Frequency**: Update at the end of a work day or after a significant batch of unrelated tasks.
