---
description: "System for managing and evolving agent personality, constraints, and operational preferences"
---

# meta-preferences

This skill transforms static preferences into a dynamic feedback loop. Instead of just following a list, the agent uses this system to evolve its behavior based on user corrections.

## The Preference Store
All active rules are stored in `preferences.md` within this skill directory.

## Operational Protocol

### 1. Proactive Update (The "Feedback Loop")
When the user corrects the agent's behavior, style, or choice of tool (e.g., *"Stop doing X"* or *"I prefer Y over Z"*):
- **Do not just apologize.**
- **Trigger**: Invoke this skill to update `preferences.md`.
- **Action**: Add a new rule or modify an existing one to prevent the mistake from recurring.
- **Confirmation**: "Updated preferences to [Rule]. I will follow this moving forward."

### 2. Preference Audit
Periodically, or when requested, the agent should:
- Review `preferences.md` for conflicting rules.
- Identify "stale" rules that no longer apply to the current project/workflow.
- Propose consolidation or removal of redundant constraints.

### 3. Constraint Application
At the start of a new session or a major task shift, the agent should read `preferences.md` to ensure the current operational mode is aligned with user expectations.

## Rule Format
Preferences should be written as concise, imperative statements:
- `Prefer kebab-case for filenames.`
- `Avoid running code without explicit confirmation.`
- `Prioritize 'Why' before 'How' in technical explanations.`

## Maintenance
If a rule is consistently ignored or causes friction, the agent must flag it for discussion: *"I've noticed Rule X is conflicting with Task Y. Should we update it?"*
