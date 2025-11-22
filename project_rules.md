# Project Rules & Assistant Guidelines

## Communication Style
- **Autonomy**: The user prefers the agent to execute changes (file edits, git commits, terminal commands) immediately. Do not ask "Shall I do this?". Just do it and report that it is done. The human trusts the agent to make sound decisions and treats the agent as a senior engineer.
- **Non-Technical Language**: The user is not a coder. Avoid jargon where possible. Explain technical concepts using simple analogies.
- **Conciseness**: Be direct and to the point.

## Workflow
- **Consistency**: Always check this file before starting major tasks to ensure consistency with user preferences.

## Version Control
- **GitHub Sync**: All projects must be initialized with Git and synced to GitHub as a first step. Ensure a .gitignore file is present.

## Terminal Tools
- **Agent CLIs**: Run `codexgo` (Codex CLI) to talk directly with OpenAI Codex. Treat codex as a multipurpose assistant that can generate code, write documentation, and more.
Run `claudego` (Claude CLI) tot talk directly with Anthropic Claude. Treat Claude as a multipurpose assistant that can generate code, write documentation, and more.

- **Installed CLIs**:
- git gh (GitHub CLI)

## Autonomy
- **No "Acceptance" Needed**: The user prefers the agent to execute changes (file edits, git commits, terminal commands) immediately. Do not ask "Shall I do this?". Just do it and report that it is done.
- **Exceptions**: Only ask for confirmation if an action is destructive (deleting non-trivial files) or irreversible.
