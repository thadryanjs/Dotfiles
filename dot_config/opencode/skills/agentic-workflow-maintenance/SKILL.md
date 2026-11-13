---
name: agentic-workflow-maintenance
description: "Check that context/spec/ still matches the code and that comprehension/ is current — find drift after merges, stale tickets, orphan branches, and contracts the code no longer honors. Report findings rather than fixing silently. Use after a batch of merges, when something feels out of date, or on a regular cadence."
---

# agentic-workflow-maintenance

Detect drift between spec and implementation. Report findings; do not fix silently. A spec quietly "corrected" to match
drifted code is worse than drift, because the drift was the finding.

Stale spec is the expensive kind, because `agentic-workflow-core` tells agents
documented contracts are fixed. A wrong contract isn't ignored — it's obeyed.

## Checks

### Spec vs. code

For each contract in `context/spec/`, find it in the code and confirm it holds —
paths, column names, key names, dtypes, return shapes. Grep for the literal
strings; unreferenced contracts are likely dead or renamed.

What changed since the spec last did:

```bash
git log --oneline -1 -- context/spec/           # when spec last moved
git log --oneline --since=<that date> -- . ':!context' ':!comprehension'
```

Code commits with no corresponding spec commit are where to look first.

### Closed tickets vs. spec

Walk `context/tickets/closed/` for anything merged since the spec last changed.
For each, ask whether it altered something the spec describes. A ticket that
changed an output format and didn't update the spec is the standard failure.

### Comprehension vs. code

For each `## ` section in `comprehension/*.md`, check whether its file has
changed since that doc's last commit:

```bash
git log --oneline -1 -- comprehension/<area>.md
git log --oneline --since=<that date> -- <the files it describes>
```

A section describing code that has since moved is stale. Flag it; don't rewrite
it, because the "In my own words" half belongs to the human and re-deriving it
defeats the point.

### Tickets

- Tickets in `open/` whose work appears already done — merged by another ticket,
  or obsoleted.
- Two tickets in `open/` naming the same file. This breaks the core invariant and
  should be fixed before either is picked up.
- Tickets with no verification command, or none that still runs.
- Tickets referencing files or contracts that no longer exist.

### Branches and worktrees

```bash
# claimed with no ticket behind it
git ls-remote --heads origin | sed 's@.*refs/heads/@@' | while read b; do
  [ -f "context/tickets/open/$b.md" ] || echo "orphan branch: $b"
done

git worktree list        # worktrees on merged branches, never pruned
gh pr list --draft       # drafts whose blocker merged and never got rebased
```

An orphan branch is either a merged ticket that was never tidied, or an agent
that worked something unfiled. The second is worth knowing about.

## Reporting

Group by required action, not discovery method:

- **Breaks the invariant** — two open tickets on one file, a contract the code
  violates. Fix before assigning more work.
- **Spec is wrong** — agents are currently being told something false. Highest
  value, since it's actively producing bad work.
- **Docs are stale** — comprehension sections describing moved code. Feeds
  `comprehension/todo.md`.
- **Tidying** — orphan branches, unpruned worktrees, obsolete tickets.

For each, say what you checked and what you found, so a false positive is
obvious. Where the fix is unambiguous (pruning a merged worktree), offer it.
Where it means deciding whether the spec or the code is right, don't guess — that
decision is the human's and it's usually the interesting one.
