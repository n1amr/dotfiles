# Scripts and configuration for CLI

<div align="center">
  <a href="https://github.com/n1amr/dotfiles/actions">
    <img alt="Build" src="https://github.com/n1amr/dotfiles/workflows/Build/badge.svg" />
  </a>
</div>

This repository is a personal dotfiles and CLI toolkit. It combines shell configuration, editor and terminal setup, an environment-aware installation system, and a large collection of utility scripts under `bin/`.

## Overview

- Main entrypoints: `install`, `demo`, `bin/dotfiles`, `bin/dotfiles-update`
- Main config surface: `config/`
- Main executable surface: `bin/` with 100+ top-level scripts plus support directories
- Custom and machine-specific state: `custom/`
- External dependencies: git submodules under `notes/`, `thirdparty/`, and some config directories

## Try It

```bash
git clone https://github.com/n1amr/dotfiles.git ~/.dotfiles --recursive
~/.dotfiles/demo
```

## Installation

```bash
git clone https://github.com/n1amr/dotfiles.git ~/.dotfiles --recursive
~/.dotfiles/install
```

## Documentation

The repository guide lives in `docs/`:

1. `docs/REPOSITORY_OVERVIEW.md` for the top-level layout and project scope.
2. `docs/INSTALLATION.md` for install, demo, and update flows.
3. `docs/ARCHITECTURE.md` for the control flow and reusable shell library patterns.
4. `docs/CONFIGURATION.md` for symlinked configs and environment-specific overrides.
5. `docs/UTILITIES.md` for the executable catalog under `bin/`.
6. `docs/AUTOMATION_AND_DEPENDENCIES.md` for cronjobs, completions, CI, and submodules.

## Scope

The repository is broad enough that some utility descriptions in the docs are necessarily inference-based when script names are more descriptive than their inline comments. The docs focus on making the full repository discoverable, explaining the core mechanics precisely, and providing a categorized index for the utility surface.
