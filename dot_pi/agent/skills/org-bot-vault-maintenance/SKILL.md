---
description: Keep the Knowledge vault tidy, functional, and structurally improved
---

# org-bot-maintenance

Comprehensive maintenance and structural improvement of the Knowledge Vault.

## General protocols
- Don't delete anything
- Ask me before things are moved or merged
- When improving structure, document changes in `~/Vaults/Projects/Work/Primary/WorkVaultUpdate/folder-note-processing.md`

## Conventions
- Folders are CamelCase (start with capital, respect acronyms: `ParseHTML`, `VPN`, `HPC`)
- Files are lower-kebab-case (start with lowercase)
- Projects in `~/Vaults/Projects/Work/{Primary,Secondary,Staging}` must have a matching `.org` file:
    - Match folder name exactly (including case)
    - Must have a level one header (`*`) called "Queue" (Todos start at `**`).
    - Queue should be the LAST level-1 header.
- Notes should be in markdown; To-dos should be in the org file.
- To-be-read lists (`to-be-read.org`) remain org files with `** Queue` and tags (`:movies:`, `:articles:`).
- Rename `index.md` to `general.md` if it contains general folder notes.

## Maintenance Checks
- **Config paths**: Check `~/.dotfiles/.config` for references to Projects; ensure paths are up-to-date.
- **Submodules**: Any subfolders with a `.git` should be a submodule and ignored in root `.gitignore`.
- **Redundancy**: If a markdown file matches the name of the dir (redundant with org file), report it for deletion.
- **Misplacement**: Identify files that look out of place (e.g., specific tech notes in a general "Tech" folder) and suggest the correct location.
- **Detritus**: Report `.env`, `.pixi`, font files, or huge HTML folders (e.g., `node_modules` from Quarto projects).

## Structural Improvement & Growth

### Non-plaintext materials
Identify PDFs and non-text files. Bring them to attention to decide on conversion (e.g., using docling) to markdown.

### Linking
Once a folder is processed, look for conceptual similarities across the vault and add obsidian-style links `[[note1]] [[note2]]`.
- **Constraint**: Be stingy. Avoid overly vague links (e.g., "general-ml" $\to$ "general-stats") to avoid noise.

### Audit
Go through the Areas folder by folder and report contents to identify gaps or overlaps.
