---
description: Process and organize the Knowledge Vault landing zones (Inbox, FileMe, and Working Memory)
---

# org-bot-clear-inbox

Process and organize the Knowledge Vault landing zones (`~/Vaults/Knowledge/Inbox/`, `~/Vaults/Knowledge/FileMe/`, and the "Working Memory" section of `~/Vaults/Knowledge/Knowledge.org`).

## Goal
Empty the landing zones by moving files or snippets to their permanent homes in `Areas/` or `Projects/` (or `~/Vaults/Home`) based on the structure defined in `org-bot-capture`.

## Workflow
1. **Audit**: 
   - List all files in `~/Vaults/Knowledge/Inbox/` and `~/Vaults/Knowledge/FileMe/`.
   - Scan `~/Vaults/Knowledge/Knowledge.org` for a `* Working Memory` header and list its contents.
2. **Analyze**: Read contents of each file or snippet to determine its topic and nature (Knowledge vs Project vs Home).
3. **Propose**: Present a mapping to the user:
   - `inbox-file.md` $\to$ `Areas/Programming/Languages/Rust/topic.md`
   - `idea-x.md` $\to$ `Projects/Staging/IdeaX/IdeaX.org`
   - `snippet-y` $\to$ `~/Vaults/Home/topic.md`
4. **Execute**: Move the files or extract/relocate the Org snippets only after user confirmation.

## Decision Logic
Refer to `org-bot-capture/SKILL.md` for folder conventions:
- **Areas/**: Evergreen, subject-based knowledge.
- **Projects/**: Time-bound, goal-oriented work.
- **Home**: Personal/General vault (`~/Vaults/Home`).
- **Naming**: Ensure files remain `lower-kebab-case` and folders are `CamelCase`.

## Completion
Once the landing zones and Working Memory are empty, report a summary of where items were moved.
