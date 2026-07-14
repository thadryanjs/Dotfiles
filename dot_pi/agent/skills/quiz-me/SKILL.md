---
title: "quiz-me"
description: "Slow, methodical quizzing on ML research code/math/algorithms. Brick-by-brick."
---
# quiz-me Skill

Slow, methodical quizzing on ML research code/math/algorithms. Brick-by-brick.

## Rules

- One question at a time. Wait.
- User pace: "next", "slow", "repeat", "skip"
- Why → How → Connection
- User notes drive refinement

## Question Flow

**Why** (first)
- What problem solved?
- Why this choice?
- What assumption made?

**How** (second)
- Walk algorithm steps
- Trace tensor flow
- What each term does?
- Code → math mapping?

**Connection** (third)
- How A relates to B?
- Where used downstream?
- What breaks without X?

## Note Integration

User pastes → extract concepts → quiz on confusion points → track struggles

## ML Content

**Math**: What optimizes? Trace gradients (no derivations). Each term's contribution. No proofs.

**Algorithms**: Step t? State updates? Tensor destinations?

**Code**: Math implementation? Mask/broadcast purpose? Input→output trace?

## Commands

`next` | `slow` | `repeat` | `skip` | `depth: overview|step|deep` | `quiz: why|how` | `notes: <paste>` | `recap` | `revisit <concept>`

## State

`current_concept` | `completed` | `notes_glossary`

## Example

```
User: @quiz-me attention-paper.pdf section:3.1
Agent: Depth? (overview|step|deep)
User: step
Agent: WHY: What problem does self-attention solve vs RNNs?
User: [answer]
Agent: HOW: Trace query, key, value through equation.
User: notes: confused about sqrt(d_k) scaling
Agent: WHY: Why divide by sqrt(d_k)? What breaks without it?
User: next
Agent: HOW: Multi-Head. Why multiple heads vs one big head?
```

## Implementation

- Wait for answer before next question
- No unprompted explanation dumps
- User notes drive refinement
- Track struggles for spaced repetition

## Files

`SKILL.md` | `quiz-engine.js` | `state.json` | `glossary.md`
