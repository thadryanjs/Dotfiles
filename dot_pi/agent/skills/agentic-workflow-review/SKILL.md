---
description: "Specialized review process for the agentic workflow. Focuses on invariant protection, spec alignment, and evidence-backed correctness."
---

# agentic-workflow-review

You are reviewing a PR created by another agent. Your goal is to ensure the change is correct, adheres to the core invariants, and does not introduce drift.

**Note**: This skill focuses on **Workflow Governance**. For a deep dive into technical correctness, bugs, and performance, invoke `code-review` in parallel.

## The Review Checklist

### 1. Invariant Check (Non-negotiable)
- **Single File**: Does the PR touch ONLY the file named in the ticket? If it touches more, it is a ticket-scoping failure. **Request changes.**
- **Base Branch**: Is the PR targeting the correct base branch?

### 2. Spec & Contract Alignment
- **Contract Adherence**: Compare the changes against `context/spec/` and the ticket's `Contract` section. Did the agent change a documented contract without authorization? **Blocker.**
- **Citations**: If the code implements a specific mathematical formula or complex strategy, is there a citation to an external source? If not, ask for the source to ensure it's not a hallucination.
- **Hardcoded Results**: Search for any hardcoded results in `print()` or return statements that should be computed. **This is an automatic, non-negotiable BLOCKER. Hardcoding a result is a failure of integrity.**

### 3. Evidence of Verification
- **The Verify Command**: Look for evidence that the `Verify` command specified in the ticket was actually run and passed.
- **Triviality**: For small changes, does the logic obviously hold? For complex changes, do the test outputs prove correctness?

### 4. Code Quality
- **Correctness**: Are there bugs, off-by-ones, or silent failure modes?
- **Clarity**: Is the code maintainable, or is it "clever" in a way that obscures intent?
- **Consistency**: Does it follow the project's established patterns?

## Verdicts

Provide a clear verdict at the end of your review:

- **✅ Approve**: Meets all invariants, matches spec, and is verified.
- **⚠️ Request Changes**: Logic is mostly sound but needs fixes, style changes, or better evidence of verification.
- **🛑 Blocker**: Breaks a core invariant (e.g., touches multiple files) or violates a documented contract in `context/spec/`.

## Feedback Format

List findings by severity:
1. **Blocker**: [File/Line] - [Why it's a blocker]
2. **Issue**: [File/Line] - [Correctness/Logic problem]
3. **Nit**: [File/Line] - [Style/Clarity]

End with the Verdict.
