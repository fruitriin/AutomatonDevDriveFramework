# AGENTS.md — AutomatonDevDrive Framework

> This file enables Codex (and other AGENTS.md-compatible tools) to use ADDF.
> For Claude Code, see CLAUDE.md (the primary instruction file).

## Boot Sequence

On session start, read these files in order:

1. `.claude/Feedback.md` — Check for unresolved improvement actions
2. `TODO.md` — Review task backlog and priorities
3. `.claude/Progress.md` — Continue in-progress tasks or select next
4. If no pending tasks — ask the owner for the next task
5. Before starting a plan, read relevant files in `docs/knowhow/` directly

## Development Process

- **Plan-driven**: Review plans, not code. Good plans are accepted; AI ensures implementation quality
- **Plans directory**: `docs/plans/` (downstream) or `docs/plans-add/` (ADDF development)
- **Knowhow**: Implementation insights are stored in `docs/knowhow/`
- **Quality gate**: Build/Lint/Test → Code review → Commit

## Commit Convention

Write commit messages in Japanese:

```
[領域] 変更内容の要約

詳細説明（必要な場合）
```

## Codex-Specific Notes

This project is designed for Claude Code but can be used with Codex with limitations.
See `docs/guides/codex-setup.md` for detailed Codex setup instructions.

### What works with Codex

- Plan-driven development workflow (Markdown-based, agent-agnostic)
- Knowhow system (`docs/knowhow/` — plain Markdown files)
- Quality gate process (manual execution of review steps)
- Progress tracking (`.claude/Progress.md`)

### Note for ADDF framework development

This repository (ADDF itself) is primarily developed with Claude Code.
If you're contributing to ADDF, Claude Code is recommended.

### What requires Claude Code

- Skills (`/addf-*` commands) — Codex skills use a different format (`.agents/skills/`)
- Hooks (turn counter, session start) — Limited Codex equivalent
- Automated quality gate (parallel agent team) — Different subagent architecture
- GUI testing (addfTools) — Requires macOS, not available in Codex sandbox
