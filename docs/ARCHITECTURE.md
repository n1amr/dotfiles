# Architecture

## Core Design

The repository is centered on symlink-based installation plus environment-aware overrides.

The control path is:

1. determine repository root and target environment
2. ensure `custom/` exists
3. export `DOTFILES_*` variables
4. link tracked config files into the target home
5. resolve environment-specific paths where needed
6. invoke optional custom install hooks

## Key Components

### `install`

Acts as the orchestration layer. It is responsible for filesystem layout, environment setup, and high-level linking policy.

### `bin/custom-env-resolve`

Maps a logical path to the most specific available file.

Resolution behavior is:

- if `DOTFILES_ENV=default`, prefer `custom/<path>`, then tracked repo file, otherwise return the custom path that would hold the override
- if `DOTFILES_ENV` is non-default, prefer `custom/env/<env>/<path>`, then global `custom/<path>`, then tracked repo file, otherwise return the global custom path

This gives the repo a simple override chain without requiring the rest of the scripts to know where a file physically lives.

### `bin/dotfiles`

User-facing command wrapper. It centralizes a few common entrypoints and provides a convenient `config` command that opens both generic and environment-specific config files in one editor session.

### `bin/dotfiles-update`

Operational maintenance path. It updates the main repository and the custom repository and then re-runs the installer.

## Shared Shell Library

`bin/lib/` contains reusable shell components:

- `polyfills.sh`: compatibility helpers such as `realpath` support
- `assert_file`: file assertions
- `can_execute`: executable capability checks
- `flock` and `lock`: locking helpers
- `log`: logging helpers
- `lca`: likely shared path utility logic
- `utils`: generic helper functions

This directory is what makes the repo act like a toolkit rather than a loose pile of scripts.

## Configuration Strategy

The repository mixes two styles of configuration:

- directly tracked files under `config/`
- environment or machine-local overrides under `custom/`

That split allows the repo to stay portable while still supporting secrets, work-machine differences, and local-only state.

## Execution Style

The scripts that were sampled follow a consistent shell-first style:

- POSIX shell or Bash shebangs
- `set -e` and often `set -u` for fail-fast execution
- external tools composed through simple pipelines and helper scripts

The style fits a personal automation repo where transparency and composability matter more than a single monolithic application framework.

## Extension Points

The main extension points are:

- `custom/bin/` for local commands ahead of repo defaults in `PATH`
- `custom/config/` for global local config
- `custom/env/<env>/...` for environment-specific overrides
- `custom/custom_install` or environment-specific `custom_install` hooks invoked by `install`

That is the primary contract for adding new workstation-specific behavior without forking the tracked config layout.
