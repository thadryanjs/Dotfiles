---
description: Process and organize the Knowledge Vault landing zone
---

# clear-vault-inbox

Process and organize the Knowledge Vault landing zone (`~/Vaults/Knowledge/Inbox/`).

## Goal
Empty the Inbox by moving files to their permanent homes in `Areas/` or `Projects/` based on the structure defined in `add-to-workvault`.

## Workflow
1. **Audit**: List all files currently in `~/Vaults/Knowledge/Inbox/`.
2. **Analyze**: Read contents of each file to determine its topic and nature (Knowledge vs Project).
3. **Propose**: Present a mapping to the user:
   - `inbox-file.md` $\to$ `Areas/Programming/Languages/Rust/topic.md`
   - `idea-x.md` $\to$ `Projects/Staging/IdeaX/IdeaX.org`
4. **Execute**: Move the files only after user confirmation.

## Decision Logic
Refer to `add-to-workvault/SKILL.md` for folder conventions:
- **Areas/**: Evergreen, subject-based knowledge.
- **Projects/**: Time-bound, goal-oriented work.
- **Naming**: Ensure files remain `lower-kebab-case` and folders are `CamelCase`.

## Completion
Once the Inbox is empty, report a summary of where files were moved.
