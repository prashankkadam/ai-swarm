# AI Swarm

Global [Claude Code](https://claude.com/claude-code) slash commands that turn your single-agent workflow into a multi-agent swarm — research, implement, cross-review, and iterate — all inside Claude Code.

## What This Does

Instead of one agent doing everything, your request gets routed through specialized agents that collaborate and critique each other's work:

```
You: /swarm Implement rotary positional embeddings

  ┌─────────────────────┐
  │   Research Agent     │  Analyzes problem, compares approaches,
  │  (ML Scientist)      │  produces implementation spec
  └──────────┬──────────┘
             │
  ┌──────────▼──────────┐
  │     Coder A          │  Implements based on spec
  │  (AI/ML Engineer)    │
  └──────────┬──────────┘
             │
  ┌──────────▼──────────┐
  │     Coder B          │  Reviews with skeptical, evidence-based
  │  (Reality Checker)   │  approach — defaults to NEEDS_REVISION
  └──────────┬──────────┘
             │
        NEEDS_REVISION? ──→ Roles swap, iterate (max 3x)
             │
  ┌──────────▼──────────┐
  │   Research Agent     │  Final review — checks algorithmic
  │  (Final Review)      │  correctness against spec
  └──────────┬──────────┘
             │
          Done ✓
```

## Commands

| Command | What it does |
|---|---|
| `/swarm <task>` | Full pipeline — research → implement → cross-review → iterate → final review |
| `/research <question>` | Research agent answers your question. No code written. |
| `/review [files]` | Two independent reviewers analyze your code in parallel |

## Agent Personas

### Research Agent — Senior ML Research Scientist
- Compares 2+ approaches before recommending one
- References specific papers and arxiv IDs
- Produces concrete specs with acceptance criteria
- Knows what works in practice vs. what's hype

### Coder A & B — AI/ML Engineer
- PyTorch, TensorFlow, JAX, Hugging Face expertise
- Production standards: type hints, docstrings, <100ms inference targets
- Handles numerical stability, edge cases, MLOps concerns
- **Roles swap each iteration** — prevents blind spots

### Reviewer — Reality Checker
- Defaults to NEEDS_REVISION (not APPROVED)
- ML-specific checklist: tensor shapes, memory leaks, gradient issues, reproducibility
- No vague praise — every claim backed by evidence from the code
- First implementations needing 1-2 revisions is normal and healthy

## Install

```bash
git clone https://github.com/prashankkadam/ai-swarm.git
cd ai-swarm
./install.sh
```

This copies the commands to `~/.claude/commands/` where they're available globally in every project. Your project's own `CLAUDE.md` stays untouched.

## Uninstall

```bash
cd ai-swarm
./uninstall.sh
```

## How It Works Under the Hood

No frameworks, no servers, no dependencies. The slash commands are markdown files that instruct Claude Code to spawn subagents using its native Agent tool. Each subagent gets a specialized persona and task, and the orchestration logic (routing, role-swapping, iteration control) is defined in the command prompts themselves.

```
~/.claude/commands/
├── swarm.md        # Full pipeline orchestration
├── research.md     # Research-only routing
└── review.md       # Dual reviewer routing
```

## Acknowledgements

Agent personas inspired by [agency-agents](https://github.com/msitarzewski/agency-agents) — a library of 100+ specialized AI agent personas.
