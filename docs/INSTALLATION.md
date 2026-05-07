# Installation

## Quick Start

Clone the repository and run the installer:

```bash
git clone https://github.com/n1amr/dotfiles.git ~/.dotfiles --recursive
~/.dotfiles/install
```

To try the repo in isolation instead of installing into the current home:

```bash
~/.dotfiles/demo
```

## Main Entry Points

### `install`

The installer is the source of truth for repository setup.

Supported flags documented by the script itself:

- `--user-home <path>`: destination home directory
- `--dotfiles-path <path>`: explicit repository path
- `--env` or `-e <name>`: environment name
- `--user` or `-u <name>`: target user name
- `--group` or `-g <name>`: target primary group
- `--no-interactive` or `-f`: disable prompts and force linking behavior
- `--interactive` or `-i`: enable prompts

When interactive mode is enabled, the installer prompts for:

- environment name
- home directory
- user name
- group name
- dotfiles directory
- custom repo URL

### `demo`

The demo script:

- sets `DOTFILES_ENV=demo`
- creates `custom/tmp/demo_home`
- runs the installer against that temporary home
- opens a shell whose `HOME`, `DOTFILES_HOME`, and environment variables point at the sandbox

This is the safest way to inspect the repo behavior without changing the real account.

### `bin/dotfiles`

Thin command dispatcher with the following subcommands:

- `install`: execs the top-level installer
- `update` and `pull`: exec `bin/dotfiles-update`
- `config`: opens core environment files in `$EDITOR`

### `bin/dotfiles-update`

Performs a repo update workflow for both the main repo and `custom/`:

- stash local changes
- check out `master`
- fetch and reset to `origin/master`
- pull with rebase and recurse-submodules
- update submodules recursively
- re-run the installer in forced mode

Because this command uses forceful Git operations and stashing, it should be treated as an opinionated personal maintenance command rather than a conservative updater.

## What The Installer Links

The installer links classic dotfiles into the destination home, including:

- `.driverc`
- `.emacs`
- `.emacs.d`
- `.fonts`
- `.gitconfig`
- `.gitignore`
- `.inputrc`
- `.irbrc`
- `.profile`
- `.sqliterc`
- `.tcshrc`
- `.tmux.conf`
- `.vim`
- `.wgetrc`
- `.xinitrc`
- `.xsessionrc`
- `.zshenv`

It also maps shell startup files:

- `.bashrc` -> `config/shellrc`
- `.zshrc` -> `config/shellrc`

And it creates XDG and app-specific links for areas such as:

- VS Code user settings
- feh
- i3
- Neovim
- ranger
- VLC
- IPython
- irssi
- Jupyter
- marks data
- shell history
- Vim configuration

## Custom Repository Behavior

The installer expects `custom/` to be available. If `custom/.git` is missing, it attempts to clone the repository specified by `DOTFILES_CUSTOM_REPO_URL`, which defaults to `git@github.com:n1amr/dotfiles.custom`.

This keeps private or machine-local data outside the main repo while still fitting into the install flow.

## Generated Environment Files

The installer creates `custom/dotfiles.env` if missing. That file exports:

- `DOTFILES_ENV`
- `DOTFILES_ENV_HOME`
- `DOTFILES_ENV_USER`
- `DOTFILES_ENV_GROUP`
- `DOTFILES_HOME`
- path additions for `custom/bin` and `bin`
- roots for `ndenv`, `pyenv`, `rbenv`, and a local build prefix

For non-default environments it also creates `custom/env/<env>/dotfiles.env` if missing.

## Verification In CI

The GitHub Actions workflow installs the dotfiles on Ubuntu for several environment names, reinstalls them, and then sources both `~/.zshrc` and `~/.bashrc`. That means the repository is at least continuously checked for:

- install idempotence across supported environments
- basic shell startup validity on Linux

The documented matrix includes `default`, `dell`, `azure`, `toshiba`, `pi`, and `ms`.
