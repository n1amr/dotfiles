# Configuration

## Tracked Configuration

The `config/` directory is the canonical source for repository-managed settings. At the top level it contains shell configuration and multiple tool-specific subdirectories.

Representative top-level entries include:

- `bash-init.sh`
- `completions.bash`
- `completions.zsh`
- `dircolors`
- `driverc`
- `emacs` and `emacs.d/`
- `gitconfig` and `gitconfig.env`
- `inputrc`
- `irbrc`
- `keybindings.bash`
- `keybindings.zsh`
- `nvim.vim`
- `profile`
- `shellrc`
- `sqliterc`
- `tcshrc`
- `tmux.conf`
- `tmux.init`
- `wgetrc`
- `xinitrc`
- `xsessionrc`
- `zshenv`

Tool or platform directories include areas such as:

- `cmus/`
- `feh/`
- `fedora/`
- `fonts/`
- `i3/`
- `ipython/`
- `irssi/`
- `jupyter/`
- `mutt/`
- `oh-my-zsh/`
- `ranger/`
- `simple/`
- `ubuntu/`
- `vim/`
- `vlc/`
- `vscode/`

## Home Directory Mapping

The installer links a mix of classic dotfiles and XDG-style config paths.

Examples:

- `~/.bashrc` and `~/.zshrc` both point at `config/shellrc`
- `~/.vimrc` points at `config/vim/vimrc`
- `~/.config/nvim/init.vim` points at `config/nvim.vim`
- `~/.config/Code/User/` points at `config/vscode/User/`

This means one repository file can feed multiple tools or compatibility paths.

## Custom State

`custom/` is the writable and environment-aware side of the setup.

Observed structure includes:

- `custom/bin/`
- `custom/config/`
- `custom/env/`
- `custom/history/`
- `custom/keys/`
- `custom/backups/`
- `custom/notes/`
- `custom/scripts/`
- `custom/tmp/`
- `custom/dotfiles.env`
- `custom/custom_install`

The installer ensures several of these directories exist and seeds shell history files if needed.

## Environment Overrides

Environment-specific files live under:

```text
custom/env/<environment>/...
```

Examples of logical paths that can be resolved per environment include:

- `config/gitconfig.env`
- `config/jupyter/custom`
- `config/jupyter/jupyter_notebook_config.py`
- `config/jupyter/nbconfig/notebook.json`
- `config/marks.tsv`
- `config/dotfiles/shellrc/hooks/post-shellrc.sh`

These are opened by `bin/dotfiles config` and resolved by `bin/custom-env-resolve`.

## Configuration Philosophy

The repo separates concerns in a practical way:

- tracked defaults live in `config/`
- local and sensitive data live in `custom/`
- machine-specific overrides live in `custom/env/<env>/`
- installation composes them through symlinks rather than copying files

That approach keeps the repository reproducible while still supporting laptop-, host-, or employer-specific variants.
