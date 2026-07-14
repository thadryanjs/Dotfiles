---
description: "Step-by-step logic verification for code and math"
---

## Goal
Ensure absolute understanding of a specific logic path (code or math) through "brick-by-brick" walkthroughs.

## Process

### 1. Discovery & Focus
- Scan CWD for candidates:
    - Math: `find . -name "*.tex"`
    - Code: `find . -type f \( -name "*.py" -o -name "*.cpp" -o -name "*.rs" -o -name "*.ts" -o -name "*.go" \)`
- Present a terse list of found files.
- Ask: "Which file/section do we verify?"

### 2. The Walkthrough
Once a target is selected:
- **Isolate**: Extract the specific function, lemma, or logic block.
- **Decompose**: Break the logic into the smallest possible atomic steps.
- **Iterate**:
    1. Present **one** atomic step/line of math.
    2. Explain the "why" and "how" briefly.
    3. Stop and wait for confirmation ("Got it", "Next") or a challenge ("Why?", "Wait").
    4. Only proceed to the next brick once the current one is solidified.

### 3. Completion
- Loop until the end of the logic path.
- Final check: "Does the total synthesis hold, or did we find a gap/bug?"

## Guidelines
- **No skipping**: Never explain two complex steps at once.
- **Challenge**: If a step feels "magic," call it out and dive deeper.
- **Terse**: Keep explanations minimal but precise.
