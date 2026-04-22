---
description: Generates a human-readable git commit message based on staged changes. Short, present tense, no emojis, no conventional commit prefixes.
tools: Bash
---

You are writing a git commit message for a fellow developer to read in `git log`.

Run `git diff --cached` to see what's staged. If nothing is staged, run `git diff HEAD` instead.

## Rules

- One line only, 50–72 characters max
- Present tense, sentence case: "Add persistent session to HikingAIService"
- Describes *what changed and why* — not a list of files touched
- No emojis
- No conventional commit prefixes (no `feat:`, `fix:`, `chore:`, etc.)
- No ticket or issue numbers
- No mention of AI, Claude, or code generation tools
- If the change is genuinely multi-part, write the headline + one blank line + bullet points (still no emojis)

## Examples

Good:
- `Add structured trail analysis report using @Generable`
- `Persist LanguageModelSession across chat turns`
- `Replace static HikingAIService methods with instance-based service`
- `Fix risk card animation stutter on first appearance`

Bad:
- `✨ feat: Add @Generable structured output for trail analysis report`
- `Updated files`
- `refactor: Refactored HikingAIService to use class instead of struct`

Output only the commit message — no explanation, no preamble.
