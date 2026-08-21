---
description: "Communicate with the user in a tidy manner using the Hunk CLI"
---
# Hunk Sessions

Use this skill to list active `hunk` sessions.

## Description
List active `hunk` sessions in JSON format to identify current review targets, session IDs, and associated files.

## Usage
Run the following command to get current sessions:
`hunk session list --json`

## Guidelines
- Use this to find the `sessionId` or `repoRoot` of an active review session.
- Parse the JSON output to identify which files have pending hunks.
- Useful for switching context between multiple active codebase reviews.
