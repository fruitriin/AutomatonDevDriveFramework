# AutomatonDevDrive Framework

> ADDF is one of Agentic Driven Development Framework

[日本語版 README はこちら](README.md)

A framework where Automatons — AI agents — autonomously drive your development.
Clone the project, initialize it, provide a plan, and the AI agent will autonomously select tasks, implement them, and run quality verification end to end.

## Features

- **Knowhow Accumulation** — Records implementation insights in `docs/knowhow/` and automatically references them in subsequent tasks
- **Self-Driving** — `/addf-dev` completes one task; `/loop 1h /addf-dev` for continuous autonomous execution
- **Separation of Skills and Experience** — Skill definitions (`.md`) and experience accumulation (`.exp.md`) are separated; experience is stored locally
- **Quality Gate** — Automatically runs code review, security review, and contribution detection
- **GUI Testing** (optional) — Visual UI verification via screenshots and image analysis on macOS

## Quick Start

### 1. Create a Repository from the Template

Click **[Use this template](https://github.com/fruitriin/AutomatonDevDriveFramework/generate)** on GitHub to create a new repository.

```bash
git clone https://github.com/your-org/my-project.git
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
/addf-dev
```

Picks one task, implements it, runs quality verification, and commits. For continuous autonomous execution:

```
/loop 1h /addf-dev
```

## Skills

Skills provided by ADDF (invoked via `/command-name`):

| Skill | Invocation | Description |
|---|---|---|
| **addf-dev** | `/addf-dev` | Picks a task from TODO, implements, verifies quality, and commits |
| **addf-init** | `/addf-init [check]` | Project initialization / structure verification |
| **addf-release** | `/addf-release [minor]` | Release (changelog, version bump, publish) |
| **addf-migrate** | `/addf-migrate` | Upgrade ADDF framework to latest version |
| **addf-knowhow** | `/addf-knowhow <topic>` | Record implementation insights (with dedup & merge) |
| **addf-knowhow-index** | `/addf-knowhow-index [reindex]` | View or rebuild the knowhow index |
| **addf-lint** | `/addf-lint` | Framework integrity check |
| **addf-permission-audit** | `/addf-permission-audit` | Analyze and classify permission requests |

<details>
<summary>Other skills</summary>

| Skill | Description |
|---|---|
| **addf-knowhow-filter** | Filter knowhow relevant to a Plan |
| **addf-experience** | Validate experience file (`.exp.md`) mention syntax |
| **addf-gui-test** | Run GUI tests (macOS optional) |
| **addf-annotate-grid** | Draw grid lines on PNG images |
| **addf-clip-image** | Clip regions from PNG images |

</details>

## Built-in Agents

Sub-agents auto-launched during quality gates. Customize or add agents to fit your project.

| Agent | Purpose | Customization guidance |
|---|---|---|
| **addf-knowhow-agent** | Filters knowhow relevant to a Plan | — |
| **addf-code-review-agent** | Reviews code quality and readability | Add your project's coding conventions |
| **addf-security-review-agent** | Inspects security vulnerabilities (optional) | Add industry-specific security standards |
| **addf-contribution-agent** | Detects framework contribution candidates | — |
| **addf-ui-test-agent** | Screenshot-based UI verification (optional) | **Rewrite as your project's UI/UX domain expert** |

> **Tester agents should be domain experts for your project.**
> Customize agent definitions in `.claude/agents/` with your project's domain knowledge, test criteria, and quality requirements.
> Example: For an e-commerce site, add payment flow verification steps. For iOS Native, add automated testing via iOS Simulator.

## Documentation

| Guide | Content |
|---|---|
| [Detailed Setup](docs/guides/setup.md) | Manual setup, configuration roles, directory structure |
| [Built-in Agents](docs/guides/agents.md) | Sub-agents for quality gates and how to customize them |
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
