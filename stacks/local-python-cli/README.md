# Stack Guide: Local / CLI Workflows (Python)

This guide complements [Module 07, Lesson 03](../../curriculum/07-building-your-stack/03-other-paths.md) with hands-on setup instructions.

## The Stack

| Layer | Tool | Purpose |
|-------|------|---------|
| Language | Python 3.12+ | Versatile, massive ecosystem |
| Package Manager | uv or pip | uv is fast, pip is universal |
| CLI Framework | Typer | Type-safe CLI with auto-generated help |
| Testing | pytest | Industry standard |
| Type Checking | mypy or pyright | Add type safety to Python |
| Linting | ruff | Fast, replaces flake8 + isort + black |

## Quick Start

```bash
# Check Python version
python --version  # Need 3.12+

# Create project
mkdir my-tool && cd my-tool
python -m venv .venv
source .venv/bin/activate  # Mac/Linux
# .venv\Scripts\activate   # Windows

# Install essentials
pip install typer pytest ruff mypy

# Bootstrap for Claude Code
claude
/bootstrap
```

## CLAUDE.md Template

```markdown
# My Tool — Project Instructions

## Tech Stack
Python 3.12, pip for packages, pytest for tests,
mypy for type checking, ruff for linting.

## Commands
- Run: `python main.py`
- Test: `pytest`
- Lint: `ruff check .`
- Type check: `mypy .`
- Format: `ruff format .`

## Conventions
- Type hints on all function signatures
- Tests in tests/ mirroring src/ structure
- Use pathlib for file paths, not os.path
- Use dataclasses or pydantic for data models
- Virtual environment in .venv/ (gitignored)
```

## Key Resources

- [Python Docs](https://docs.python.org/3/)
- [Typer Docs](https://typer.tiangolo.com)
- [pytest Docs](https://docs.pytest.org)
- [Ruff Docs](https://docs.astral.sh/ruff/)
