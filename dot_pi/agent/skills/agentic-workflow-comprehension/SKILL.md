---
description: "Socratic quizzing on the load-bearing parts of this repo — find what's expensive to be wrong about, ask the human about it until they can state it in their own words, then file the result in comprehension/. The downtime activity while agents are working or between tickets. Use when the human asks to be quizzed, wants to understand code agents wrote, or is waiting with nothing to merge."
---

# agentic-workflow-comprehension

Socratic loop: identify load-bearing logic, quiz human, document synthesized understanding. This
exists because agents write code faster than anyone can absorb it, and the gap
is invisible until a review goes wrong.

**Note:** The human may request a review of previous context/comprehension files when resuming a project after a break to re-orient their mental model.

Run it while agents are working, or between tickets.

## What Counts As Load-Bearing

Quiz on 'expensive-to-be-wrong' logic, not mere complexity — where a wrong mental model produces a confidently wrong review:

- Anything `context/spec/` declares fixed. Agents treat these as immovable; the
  human needs to know why each one is there, or they'll approve a ticket that
  quietly breaks one.
- Implicit coupling — a column name, key, or path that two files agree on with
  nothing enforcing it.
- Order dependence. What breaks if stages run out of order, or twice.
- Anything with a silent failure mode. Wrong but plausible beats loud and broken.
- Code recently written by an agent and merged after a light review.
- Anything the human has asked about twice.
- Math: for an ML project, ALL math is considered load-bearing.

Find these by reading, not by asking what to cover. `context/spec/`, recently
merged diffs (`git log -p --since=...`), and the files most tickets touch.

## How To Ask

One question at a time. Wait for the answer.

Start from what the code does and work toward why — "what happens if this runs
twice" is better than "explain the caching layer."

Don't accept a restatement of the code. Reject code restatements. Push for predictive understanding: "if I added a row with a null in that column, what comes out?"

When they're wrong, don't correct immediately. Ask the question that exposes it
— usually a concrete case their model predicts wrongly. Then confirm.

When they're right but hazy, ask them to say it in one sentence without looking.
That sentence is what goes in the file.

Stop a thread when they can state it in their own words, or when they say they
want it written down as an open question. Three or four areas per session is
plenty.

## Filing Results

Write to `comprehension/<area>.md`, with `comprehension/main.md` for repo-wide
things. Append to the existing file; don't rewrite what's there.

**Structure:**
1. **Synthesized Understanding**:
    - `## Concept`
        - `### Intuitive` (blockquoted "In my own words")
        - `### Technical` (exact specs/details)
    - `### Q & A Summary` (cleaned-up path to synthesis)
    - `### References` (links to code, specs, etc.)

```markdown
# Comprehension for <area>

## Concept

### Intuitive
> <The human's own sentence, as they said it. Don't improve it — a lossy version they actually hold is worth more than a precise one they don't.>

### Technical
The accurate version. Exact names, paths, dtypes. What breaks if it's violated,
and where that shows up. Written so it's checkable against the code later.

### Q & A Summary
Cleaned-up summary of the load-bearing parts of the Socratic exchange.

### References
> Specs, code, external citations.
```

If their sentence is wrong after the exchange, don't file it. File it as an open
question instead.

**Note:**
- **MWE**: A minimal, executable example of a programming concept might be helpful to include.
- **WorkVault**: Results may also be filed using the `add-to-workvault` skill for long-term storage.

## comprehension/todo.md

For anything unresolved:

```markdown
- [ ] <area>: <the specific question, not "understand X">
```

Three sources feed this: areas you identified but didn't get to, questions the
human couldn't answer, and answers where **the code turned out to disagree with
`context/spec/`** — those are the valuable ones, because they mean the spec is
wrong and agents are being told something false. Flag those to the human
immediately rather than just filing them.

## Writing These Files

`comprehension/` is tracked but no ticket names it, so these commits can't
conflict with agent work. Commit them straight to the base branch — this is the
one exception to routing your own work through a branch, and it holds only
because nothing else touches these files.

Keep each file skimmable. The point is a thing the human will re-read, not a
transcript.
