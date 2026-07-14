---
description: "Help user re-orient to a project after a break using git and unix tools to synthesize current state"
---

## Goal
Minimize cognitive load when resuming work. Provide a "Resumption Report" that summarizes what was happening, what is currently changed, and what needs doing next. **All operations must be restricted to the current working directory.**

## Process

### 1. Gather Context
Run the following tools relative to the project root:
- **Git State**:
    - `git branch --show-current`: Identify active branch.
    - `git status`: See uncommitted changes.
    - `git diff`: Analyze exact lines changed in working directory.
    - `git log -n 5 --graph --oneline`: Review recent commit history.
    - `git reflog -n 10`: Check recent head movements if log is insufficient.
- **File Activity**:
    - `find . -maxdepth 4 -mmin -1440 -type f -not -path '*/.*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*'`: Find files modified in last 24 hours (limiting depth to avoid rabbit holes).
    - `ls -lt | head -n 20`: List most recently modified files in CWD.
- **Task Markers**:
    - Prefer `git grep -nE "TODO|FIXME|HACK"` to automatically respect `.gitignore` and project boundaries.
    - Fallback: `grep -rnE "TODO|FIXME|HACK" . --exclude-dir={.git,.pixi,node_modules,__pycache__,.venv}`.
    - Check for common notes files: `TODO.md`, `NOTES.md`, `scratchpad.txt`.

### 2. Synthesize "Resumption Report"
Present findings in this structure, **prioritizing the most recent activity**:

- **Immediate Delta (The "Right Now")**: 
    - Focus on `git diff` and files modified in the last few hours.
    - "You were just working on X in file Y."
- **Recent History (The "Last Session")**: 
    - Summary of the last 1-3 commits and files modified in the last 24h.
    - "Last commit finished Z. You've also touched A and B recently."
- **Pending Tasks**: 
    - List found `TODO`s or notes, especially those in files modified recently.
- **Current Context**: Branch name and state (dirty/clean).

### 3. Propose Next Step
Based on the synthesis:
- If there is a clear `TODO` in a modified file $\rightarrow$ Suggest tackling that.
- If the `diff` looks incomplete (e.g., function signature changed but not called) $\rightarrow$ Suggest completing the refactor.
- If state is clean $\rightarrow$ Suggest reviewing the last commit or checking the issue tracker.

## Guidelines
- Be concise.
- Use bullet points for readability.
- Don't just dump tool output; interpret it into a narrative of "where we are".
