---
name: agentic-workflow-core
description: "Core rules for working autonomously in this repo — one ticket, one file, one branch, one PR. Create your own git worktree named for the ticket, claim it by pushing the branch, never edit outside the ticket's file. Use this at the start of every task in this repo, and whenever creating a worktree, picking up a ticket, or opening a PR."
---

# agentic-workflow-core

This repo operates in two modes:

1. **Human as Driver**: Human codes or supervises closely. Rigid worktree/branch rules are optional. Workflow focuses on breaking work into tickets with corresponding comprehension tasks to maintain speed and loop discipline.
2. **Human as Supervisor**: Human supervises agents. Full `agentic-workflow-core` rules are strictly enforced (one ticket, one file, one branch, one PR).

**General Rule**: Every significant ticket should have a corresponding comprehension ticket. Small or trivial changes are exempt. This ensures the human's mental model evolves alongside the code.

For "Human as Supervisor" work: You take one ticket, work it in your own worktree, and open one PR. The human reviews and is the only one who merges.

**Core Invariant: No two open PRs may touch the same file.**

That chain is the whole design. Because each ticket names exactly one file, and
each branch is named for its ticket, no two open PRs touch the same file, so they
merge cleanly in any order and nothing needs rebasing.

## Layout

```
repo/                  # main checkout — read here, never edit or commit here
  context/
    overview.md        # read first
    spec/main.md       # contracts
    tickets/
      open/            # available work
      closed/          # done — the human moves them here after merging
worktrees/             # yours goes here, sibling of repo/
```

Everything under `context/` is tracked, so your worktree has its own copy. That
makes all of it **read-only to you**, including moving a ticket between `open/`
and `closed/`. See Shared Files.

## You Communicate Only Through Commits

Every change — additions, edits, deletions — must be a commit, so the human can
review and revert it.

- Commit before you stop, even for incomplete work. WIP commits are reviewable;
  dirty trees are not.
- Commit **often and granularly**. The human walks your commits one at a time;
  one commit per logical idea.
- Never discard changes: no `rm` on untracked files, no `git checkout -- <file>`,
  no `git reset --hard`. Only ever add commits.
- If something you need can't be expressed as a commit in this repo — installing
  a package, writing outside the repo, editing a gitignored file — stop and ask.

## Forbidden

| Command | Why |
|---------|-----|
| `git merge` | Human decision |
| `git push` to the base branch | Nothing reaches it except through a reviewed PR |
| `git reset --hard` | Destroys work that may not be recoverable |
| `git push --force` (bare) | Use `--force-with-lease` on your own branch only |
| `rm`, `git checkout --` | Discards work instead of committing it |
| Editing anything in `repo/` | That's the human's checkout. Read only. |
| Editing or moving anything under `context/` | Shared files (except `log.md`) — one writer, not you |
| Anything writing to `$HOME` | Escapes git's ability to undo it |
| Deleting prose in notebooks | **CATASTROPHIC FAILURE.** Notebook prose is the narrative; deleting it destroys the project's value. |
| Hardcoding results | **ABSOLUTE FORBIDDEN.** Hardcoding a result (e.g., `print(f"Result: 1.02")`) instead of calculating it is a lie. It is a total failure of integrity and an automatic hard fail. |

`git worktree add`, `git rebase "origin/$BASE"`, and `--force-with-lease` on your
own branch are yours to run.

## The Loop

### 1. Determine base branch (never assume `main`/`master`):

```bash
BASE=$(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name)
# fallback:
BASE=$(git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@')
```

If neither works, **stop and ask.** Don't guess, don't try one then the other —
a wrong base poisons every command after it.

### 2. Pick an unclaimed ticket

A pushed branch is a claim, and branch names match ticket filenames, so the
unclaimed tickets are the difference between the two lists:

```bash
git fetch
comm -23 \
  <(ls context/tickets/open/*.md | xargs -n1 basename | sed 's/\.md$//' | sort) \
  <(git ls-remote --heads origin | sed 's@.*refs/heads/@@' | sort)
```

Take one of those, or the one you were handed — but if it isn't in that list,
it's already claimed, so stop and ask.

### 3. Worktree and claim

From inside `repo/`, using the ticket's filename without `.md` as the slug:

```bash
SLUG=03-class-balance
git worktree add "../worktrees/$SLUG" -b "$SLUG" "origin/$BASE"
cd "../worktrees/$SLUG"
git commit --allow-empty -m "start $SLUG"
git push -u origin "$SLUG"
```

- **Slug must match ticket filename exactly (no agent name/date/prefix) to remain visible to other agents.**
- **`origin/$BASE` is not optional.** Without it the worktree branches off
  whatever `repo/` has checked out.
- **Push before working.** An unpushed branch claims nothing.
- The worktree is a sibling of `repo/`, never inside it.
- Never check out the base branch or a branch you didn't create — it's checked
  out in `repo/`, so it will fail. **If a checkout fails because a branch is in
  use by another worktree, stop and report it. Do not invent a substitute branch.**

Work only in your own worktree from here. Don't `cd` back to `repo/` to edit,
don't touch another agent's worktree.

### 4. Read the spec

Read `context/overview.md`, the ticket, and whatever under `context/spec/` it
points to. The ticket states the task, **the one file in scope**, and any fixed
contract: what your code reads and writes, column names, dtypes, paths.

**Documented contracts are fixed.** If the task appears to require changing one,
stop and ask — other code depends on it.

### 5. Work, then verify

Edit **only the file the ticket names.** If the change genuinely needs a second
file, stop and ask — that's a ticket-scoping problem for the human to resolve,
not something to work around. Commit as you go, one idea per commit.

Run the relevant tests or pipeline step before opening anything. Use committed
fixture data with repo-relative paths so it runs identically in any worktree. If
a path fails, check whether it's hardcoded absolute — those read from `repo/`,
not your worktree. Report it rather than working around it.

### 6. Open the PR

```bash
git push
gh pr create --base "$BASE" \
  -t "<file>: <what it does>" \
  -b "<what changed and why>

Ticket: context/tickets/open/$SLUG.md"
```

- **`--base "$BASE"` explicitly** — without it `gh` targets the repo default,
  which may not be what you built on.
- **Title prefixed with the file**, e.g. `03_model.py: print class balance per
  split`.
- Body says what changed, anything you were unsure about, and the ticket path.

Then check the base took:

```bash
gh pr view <n> --json baseRefName
```

If it isn't `$BASE`: `gh pr edit <n> --base "$BASE"`.

**If another open PR already touches your file**, add `--draft` and name that PR
in the body. This shouldn't happen — one file per ticket means it only arises
when two tickets name the same file — so report it as a ticket problem, not just
a blocked task. Draft means "correct, but needs a rebase before review."

### 7. Stop

Leave the worktree in place. Don't merge, don't clean up, don't move the ticket
to `closed/` — the human does both after merging. Then wait for your next ticket.

## When The Base Branch Has Moved

Only merged work is real. A pushed branch — yours, another agent's, or the
human's — is a proposal, not on the base branch. The base moves only at merges,
so it moves in discrete steps.

When the human says the base moved, or your blocker merged:

```bash
git fetch && git rebase "origin/$BASE"
git push --force-with-lease
```

**The push is not optional.** The rebase rewrote your commits; without it GitHub
still shows the old ones and the PR can't merge cleanly.

**Re-run your verification after the rebase, even if the rebase was clean.** This
matters most on a draft PR, which exists precisely because someone else changed
your file. A clean rebase is not a passing rebase: two changes can be textually
disjoint and still disagree — a signature you changed and a caller they added, a
field you renamed and a reader they wrote. Git reports nothing. The test run is
what says you're still correct. Then tell the human it can come out of draft;
you don't mark it ready.

Symptom to watch for: the change you're asked to make appears already done, or
something the ticket says exists is missing. Your branch predates a merge —
rebase before concluding anything.

## Shared Files

Everything under `context/` is read-only to you: `overview.md`, `spec/`, and all
tickets. Your worktree has a copy because it's tracked, not because it's yours.

In particular, **never move a ticket from `open/` to `closed/`**, and never edit
one to mark it claimed or done. **Tickets are moved to `closed/`, never deleted.** Several branches moving the same file means every
PR after the first conflicts — and these are the files every branch has a reason
to touch. The human moves tickets to `closed/` when merging.

Claim by pushing your branch. Report status in the PR.

## Logging

Maintain a session log via `agentic-workflow-logging` for easy pickup. Log after conceptual pivots or before stopping.

## Stop And Ask

Stop rather than proceeding when:

- your ticket isn't in the unclaimed list (step 2)
- the change needs a file other than the one the ticket names
- the task requires changing a documented contract
- another open PR already touches your file
- a forbidden command is the only way forward
- the repo state doesn't match what the ticket describes
- you can't verify your own work
- a change can't be expressed as a commit in this repo
- you can't determine the base branch name

Reporting a blocker is a successful outcome. Producing something plausible that
works around a boundary is not.

---

# Reference: What The Human Does

Not yours to run.

```bash
# what's claimed but has no PR, or branches that aren't tickets
git ls-remote --heads origin | sed 's@.*refs/heads/@@' | while read b; do
  [ -f "context/tickets/open/$b.md" ] || echo "orphan branch: $b"
done

# after merging a PR
git checkout "$BASE" && git pull
git mv context/tickets/open/<slug>.md context/tickets/closed/
git worktree remove ../worktrees/<slug>
git branch -D <slug>                  # -D: the merge rewrote the SHAs
# then run the pipeline end to end — per-branch green ≠ merged-together green
```

Writing tickets: one file per ticket, named descriptively in hyphen-case (it
becomes a branch name and a directory name, so no spaces or `~ ^ : ? * [ \`).
Two tickets must never name the same file — that's the only thing that can
produce a collision.

Worktree facts: a branch lives in one worktree at a time; `git fetch` is
repo-wide but each worktree checks out independently; gitignored files
(`node_modules`, venvs, caches) are per-worktree and are the real cost of adding
one; `refs/stash` is shared across all worktrees; hardcoded absolute paths read
from `repo/` regardless of which worktree runs the code.
