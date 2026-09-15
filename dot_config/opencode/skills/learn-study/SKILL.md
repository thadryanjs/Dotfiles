---
compatibility: opencode
description: Comprehensive pedagogical tool for learning complex technical topics via atomic Q&A and methodical quizzing
---

# learn-study

A unified system for converting technical discussions into study materials and executing methodical, brick-by-brick learning sessions.

## Part 1: Material Generation (Spaced Repetition Docs)

Convert conversation history or technical discussions into high-signal, low-noise markdown files.

### Goal
Decompose complex topics into a series of atomic Question/Answer pairs for spaced repetition.

### Format
- **Filename**: `lower-kebab-case.md`
- **Structure**:
  ```markdown
  # Topic Name

  Question: [Clear, specific question targeting a single concept or nuance]
  Answer: [Concise, precise answer. Include "nitpicks", corrections, or mental models]

  Question: ...
  Answer: ...
  ```

### Guidelines
1. **Atomic Questions**: Each pair covers one specific point. Split long answers.
2. **Capture Nuance**: Focus on "the fix", the "nitpick", or the "aha!" moment.
3. **No Fluff**: No introductions or conclusions.
4. **Technical Precision**: Use exact terminology.
5. **Contextual Mapping**: Explicitly map analogies to technical reality.

## Part 2: Execution (Methodical Quizzing)

Slow, methodical quizzing on ML research, code, or math.

### Rules
- **One question at a time**. Wait for answer.
- **User pace**: `next`, `slow`, `repeat`, `skip`.
- **Depth**: `overview` | `step` | `deep`.
- **Progression**: Why $\to$ How $\to$ Connection.

### Question Flow
1. **Why** (The Problem): What problem is solved? Why this choice? What assumption was made?
2. **How** (The Mechanism): Walk algorithm steps. Trace tensor flow. Code $\to$ math mapping.
3. **Connection** (The Ecosystem): How does A relate to B? Where is it used downstream? What breaks without X?

### Content Specifics
- **Math**: Focus on optimization, gradient contribution, and terms. No proofs.
- **Algorithms**: Step-by-step state updates and tensor destinations.
- **Code**: Math implementation and purpose of masks/broadcasts.

## Integration & Workflow

1. **Capture**: User pastes content or refers to a discussion.
2. **Synthesize**: Generate atomic Q&A pairs using the `Material Generation` format.
3. **Quiz**: Use those Q&A pairs to drive a `Methodical Quizzing` session.
4. **Refine**: User notes on confusion points drive the creation of new, more specific Q&A pairs.

## Commands
`next` | `slow` | `repeat` | `skip` | `depth: <level>` | `quiz: why|how` | `notes: <paste>` | `recap` | `revisit <concept>`
