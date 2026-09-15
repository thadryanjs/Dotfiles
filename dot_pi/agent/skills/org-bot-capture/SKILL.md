---
description: Capture and file knowledge or tasks into the WorkVault knowledge base
---

# org-bot-capture

Quickly stash notes, code snippets, tasks, and knowledge into the WorkVault knowledge base.

## Capture Points

### 1. The Queue (Capture & Refocus)
For items that need to be documented before they are forgotten or become rabbit holes:
- **Main capture point**: The "Queue" tab of `@~/Vaults/Knowledge/WorkVault.org`.
- **Format**: Give a brief, descriptive title to the TODO.
- **Priority**: Assume priority is `[#B]` unless otherwise specified.
- **Elaboration**: Use the standard org mode NOTE convention to elaborate on what was tried and what to consider next.

### 2. The Vault (Direct Filing)
For structured knowledge:
- **Markdown (`.md`)**: Documentation, how-tos, explanations.
- **Org mode (`.org`)**: Todos/Tasks with `** Queue` header.
- **Code snippets**: Markdown with code blocks OR language-specific files.

## Vault Structure

```
~/Vaults/Knowledge/
├── Inbox/                    # Landing zone for uncertain placements
├── Areas/                    # Subject knowledge (evergreen)
│   ├── Programming/          # Language-specific knowledge
│   │   ├── Languages/        # C, C++, Python, R, Rust, etc.
│   │   └── CachingAndMemoization/
│   ├── Tooling/              # Tools & software
│   │   ├── Vim/Neovim/
│   │   ├── Orgmode/
│   │   ├── Tmux/
│   │   ├── Jupyter/
│   │   ├── Pi/
│   │   └── ...
│   ├── Linux/                # Distro-specific notes
│   │   ├── Arch/
│   │   ├── Fedora/
│   │   └── HPC/
│   ├── MachineLearning/
│   ├── Biology/
│   └── ...
├── Projects/                 # Active work (time-bound)
│   ├── Primary/              # High priority
│   ├── Secondary/            # Medium priority
│   └── Staging/              # Low priority / exploration
├── Scripts/                  # Shell scripts (CamelCase dirs)
│   ├── Apps/
│   ├── Dartmouth/
│   ├── Maintenance/
│   └── Tools/
└── Dotfiles/                 # Dotfiles integrated here
```

## Conventions

### Folders
- **CamelCase**: `MyFolder`, `ParseHTML`, `HPC` (acronyms full caps)
- **No spaces**: Use CamelCase or kebab-case for subfolders

### Files
- **lower-kebab-case**: `my-note.md`, `config-issue.org`
- **Org files match folder name**: `Projects/Primary/MyProj/MyProj.org`

## Decision Tree

**What type of content?**

| Content | Location | Format |
|---------|----------|--------|
| Language syntax/patterns | `Areas/Programming/Languages/<Lang>/` | `.md` or `.org` |
| Tool usage/config | `Areas/Tooling/<Tool>/` | `.md` or `.org` |
| Distro issues | `Areas/Linux/<Distro>/` | `.md` |
| Research notes | `Areas/<Subject>/` | `.md` |
| Active project work | `../Projects/Work/{Primary,Secondary,Staging}/<Project>/` | `.org` for todos |
| General learning | `Areas/<Subject>/general.md` | `.md` |

**Is this a project or knowledge?**

- **Project** (time-bound, specific goal) $\to$ `Projects/{Primary,Secondary,Staging}/`
- **Knowledge** (evergreen, reusable) $\to$ `Areas/`
- **Unsure?** $\to$ `Inbox/` (Always notify the user when using the Inbox)

## Quick Add Commands

### 1. Add a Note to Programming Knowledge
`~/Vaults/Knowledge/Areas/Programming/Languages/<Language>/<topic>.md`

### 2. Add a Tool Note
`~/Vaults/Knowledge/Areas/Tooling/<ToolName>/<topic>.md`

### 3. Add a Linux/Distro Note
`~/Vaults/Knowledge/Areas/Linux/<Distro>/<issue>.md`

### 4. Add a TODO to Queue
Find the relevant `.org` file and add under `** Queue` header.

## Examples

### Adding a Python decorator note
```bash
echo "# Python Decorators

## Syntax
\`\`\`python
@decorator
def func():
    pass
\`\`\`
" > ~/Vaults/Knowledge/Areas/Programming/Languages/Python/Decorators.md
```

### Adding an Arch Linux issue
```bash
echo "# Kernel Update Broke Boot

## Symptoms
- GRUB shows error
- Can't load kernel

## Fix
\`\`\`bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
\`\`\`
" > ~/Vaults/Knowledge/Areas/Linux/Arch/kernel-update-fix.md
```
