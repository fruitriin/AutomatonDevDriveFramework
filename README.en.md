# AutomatonDevDrive Framework

> ADDF is one of Agentic Driven Development Framework

[日本語版 README はこちら](README.md)

A framework where Automatons — AI agents — autonomously drive your development.
Clone the project, initialize it, provide a plan, and the AI agent will autonomously select tasks, implement them, and run quality verification end to end.

## Features

- **Knowhow Accumulation** — Records implementation insights in `docs/knowhow/` and automatically references them in subsequent tasks
- **Self-Driving Loop** — `/loop 1h /addf-dev-loop` autonomously selects and implements tasks from TODO
- **Separation of Skills and Experience** — Skill definitions (`.md`) and experience accumulation (`.exp.md`) are separated; experience is stored locally
- **Quality Gate** — Automatically runs code review, security review, and contribution detection
- **GUI Testing** (optional) — Visual UI verification via screenshots and image analysis on macOS

## Quick Start

### 1. Clone

```bash
git clone https://github.com/fruitriin/AutomatonDevDriveFramework.git my-project
cd my-project
```

### 2. Initialize

```
/addf-init
```

Interactively sets up project name, type, build commands, and auto-generates the necessary files.

### 3. Create Plans and Start Development

Plans can be created from rough notes:

```markdown
- Add login feature
- Increase test coverage
```

Just hand it to Claude and the AI will break it into formal plan files in `docs/plans/` and `TODO.md`.

```
/loop 1h /addf-dev-loop
```

The AI agent will then autonomously cycle through the development loop.

## Documentation

| Guide | Content |
|---|---|
| [Detailed Setup](docs/guides/setup.md) | Manual setup, configuration roles, directory structure |
| [Skills](docs/guides/skills.md) | All ADDF skills with invocation and descriptions |
| [Agents](docs/guides/agents.md) | Sub-agents auto-launched during quality gates |
| [Development Process](docs/guides/development-process.md) | Boot sequence, quality gates, task lifecycle |
| [Migration](docs/guides/migration.md) | Upgrading ADDF with `/addf-migrate` |
| [Codex Setup](docs/guides/codex-setup.md) | Using ADDF with OpenAI Codex CLI |
| [GUI Testing](docs/guides/gui-test-setup.md) | macOS GUI test setup |

## About the Name

The official name of this framework is **AutomatonDevDrive Framework**.

But if you take its initials — **ADDF** — and expand them, you get: **A**gentic **D**riven **D**evelopment **F**ramework.

Not a coincidence.

An Automaton is exactly what the AI agent is: something that autonomously selects tasks, implements them, and verifies quality — no hand-holding required. DevDrive is the engine that keeps it moving, the mechanism that propels development forward.

The surface name is Automaton. The hidden name is Agentic. Both describe the same thing.
If you caught that — nice.
