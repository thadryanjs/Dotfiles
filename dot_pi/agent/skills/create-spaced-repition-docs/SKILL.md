---
description: Convert conversation history or technical discussions into educational material for spaced repetition
---

# create-spaced-repition-docs

Convert conversation history or technical discussions into educational material for spaced repetition.

## Goal
Create high-signal, low-noise markdown files that decompose complex topics into a series of atomic Question/Answer pairs.

## Filename Convention
- Use **kebab-case** (lowercase, hyphens instead of spaces).
- Example: `lean-architecture.md`


## Format
- **Title**: H1 header representing the core topic/concept.
- **Content**: A sequence of Q&A pairs.
- **Pattern**:
  ```markdown
  # Topic Name

  Question: [Clear, specific question targeting a single concept or nuance]
  Answer: [Concise, precise answer. Include "nitpicks", corrections, or mental models if they emerged in the discussion]

  Question: ...
  Answer: ...
  ```

## Guidelines
1. **Atomic Questions**: Each pair should cover one specific point. If an answer is too long, split it into multiple questions.
2. **Capture Nuance**: Focus on "the fix", the "nitpick", or the "aha!" moment from the discussion.
3. **Avoid Fluff**: No introductions or conclusions. Just the Q&A.
4. **Technical Precision**: Use exact terminology. If a distinction was made (e.g., "typing" vs "set membership"), ensure the Q&A reflects that distinction.
5. **Contextual Mapping**: When using analogies, explicitly map the analogy components to the technical reality.

## Knowledge Vault Integration
The user may ask to save these documents to the Knowledge Vault (`~/Vaults/Knowledge`). When doing so:
- Determine the appropriate sub-directory based on topic (e.g., `/Areas/Programming/`).
- Ensure the kebab-case filename is maintained.
- Avoid overwriting existing notes unless explicitly asked; consider appending or creating versioned files if applicable.

