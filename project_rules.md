# Project Rules & Assistant Guidelines

## Communication Style
- **Non-Technical Language**: The user is not a coder. Avoid jargon where possible. Explain technical concepts using simple analogies.
- **Conciseness**: Be direct and to the point.

## Workflow
- **Consistency**: Always check this file before starting major tasks to ensure consistency with user preferences.

## Version Control
- **GitHub Sync**: All projects must be initialized with Git and synced to GitHub as a first step. Ensure a .gitignore file is present.

## Available Tools
- **Custom CLIs**: The environment has access to `codexgo` (Codex CLI) and `claudego` (Claude CLI). Use these when appropriate.

## Autonomy
- **No "Acceptance" Needed**: The user prefers the agent to execute changes (file edits, git commits, terminal commands) immediately. Do not ask "Shall I do this?". Just do it and report that it is done.
- **Exceptions**: Only ask for confirmation if an action is destructive (deleting non-trivial files) or irreversible.
