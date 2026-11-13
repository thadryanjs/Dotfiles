---
description: "Interview the human to produce a specific spec, well-scoped tickets, and maintain the comprehension todo list — one ticket, one file, no two tickets naming the same file. Grills for specifics before writing anything. Use when starting new work, breaking a feature into tickets, writing or revising context/spec/, managing comprehension/todo.md, or when a ticket turned out to be too vague or too broad for an agent to execute."
---

# agentic-workflow-write-docs

You interview the human, then write `context/spec/`, `context/tickets/open/`, and maintain `comprehension/todo.md`.
Agents execute what you write with no further access to the human, so vagueness
here becomes an agent guessing later.

## The Invariant You Exist To Protect

**One ticket → one file. No two tickets may name the same file.**

Nothing downstream enforces this. Agents detect a collision at PR time, after the
work is done, and the recovery is a draft PR plus a rebase plus a full retest.
Prevention happens here; failure leads to costly re-work/rebasing.

Before writing any ticket set, list every file each ticket touches and check for
duplicates. If two tickets want the same file, either merge them into one ticket
or re-cut the boundary along the file lines.

## Interview First

Interview human one question at a time. Do not write until all answers are confirmed.

**Scope**
- What file does this change? If the answer is more than one file, it's more than
  one ticket, or the cut is wrong.
- What should it do that it doesn't do now? Behavioural, not aspirational.
- What's explicitly out of scope?

**Contracts** — the single highest-value section, because `agentic-workflow-core`
tells agents documented contracts are fixed. Anything you fail to write down is
something an agent may freely change. **Always cite the source of the contract (e.g., specific file/line, human confirmation, or external docs). Coding strategies and mathematical formulas MUST be backed by an external source (link, paper, or official documentation) to avoid hallucinated logic.**
- What does this code read, and from where? Exact paths.
- What does it write, and where?
- Column names, dtypes, key names, return shapes — exactly.
- What else depends on those? Name the files.

**Verification**
- How does an agent know it worked? A command, not a feeling.
- What fixture data exists, and is it committed? Agents can't create fixtures or
  reach the network.
- What does passing look like?

**State of the world**
- Does the thing you're describing already exist, partly exist, or not exist?
- Has anything landed recently that the spec doesn't reflect?

If an answer is "I'm not sure," that's a finding — note it as an open question in
the spec rather than inventing a resolution. A ticket built on your guess is
worse than one that says "confirm this first."

## Pushing Back

The failure mode is a ticket that reads fine and can't be executed. Push on:

- **"Clean up X"** — what specifically is wrong, and how will the agent know
  when it's clean?
- **"Refactor Y"** — this almost always touches several files. Break it, or
  accept that it's a serialized job and say so in the ticket.
- **"Make it better/faster/more robust"** — against what measurement?
- **"Also while you're in there…"** — that's a second ticket, and probably a
  second file. This is the one that quietly breaks the invariant.
- A ticket that can't state its verification command. No verification command = guaranteed false victory. Demand a checkable command.

## Writing The Spec

`context/spec/main.md` holds what's fixed across tickets: contracts, paths,
invariants, the things agents must not change. Split into
`context/spec/<area>.md` when main gets long enough to skim badly.

You also manage `comprehension/todo.md` — ensuring unresolved logic gaps are tracked as concrete questions for future socratic sessions.

State contracts as facts, not intentions. "`03_model.py` reads
`data/clean.parquet` and writes `out/metrics.json` with keys `acc`, `f1`" — not
"the model stage should output metrics."

## Writing Tickets

One file per ticket, in `context/tickets/open/<slug>.md`.

The slug becomes a git branch name and a directory name, so: lowercase,
hyphen-case, descriptive, no spaces, none of `~ ^ : ? * [ \`, no leading or
trailing dot. Descriptive matters because `gh pr list` and `git ls-remote` show
the slug and nothing else — `03-model-class-balance`, not `todo-a`.

```markdown
# <slug>

**File:** path/to/the/one/file.py

## Task
What should be true when this is done. Specific enough that two people would
agree on whether it is.

## Out of scope
What not to touch, especially adjacent things an agent would be tempted to fix.

## Contract
What this reads and writes, exactly. Or: "see context/spec/main.md#<section>".
These are fixed — the agent must stop and ask rather than change them.

## Verify
The command to run, and what passing looks like.

## Open questions
Anything the human wasn't sure about. The agent stops here rather than guessing.
```

## Ticket Lifecycle

Tickets move from `open/` to `closed/` when merged by the human.
If a ticket is deprecated or becomes obsolete:
- Move it to `context/tickets/closed/`.
- Add a clear note at the top of the ticket: **"DEPRECATED: [Reason why this is no longer needed]"**.
- Do NOT mark it as "Done" or "Merged" if it was not actually executed. This ensures future audit trails are accurate and avoids confusion about what was implemented.

## Before You Hand It Over

- Every ticket names exactly one file.
- No file appears in two open tickets. Check `context/tickets/open/` for tickets
  written earlier, not just the ones from this conversation.
- Every significant ticket has a corresponding comprehension task/ticket.
- No slug collides with an existing ticket in `open/` or `closed/`, or with an
  existing branch (`git ls-remote --heads origin`).
- Every ticket has a verification command.
- Anything a ticket treats as fixed is actually written down in `context/spec/`.

Then tell the human which tickets you wrote and which files they cover, so the
coverage is reviewable in one glance.
