# Automation And Dependencies

## Cronjobs

The `bin/cronjobs/` directory contains scheduled-task entrypoints:

- `battery-check`
- `battery-low-caution`
- `download-updates`
- `hibernate-fix`
- `packt-open`
- `resend-failed-notifications`
- `ring`
- `sync`
- `twitter-bots`
- `updatedrive`
- `updatevpn`
- `youtube-dl`

These represent the automation layer of the repo: small commands designed to be invoked periodically rather than directly by hand.

## Shell Completions

The `bin/completion/` directory contains completion helpers for interactive shell usage. Observed commands include support for:

- `dotfiles`
- `jump` and `j`
- `kp`
- `marks` and `unmark`
- `sync-ssh` and `syncf`
- tmux session helpers
- the `tp_*` path helper family
- SSH aliases or wrappers

This indicates the repo aims to make its custom command set efficient to use interactively, not just available.

## Continuous Integration

The workflow in `.github/workflows/install-workflow.yml` validates installation and shell startup on Linux.

Important properties:

- triggered on pushes and pull requests to `master`
- runs in `ubuntu:18.04` container on GitHub Actions
- clones submodules
- separately clones the custom config repository into `custom/`
- installs basic shell dependencies with `apt-get`
- creates a target user per matrix entry
- runs the installer twice to verify reinstall behavior
- sources both `~/.zshrc` and `~/.bashrc`

The CI matrix currently includes:

- `default`
- `dell`
- `azure`
- `toshiba`
- `pi`
- `ms`

## Git Submodules

The repository relies on submodules both for personal extensions and third-party tools.

### Personal Repositories

- `notes` -> `n1amr/dotfiles.notes`
- `thirdparty/binaries` -> `n1amr/dotfiles.binaries`

### Editor And Shell Tooling

- `config/vim/bundle/auto-pairs`
- `config/vim/bundle/ctrlp.vim`
- `config/vim/bundle/dracula`
- `config/vim/bundle/nerdtree.vim`
- `config/vim/bundle/papercolor-theme`
- `config/vim/bundle/vim-airline.vim`
- `config/vim/bundle/vim-airline-themes.vim`
- `config/vim/bundle/vim-closetag`
- `config/vim/bundle/vim-markdown`
- `config/vim/bundle/vim-pathogen`
- `config/vim/bundle/vim-theme-chroma`
- `thirdparty/oh-my-zsh`
- `thirdparty/tmux-plugins/tmux-yank`
- `thirdparty/zsh-plugins/you-should-use`

### Additional Tools

- `thirdparty/dunst`
- `thirdparty/fzf`
- `thirdparty/git-flow-completion`
- `thirdparty/gitflow-avh`
- `thirdparty/playerctl`
- `thirdparty/vim-stream`

## Dependency Model

The repo does not declare a single package-manager-based dependency manifest. Instead, dependencies come from three places:

- operating-system packages expected by scripts and CI
- git submodules for editor and shell tooling
- the separate `custom/` repository for private or machine-local content

That model is consistent with a long-lived personal environment repo where portability matters more than one-command bootstrap purity.
