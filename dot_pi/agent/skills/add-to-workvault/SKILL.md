---
description: File results of conversation away in an orderly fashion
---

# Add To Knowledge Vault Skill

Quickly stash notes, code snippets, and knowledge into the WorkVault knowledge base.

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

### Content Types
- **Notes/Documentation**: Markdown (`.md`)
- **Todos/Tasks**: Org mode (`.org`) with `** Queue` header
- **Code snippets**: Markdown with code blocks OR language-specific files

### Org Queue Convention
```org
* MyTopic
** Queue
*** TODO [#A] My task here
    SCHEDULED: <2026-05-12 Tue>
*** TODO [#B] Another task
```

## Quick Add Commands

### 1. Add a Note to Programming Knowledge
```bash
# For language-specific notes
~/Vaults/Knowledge/Areas/Programming/Languages/<Language>/<topic>.md

# For general programming patterns
~/Vaults/Knowledge/Areas/Programming/<pattern>.md
```

### 2. Add a Tool Note
```bash
# For specific tools
~/Vaults/Knowledge/Areas/Tooling/<ToolName>/<topic>.md

# Example: ~/Vaults/Knowledge/Areas/Tooling/Pi/new-feature.md
```

### 3. Add a Linux/Distro Note
```bash
~/Vaults/Knowledge/Areas/Linux/<Distro>/<issue>.md
# Example: ~/Vaults/Knowledge/Areas/Linux/Arch/kernel-update-issue.md
```

### 4. Add a TODO to Queue
```bash
# Find the relevant .org file
# Add under ** Queue header:
*** TODO [#A] My task
    SCHEDULED: <2026-05-12 Tue>
```

### 5. Quick CLI Capture (if script exists)
```bash
# Use the todo capture script
todo  # Opens fzf to pick file, adds to ** Queue
```

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

- **Project** (time-bound, specific goal) → `Projects/{Primary,Secondary,Staging}/`
- **Knowledge** (evergreen, reusable) → `Areas/`
- **Unsure?** $\to$ `Inbox/` (Always notify the user when using the Inbox)

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

### Adding a TODO to existing project
```bash
# Edit the project .org file
nvim ~/Vaults/Projects/Work/Primary/MyProject/MyProject.org

# Add under ** Queue:
*** TODO [#A] Implement feature X
    SCHEDULED: <2026-05-13 Wed>
```

## Maintenance

### Check for missing org files
```bash
# Every project folder should have a matching .org file
find ~/Vaults/Knowledge/Projects -type d -exec test -f {}/{}.org \; -print
```

### Check for index.md (should be general.md)
```bash
find ~/Vaults/Knowledge -name "index.md" -type f
# Rename to general.md if it's general notes
```

### Check for redundant .md/.org pairs
```bash
# If both exist, .org should have todos, .md should have notes
# Delete .md if it duplicates .org content
```

## Tips

1. **Use `general.md`** for general notes in any folder
2. **Org files for todos** - keep tasks in `.org` with `** Queue`
3. **Markdown for notes** - documentation, how-tos, explanations
4. **Be specific** - `python-decorators.md` not `python-notes.md`
5. **Link to related** - Use `[[link]]` syntax in org, markdown links in `.md`
