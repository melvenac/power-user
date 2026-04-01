# Changelog

All notable changes to the Power User curriculum.

## [v1.0.1] - 2026-04-01

### Fixed
- **Antivirus false positive:** Changed Windows setup from `irm | iex` to two-step download-then-run to avoid Norton/McAfee AMSI blocks
- **PowerShell explanation:** Added beginner-friendly explanation of what PowerShell is and how to open it
- **Setup script:** Replaced `Invoke-Expression` with call operator in `Check-Command` to reduce AMSI triggers

### Added
- Antivirus troubleshooting section in Lesson 00 (Norton, McAfee, Windows Defender)
- Antivirus row in README troubleshooting table
- `.agents/` and `.claude/rules/` added to `.gitignore` (development framework, not student content)

## [v1.0.0] - 2026-04-01

### Added
- **9-module curriculum** (39 lessons) covering beginner to capstone
  - Module 00: Getting Started (setup, what is CC, install, first task)
  - Module 01: Fundamentals (terminal vs chat, tools, commands, output, two-gear prompts, context)
  - Module 02: Configuration (CLAUDE.md, permissions, .agents/, /bootstrap)
  - Module 03: MCP & Tools (what is MCP, first server, practical servers, ecosystem)
  - Module 04: Memory & Context (memory layers, context management, persistent knowledge)
  - Module 05: Multi-Agent (why multi-agent, agent tool, decomposition, teams)
  - Module 06: Skills & Hooks (custom commands, hooks, skills, automation layer)
  - Module 07: Building Your Stack (stack selection, Aaron's stack, other paths, journey)
  - Module 08: The Framework (capstone — 4 guided sessions with Self-Improving Agent)
- **Glossary** with 50+ terms defined in plain English
- **Setup scripts** for Windows (PowerShell) and Mac/Linux (bash)
- **Exercise: Plugins & MCP Servers** — guided installation of essential plugins
- **Stack guides** for web (Next.js + Convex) and local (Python CLI)
- **Session commands** (/start, /end, /task, /sync) bundled in `commands/`
- **`/bootstrap` global command** — scaffolds CLAUDE.md + .agents/ + commands for any project
- **Permissions walkthrough** — 3-tier model with Bash pattern matching
