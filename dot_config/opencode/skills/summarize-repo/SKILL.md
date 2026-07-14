---
name: summarize-repo
description: Make a markdown summary of a repo
compatibility: opencode
---

Create a markdown summary of the current repo called {yyyy-mm-dd}-{repo-name}-summary.md that includes:
- A level two header that summarizes the repo in 3-5 sentences.
- A level two header for each:
    - Code module
    - Code source file in the root directory
    - Readme
- Each summary should be between 3-5 bullets
- An estimate level of completion based on any available docs.
    - If there are no planning docs, take a general guess based on:
        - The context of the repo (ie if it's called "statistical model" but only basic data cleaning has been done).
        - If a working app or meaningful output exists.
        - If it's not clear, DO NOT speculate wildly
- Include a level 3 header called "Details" under each section IF NEEDED but do not do this if it's redundant
- Recommendations for resuming work on the project
- If there is an "agents", "docs", or "misc" directory, place the summary there.

