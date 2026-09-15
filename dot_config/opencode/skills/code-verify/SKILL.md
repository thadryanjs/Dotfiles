---
compatibility: opencode
description: "Verification suite for code and math: combines general review (bugs/risks) with step-by-step logic verification (proofs/walkthroughs)"
---

# code-verify

This skill provides two modes of verification: **Review Mode** (finding problems) and **Walkthrough Mode** (proving correctness).

## Mode 1: Review (Finding Problems)

Do a careful read of the code in scope. Your job is to find problems the author would want to know about before this code runs in anger — bugs, fragility, silent failures, and habits that will cost time later.

### Reporting Findings
Output a **single numbered list** of findings. One issue per item. No grouped bullets under a number. Number continuously across all sections.

Each item follows this shape:
```
N. [SECTION] [SEVERITY] One-line summary
   Where: path:line (or function/section name)
   Why it matters: one or two sentences
   Suggested fix: concrete change, or "needs discussion" if non-obvious
```

Severity tags: **BUG** (will produce wrong results or crash), **RISK** (likely to bite under some inputs / environments), **SMELL** (works but fragile or confusing), **NIT** (style, naming, minor clarity).

Order findings by severity, then by likely time-cost if missed. Put BUGs first.

### What to look for
- **Paths & Files**: Relative paths breaking, missing `mkdir -p`, silent overwrites, glob failures, hardcoded paths.
- **Variables & References**: Undefined variables, typos, shadowing, off-by-ones, mutable default args.
- **Control Flow**: Swallowing errors, bare `except:`, modifying collections while iterating.
- **I/O**: Leaked handles (no `with`), no flush before blocking, encoding issues, reading huge files with `.read()`.
- **Logic Landmines**: Integer vs float division, float `==`, `None` slips, lexicographical sort of numbers, tz-naive vs tz-aware.
- **Clarity**: Magic numbers, dead code, lying names, duplicated logic.

### Extra Scrutiny for Long-Running Jobs
If code runs for > few minutes, flag these as **RISK** or **BUG**:
- No checkpointing or checkpoints that overwrite.
- No progress signal (`tqdm`, logs).
- No early validation of inputs.
- Errors silently dropped per-item.
- Output written only at the end.
- Network calls without retry/backoff.
- No dry-run mode.

**Pre-flight verdict**: end with *"Safe to launch"*, *"Launch after fixing [numbers]"*, or *"Do not launch — see [numbers]"*.

---

## Mode 2: Walkthrough (Proving Correctness)

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
