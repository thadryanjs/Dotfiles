---
description: Work autonomously in a dedicated git worktree, one branch and PR per task
---

# Worktree Agent Skill

You work in a dedicated git worktree on this repository. Other agents may have
their own worktrees. The human works in the main checkout, reviews your PRs,
and is the only one who merges.

The human serializes: they review one PR, merge it, then hand out the next
task. You never have to coordinate with another agent directly — but you do
have to start from current main and stop when you hit a boundary.

## Your Boundaries

```
~/Vaults/Projects/<Repo>/              # human's checkout — NEVER touch
~/Vaults/Projects/<Repo>-agent1/       # a worktree — not yours unless you're in it
~/Vaults/Projects/<Repo>-agent2/       # another agent's worktree
```

You work only in the directory you were started in. You never `cd` into the
main checkout or another worktree.

Which files you may edit comes from the issue, not from this file. If another
agent has an open PR touching the same code, the human will have told you.

## Forbidden Commands

| Command | Why |
|---------|-----|
| `git merge` | Merging is the human's decision, made in review |
| `git push` to `main` | Nothing reaches main except through a reviewed PR |
| `git reset --hard` | Destroys work that may not be recoverable |
| `git push --force` | Rewrites shared history |
| `git worktree add/remove` | Isolation boundaries are set up by the human |
| Anything writing to `$HOME` | Escapes git's ability to undo it |

`git rebase origin/main` **is** allowed — it only affects your own worktree.

## The Per-Task Loop

You are given an issue number. Run these steps in order.

### 1. Start from current main

```bash
git fetch && git checkout -b <task-name> origin/main
```

`origin/main` is not optional. A plain `git checkout -b <name>` branches off
whatever you were last on — usually the previous task's branch — and your PR
will carry commits that don't belong to this task.

Name the branch from the issue: `agent1-14-retry-logic`.

### 2. Read the spec

```bash
gh issue view <n>
```

The issue states the task, which files are in scope, and any fixed contract:
what your code reads and writes, column names, dtypes, paths. **Documented
contracts are fixed.** If the task appears to require changing one, stop and
ask — other code may depend on it.

### 3. Do the work

Stay inside the scope the issue gave you. If the task genuinely needs more than
that, stop and say so rather than expanding on your own.

### 4. Verify

Run the relevant tests or pipeline step. Use committed fixture data with
repo-relative paths, so it runs identically in any worktree. Do not open a PR
until it passes.

If a path fails, check whether it's hardcoded to an absolute location — those
read from the human's checkout, not yours. Report it rather than working around it.

### 5. Commit and open the PR

```bash
git commit
git push -u origin <task-name>
gh pr create
```

The PR body must state:
- what changed and why
- anything you were unsure about
- `Closes #<n>`

One commit per logical change. Never mix a refactor with a behavior change.
The commit subject is the idea; the body is the reasoning.

### 6. Stop

Wait for the next task. Do not merge, do not clean up, do not start anything else.

## When Main Has Moved

Only merged work is real. A pushed branch — yours or another agent's — is a
proposal and is not on main.

If a merge landed while you were working:

```bash
git fetch && git rebase origin/main
```

Then **re-run your verification**. The rebase makes your branch current; the
test run is what checks it's still correct. Merged changes elsewhere can break
your code without producing any conflict.

Symptom to watch for: the change you're asked to make appears already done, or
something the issue says exists is missing. That means your branch predates a
merge — rebase before concluding anything.

## Shared Files

`todo.md`, contract files, and specs are **read-only** to you. They are tracked,
so your worktree has its own copy, but the human is the only writer. Never
commit a change to them — several branches editing one file means every PR
after the first conflicts.

## Stop And Ask

Stop rather than proceeding when:

- the task needs code outside the scope the issue gave you
- the task requires changing a documented contract
- a forbidden command is the only way forward
- the repository state doesn't match what the issue describes
- you can't verify your own work

Reporting a blocker is a successful outcome. Producing something plausible
that works around a boundary is not.

---

# Reference: What The Human Is Doing

Not yours to run — some of it is forbidden above. Here so you understand the
shape of the workflow.

The loop is serialized on purpose: **review → merge → rebase → hand off the
next task.** There is one reviewer, so PRs land one at a time. That is what
keeps parallel work safe, more than any ownership rule.

```bash
# setup, once per agent
git worktree add ../<Repo>-agent1 -b agent1-init

# handing out work
gh issue create -t "..." -b "Contract: ..." -l agent-01

# review — gh-dash in the main checkout
#   d = diff in Hunk, m = merge, r = refresh
#   (checkout key fails: the branch is already in a worktree)

# after merging
git checkout main && git pull

# teardown
git worktree remove ../<Repo>-agent1
git branch -d agent1-init
```

Worktree facts worth knowing: a branch can be checked out in only one worktree
at a time; `git fetch` is repo-wide but each worktree must `checkout` to move;
hardcoded absolute paths read from the main checkout regardless of which
worktree runs the code.

The human reads state, not just deltas — `git show <sha>:path/to/file` or
`tig`'s tree view — because a diff says what changed, not what the code now is.
Clear PR descriptions are what make that cheap.
