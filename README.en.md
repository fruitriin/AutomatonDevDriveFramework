# AccrateDevDrive Framework

[日本語版 README はこちら](README.md)

An AI-driven autonomous development framework.
Clone the project, replace a few files, provide a plan (`docs/plans/`), and the AI agent will autonomously drive development forward.

## Features

- **Knowhow Accumulation** — Records implementation insights in `docs/knowhow/` and automatically references them in subsequent tasks
- **Self-Driving Loop** — `/loop 1h /add-dev-loop` autonomously selects and implements tasks from TODO
- **Separation of Skills and Experience** — Skill definitions (`.md`) and experience accumulation (`.exp.md`) are separated; experience is stored locally
- **Quality Gate** — Automatically runs code review, security review, and contribution detection
- **GUI Testing** (optional) — Visual UI verification via screenshots and image analysis on macOS

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/AccrateDevDriveFramwork.git my-project
cd my-project
```

### 2. Replace Project-Specific Files

| File | Action | Description |
|---|---|---|
| `README.md` | Replace | Rewrite with your project's own description |
| `CLAUDE.repo.md` | Create | Create based on `CLAUDE.repo.example.md` (`.gitignore` target, local only) |
| `CLAUDE.local.md` | Create (optional) | Create based on `CLAUDE.local.example.md` for personal developer settings |
| `CONTRIBUTING.md` | Replace (optional) | Customize for your project as needed |

### 3. Configuration Roles

| File | Loading Method | Committed |
|---|---|---|
| `CLAUDE.repo.md` | Expanded via `@` mention in CLAUDE.md | No (`.gitignore` target) |
| `CLAUDE.local.md` | Auto-loaded by Claude Code | No (`.gitignore` target) |
| `.gitignore` | Git standard | Yes |
| `.claudeignore` | Claude Code standard | Yes |

Even files in `.gitignore` can be accessed by Claude Code via direct path specification. Files that should be "not tracked by git but visible to Claude" (such as `*.exp.md`) should only be listed in `.gitignore`.

### 4. Create Plans and Start Development

Create plan files in `docs/plans/` and add them to the `TODO.md` backlog.
See [CONTRIBUTING.md](CONTRIBUTING.md) for the plan file format.

```
/loop 1h /add-dev-loop
```

The AI agent will then autonomously cycle through: `TODO.md` → `docs/plans/` → Implementation → Quality verification → Commit.

## Directory Structure

```
.
├── CLAUDE.md                    # Boot sequence & development process definition
├── CLAUDE.repo.example.md       # Template for CLAUDE.repo.md
├── CLAUDE.local.example.md      # Template for CLAUDE.local.md
├── TODO.md                      # Task backlog
├── CONTRIBUTING.md              # Contribution guide
├── .claude/
│   ├── Progress.md              # Current task progress
│   ├── Feedback.md              # Issue tracking & improvement actions
│   ├── Progresses/              # Completed task archives
│   ├── templates/               # Template files
│   ├── skills/                  # Skill definitions
│   │   └── optional/            # Optional skills
│   ├── agents/                  # Sub-agent definitions
│   └── addToolsSrc/             # GUI test tools (macOS/Swift)
├── docs/
│   ├── plans/                   # Implementation plan files
│   └── knowhow/                 # Accumulated implementation insights
└── .gitignore / .claudeignore
```

## Framework Skills

Skills provided by the ADD framework (invoked via `/command-name`):

### Knowhow Management

| Skill | Invocation | Description |
|---|---|---|
| **add-knowhow** | `/add-knowhow <topic>` | Records implementation insights in `docs/knowhow/`. Automatically checks for duplicates and merges with existing knowhow |
| **add-knowhow-index** | `/add-knowhow-index [reindex]` | References the knowhow index, or rebuilds it with `reindex` |
| **add-knowhow-filter** | `/add-knowhow-filter <plan-path>` | Filters and returns only knowhow relevant to a given Plan |

### Development Loop

| Skill | Invocation | Description |
|---|---|---|
| **add-dev-loop** | `/loop 1h /add-dev-loop` | Autonomously selects unfinished tasks from TODO.md, implements them, runs quality verification, and commits |

### Experience Management

| Skill | Invocation | Description |
|---|---|---|
| **add-experience** | `/add-experience` | Validates file mention syntax in skill experience files (`.exp.md`) |

### GUI Testing (Optional)

To enable, set `enable = true` in `.claude/add-Behavior.toml`. macOS only.

| Skill | Invocation | Description |
|---|---|---|
| **add-gui-test** | `/add-gui-test <scenario>` | Runs GUI tests based on scenarios in `docs/test-scenarios/` |
| **add-annotate-grid** | `/add-annotate-grid <path>` | Draws grid lines and coordinate labels on PNG images (for LLM coordinate recognition) |
| **add-clip-image** | `/add-clip-image <path>` | Clips a specified region from a PNG image (for extracting areas of interest) |

## Framework Agents

Sub-agents automatically launched during quality gates and boot sequences:

| Agent | Purpose | Trigger |
|---|---|---|
| **add-knowhow-agent** | Filters knowhow relevant to a Plan | Boot sequence (at task start) |
| **add-code-review-agent** | Reviews code quality and readability | Quality verification (at task completion) |
| **add-security-review-agent** | Inspects and reports security vulnerabilities | Quality verification (optional) |
| **add-contribution-agent** | Detects contribution candidates for the framework | Quality verification (at task completion) |
| **add-ui-test-agent** | Visual UI verification via screenshots and image analysis | Quality verification (optional) |

## Development Process

```
Plan → Implementation → Quality Verification → Commit
```

- **Plan-Driven**: Review plans, not code. Sound plans are accepted; AI ensures implementation quality
- **Boot Sequence**: At session start, reads Feedback → TODO → Progress to understand current state
- **Quality Gate**: Build/Lint/Test → Code Review → Security Review (optional)
- **Parallel Implementation**: Parallel subtask execution using git worktrees

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.
