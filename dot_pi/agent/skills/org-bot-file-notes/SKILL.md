---
description: "Route project-specific notes into the correct project files in the Work Vault"
---

# org-bot-file-notes

Route project-specific notes from input into the correct project files within the Work Vault.

## Trigger
Use when user provides a block of notes mapping updates/tasks to specific projects (e.g., "Project A: update x, Project B: check y").

## Logic
1. **Extract Projects**: Parse input to identify project names and associated notes.
2. **Locate Folder**: Search for the project folder in:
   - `~/Vaults/Projects/Work/Primary/`
   - `~/Vaults/Projects/Work/Secondary/`
   - `~/Vaults/Projects/Work/Staging/`
3. **Identify Target File**: In the found folder root, prioritize files in this order:
   - `PROJECT.org`
   - `notes.md`
   - `[FolderName].org`
   - If none found, create `PROJECT.org`.
4. **Write**: Append notes with a timestamp in the following format:
   - For `.org`: `** [timestamp] :: Note content`
   - For `.md`: `### [timestamp] \n Note content`

## Constraints
- Case-insensitive folder matching.
- If project cannot be located, list it as "Unrouted" in the final response.
- Do not overwrite existing content; always append.
