---
description: Keep the Knowledge vault tidy and functional
---

## General protocols
- Don't delete anything
- Ask me before things are moved or merged

## Conventions
- Folders are CamelCase
    - They should start with a capital letter
    - If there is an acronym, respect the caps (starting or ending) ie, ParseHTML, VPN, HPC
    - Exception: ~/Vaults/Projects/Dotfiles/.config
        - This is a config file that's stored here and symlinked and not of these rules apply
- Files are lower-kebab-case
    - they should start with a lowercase letter
- And folder in ~/Vaults/Projects/Work/{Primary,Seconday,Staging} should have an org file
    - It should match the name of the folder it's in
    - There should be a level two header (**) called "Queue"
- Notes should be in markdown
- To-dos etc should be in the org file
- To-be-read lists (to-be-read.org) should remain as org files with:
    - `** Queue` header
    - `*** TODO` for each item
    - Tags (`:movies:`, `:articles:`) for categorization instead of headings
- If there is a file called "index.md", let me know - it will probably be moved to something called "general.md" with the folder being the obvious topic

## Checks
- Look in ~/.dotfiles/.config - if anything in this dir refers to a dir in Projects, make sure the path is up-to-date
- Any subfolders that has a .git should be a submodule and should be ignored in the root .gitignore
- If there is an index.md, let me know
- If there is a markdown file that matches the name of the dir (ie, is redundant with the org file), delete it, let me know what's in it
- If there any files that look out of place, let me know
- If there is a file that seems very specific (ie, global-open-code-session-query.md in a folder called "Tech"), let me know
    - Search the names of the folders to see where it was probably supposed to go, but don't move it until you ask me
- Any projects in ~/Vaults/Projects/Work/{Primary,Secondary,Staging} should have an org file that:
    - Matches the name of the folder it's in exactly (including case)
    - Has a level one header (*) called "Queue".
        - TODOS should start at level 2 ** and may contain subtasks
        - Queue should be the LAST level-1 header (new items go at the end)
        - This is a minimum requirement - other content is fine if you put it there
    - Note: Queue must exist, but other headers/content are allowed
    - Subtasks under TODOs (*** under **) are valid and expected
- Knowledge/Areas files (e.g., Programming/Languages/*.org) may have Queue for active learning tasks - this is acceptable

## Detritus

Report any .env or .pixi files, font files, huge folders of HTML, etc.

For example I may use a quarto project for a talk and have node_modules or something. Anything like that
