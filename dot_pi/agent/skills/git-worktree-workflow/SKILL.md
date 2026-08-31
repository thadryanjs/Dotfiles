---
description: Work autonomously in a dedicated git worktree, one draft PR per task, never two open PRs on the same file
---

# Worktree Agent Skill

You work in a dedicated git worktree. Other agents have their own. The human
works in the main checkout, reviews your PRs, and is the only one who merges.

**The one rule that matters: never open a PR touching a file that another open
PR already touches.** Two open PRs on the same file conflict on merge, and
every merge after that stales the rest. Everything below serves that rule.

## You Communicate Only Through Commits

Every change you make — additions, edits, deletions — must be a commit in this
repository, so the human can review and revert it.

- Commit before you stop, even for incomplete work. A WIP commit is reviewable;
  a dirty working tree is not.
- Commit **often and granularly**. Small commits are what make review readable.
  The human walks your commits one at a time; one commit per logical idea.
- Never discard changes: no `rm` on untracked files, no `git checkout -- <file>`,
  no `git reset --hard`. Only ever add commits.
- If something you need to do can't be expressed as a commit in this repo —
  installing a package, writing outside the repo, editing a gitignored file —
  stop and ask.

## Your Boundaries

```
<Repo>/                # human's checkout — NEVER touch
<Repo>-agent1/         # a worktree — not yours unless you're in it
<Repo>-agent2/         # another agent's worktree
```

Work only in the directory you were started in. Never `cd` into the main
checkout or another worktree.

## Forbidden Commands

| Command | Why |
|---------|-----|
| `git merge` | Merging is the human's decision, made in review |
| `git push` to `master` | Nothing reaches master except through a reviewed PR |
| `git reset --hard` | Destroys work that may not be recoverable |
| `git push --force` (bare) | Use `--force-with-lease` on your own branch only |
| `git worktree add/remove` | Isolation boundaries are set up by the human |
| `rm`, `git checkout --` | Discards work instead of committing it |
| Anything writing to `$HOME` | Escapes git's ability to undo it |

`git rebase origin/master` and `git push --force-with-lease` on your own branch
are allowed.

## The Per-Task Loop

You are given an issue number.

### 1. Check what files are already claimed

```bash
gh pr list --json number,title,files --jq '.[] | "\(.number) \(.title) \(.files[].path)"'
```

If any file you need to edit appears in that list, **stop** and report which PR
is blocking you. Do not start. The human will either wait for it to merge or
give the task to whoever owns that file.

### 2. Start from current master

```bash
git fetch && git checkout -b <task-name> origin/master
```

`origin/master` is not optional. A plain `git checkout -b <name>` branches off
whatever you were last on — usually the previous task's branch — and your PR
will carry commits that don't belong to this task.

Name the branch from the issue: `agent1-31-transparency-receipts`.

### 3. Read the spec

```bash
gh issue view <n>
```

The issue states the task, which files are in scope, and any fixed contract:
what your code reads and writes, column names, dtypes, paths. **Documented
contracts are fixed.** If the task appears to require changing one, stop and
ask — other code depends on it.

### 4. Do the work

Stay inside the scope the issue gave you. Commit as you go, one idea per commit.
If the task genuinely needs a file outside your scope, stop and say so.

### 5. Verify

Run the relevant tests or pipeline step. Use committed fixture data with
repo-relative paths, so it runs identically in any worktree. Do not open a PR
until it passes.

If a path fails, check whether it's hardcoded to an absolute location — those
read from the human's checkout, not yours. Report it rather than working around it.

### 6. Open a draft PR

```bash
git push -u origin <task-name>
gh pr create --draft -t "<primary-file>: <what it does>" -l "file:<primary-file>"
```

- **Draft**, always. The human marks it ready when they're about to review it.
- **Title prefixed with the primary file**, e.g. `03_model.py: print class
  balance per split`. This makes collisions visible at a glance.
- **Label `file:<path>` for each file you touched.** This is what the next
  agent's check in step 1 reads.
- Body states what changed and why, anything you were unsure about, and
  `Closes #<n>`.

### 7. Stop

Wait for the next task. Do not merge, do not clean up, do not start anything else.

## If You Were Blocked

If step 1 blocked you and the human later tells you the blocking PR merged:

```bash
git fetch && git rebase origin/master
```

Then re-run your verification before opening the PR. The rebase makes your
branch current; the test run is what says it's still correct.

## When Master Has Moved

Only merged work is real. A pushed branch — yours or another agent's — is a
proposal and is not on master.

If your branch needs updating:

```bash
git fetch && git rebase origin/master
git push --force-with-lease
```

The push is not optional after a rebase. The rebase rewrote your commits, so
without pushing, GitHub still shows the old ones and the PR can't merge cleanly.

Symptom to watch for: the change you're asked to make appears already done, or
something the issue says exists is missing. That means your branch predates a
merge — rebase before concluding anything.

## Shared Files

`todo.md`, spec files, and contract files are **read-only** to you. They are
tracked, so your worktree has its own copy, but the human is the only writer.
Never commit a change to them — several branches editing one file means every
PR after the first conflicts.

## Stop And Ask

Stop rather than proceeding when:

- a file you need already has an open PR (step 1)
- the task needs code outside the scope the issue gave you
- the task requires changing a documented contract
- a forbidden command is the only way forward
- the repository state doesn't match what the issue describes
- you can't verify your own work
- a change can't be expressed as a commit in this repo

Reporting a blocker is a successful outcome. Producing something plausible
that works around a boundary is not.

---

# Reference: What The Human Is Doing

Not yours to run — some of it is forbidden above. Here so you understand the
shape of the workflow.

Because no two open PRs touch the same file, every PR merges cleanly in any
order. The human works down the queue at whatever pace, marking drafts ready
and merging, and never has to rebase anything.

```bash
# setup, once per agent
git worktree add ../Agent1 -b agent1-init

# handing out work
gh issue create -t "..." -b "Scope: 03_model.py. Contract: ..." -l agent-01

# seeing what's claimed
gh pr list --json number,title,files --jq '.[] | "\(.number) \(.title) \(.files[].path)"'

# review — gh-dash in the main checkout
#   r refresh · d diff in Hunk · W mark draft ready · m merge
#   (the checkout key fails: the branch is already in a worktree)

# after merging
git checkout master && git pull

# end-to-end run, after a batch of merges
# per-branch green does not mean merged-together green

# teardown
git worktree remove ../Agent1
git branch -D agent1-init     # -D: rebase-merge rewrites SHAs
```

Worktree facts: a branch can be checked out in only one worktree at a time;
`git fetch` is repo-wide but each worktree must `checkout` to move; hardcoded
absolute paths read from the main checkout regardless of which worktree runs
the code.

gh-dash reads only `pager.diff` in `~/.config/gh-dash/config.yml` — it ignores
`core.pager` and `GH_PAGER`.

The human reads state, not just deltas — `git show <sha>:path/to/file` or
`tig`'s tree view — because a diff says what changed, not what the code now is.
Granular commits and clear PR descriptions are what make that cheap.
