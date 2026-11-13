---
name: code-review
description: "Technical code review focused on correctness, stability, and performance. Identifies bugs, risks, and smells, and supports step-by-step correctness walkthroughs."
compatibility: opencode
---

# code-review

Perform a rigorous technical audit of the code in scope. Your goal is to find problems the author would want to know about before this code runs in anger—bugs, fragility, silent failures, and habits that will cost time later.

## Reporting Findings

Output a **single numbered list** of findings. One issue per item. No grouped bullets under a number. Number continuously across all sections.

Each item follows this shape:
```
N. [SECTION] [SEVERITY] One-line summary
   Where: path:line (or function/section name)
   Why it matters: one or two sentences
   Suggested fix: concrete change, or "needs discussion" if non-obvious
```

### Severity Tags
- **BUG**: Will produce wrong results or crash.
- **RISK**: Likely to bite under specific inputs, environments, or scale.
- **SMELL**: Works but fragile, confusing, or violates established patterns.
- **NIT**: Style, naming, or minor clarity improvements.

Order findings by severity, then by likely time-cost if missed. Put **BUGs** first.

## What to Look For

### 1. Logic & Correctness
- **Off-by-ones**: Loop boundaries, slicing, indexing.
- **Type/Value Slips**: Integer vs float division, `None` checks, lexicographical sort of numbers.
- **State/Flow**: Modifying collections while iterating, swallowing errors, bare `except:`.
- **I/O**: Relative paths breaking, missing `mkdir -p`, silent overwrites, encoding issues.

### 2. Stability & Performance
- **Resource Leaks**: Leaked file handles (no `with`), no flush before blocking.
- **Scaling**: Reading huge files with `.read()`, $O(N^2)$ in loops where $O(N)$ is possible.
- **Concurrency**: Race conditions, thread-safety, non-atomic updates.

### 3. Extra Scrutiny for Long-Running Jobs
If code runs for > few minutes, flag these as **RISK** or **BUG**:
- **No Checkpointing**: Lack of intermediate saves or checkpoints that overwrite.
- **No Progress Signal**: Missing `tqdm` or logging for long loops.
- **Input Validation**: Failure to validate inputs early before spending hours of compute.
- **Silent Failures**: Errors dropped per-item without a summary of failures.
- **Network/API**: Calls without retry/backoff.

## Verdict

End the review with a clear pre-flight verdict:
- `"Safe to launch"`
- `"Launch after fixing [numbers]"`
- `"Do not launch — see [numbers]"`

---

## Walkthrough (Proving Correctness)

Ensure absolute understanding of a specific logic path (code or math) through "brick-by-brick" walkthroughs.

### The Process
1. **Isolate**: Extract the specific function, lemma, or logic block.
2. **Decompose**: Break the logic into the smallest possible atomic steps.
3. **Iterate**:
    - Present **one** atomic step/line of math.
    - Explain the "why" and "how" briefly.
    - **Stop and wait** for confirmation ("Got it", "Next") or a challenge ("Why?", "Wait").
    - Only proceed to the next brick once the current one is solidified.

### Guidelines
- **No skipping**: Never explain two complex steps at once.
- **Challenge**: If a step feels "magic," call it out and dive deeper.
- **Terse**: Keep explanations minimal but precise.
- **Completion**: Once the path is finished, ask: "Does the total synthesis hold, or did we find a gap/bug?"
