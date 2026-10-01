# Python 3.14 Migration

This guide records the fixes applied after switching pyenv to Python 3.14.6.
The verified package versions were IPython 9.17.1 and ranger-fm 1.9.4.

## Apply on Another Machine

### 1. Update and install the dotfiles

Pull the repository changes, then rerun the installer so the IPython and Ranger
configuration links point to the updated files:

```bash
cd ~/.dotfiles
git pull
./install
```

Verify the IPython profile link:

```bash
readlink -f ~/.ipython/profile_default
```

It should resolve to:

```text
~/.dotfiles/config/ipython/profile_default
```

### 2. Select Python 3.14.6 and install runtime packages

Python packages installed under an older pyenv version are not available under
Python 3.14. Install IPython and Ranger into the new interpreter:

```bash
pyenv global 3.14.6
python --version
python -m pip install 'ipython==9.17.1' 'ranger-fm==1.9.4'
pyenv rehash
```

Expected interpreter:

```text
Python 3.14.6
```

The important Ranger package name is `ranger-fm`, not `ranger`.

### 3. Update the per-machine breakpoint hook

The `custom/` directory is machine-local and may not be updated by Git. In
`custom/config/dotfiles/shellrc/hooks/post-shellrc.sh`, replace:

```bash
export PYTHONBREAKPOINT='IPython.embed'
```

with:

```bash
export PYTHONBREAKPOINT='dotfiles_breakpoint.ipython'
```

If the file has no `PYTHONBREAKPOINT` setting, add the new export.

The shared shell configuration adds `config/python` to `PYTHONPATH`, making the
`dotfiles_breakpoint` module importable. The tcsh configuration sets both
values directly.

### 4. Reload the shell

Existing shells retain the old aliases and environment variables. Reload each
active shell or open a new terminal:

```bash
exec "$SHELL"
```

For long-running tmux sessions, reload each existing pane that should receive
the new environment.

## Fixes Applied

### IPython launcher

The old launch command accessed an internal module through:

```python
import IPython
IPython.terminal.ipapp.launch_new_instance()
```

IPython 9 no longer exposes `terminal` as a top-level `IPython` attribute. The
launcher and shell aliases now use the supported public API:

```python
from IPython import start_ipython
start_ipython()
```

The `bin/ipython` wrapper also forwards command-line arguments and uses `exec`
so signals and exit statuses reach the Python process directly.

Verify:

```bash
ipython --version
ipython --no-banner -c 'print("ipython-started")'
```

Expected output includes:

```text
9.17.1
ipython-started
```

### IPython theme configuration

IPython 9 deprecated `TerminalInteractiveShell.highlighting_style`, and the
setting no longer has any effect. The old `paraiso-dark` override was removed.

The active theme is selected through `InteractiveShell.colors`. Theme names
must be lowercase:

```python
c.InteractiveShell.colors = 'linux'
```

An optional dark theme remains documented in the profile:

```python
# c.InteractiveShell.colors = 'gruvbox-dark'
```

To use Gruvbox, comment out the `linux` line and uncomment the
`gruvbox-dark` line. Do not enable both.

Verify the active theme:

```bash
ipython --no-banner -c 'print(get_ipython().colors)'
```

### IPython vi mode

IPython was loading vi mode, but prompt_toolkit waited for possible multi-key
Emacs mappings after Escape. The profile now uses:

```python
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
c.TerminalInteractiveShell.timeoutlen = 0.1
```

This restores a responsive transition from `[ins]` to `[nav]`. Disabling the
Emacs bindings means Emacs-specific insert-mode shortcuts are no longer mixed
into vi insert mode.

Verify interactively:

```bash
ipython
```

Press Escape. The prompt marker should change from `[ins]` to `[nav]`, after
which vi movement keys such as `h`, `l`, `0`, and `$` should work.

### Colored embedded IPython breakpoints

Python's built-in `breakpoint()` was configured with:

```bash
PYTHONBREAKPOINT='IPython.embed'
```

IPython 9's `embed()` defaults to the `nocolor` theme, even when the normal
profile selects another theme. The new `config/python/dotfiles_breakpoint.py`
hook reads `InteractiveShell.colors` from the active IPython profile and passes
it explicitly to `embed()`.

The required environment is:

```bash
export PYTHONPATH="$DOTFILES_HOME/config/python${PYTHONPATH:+:$PYTHONPATH}"
export PYTHONBREAKPOINT='dotfiles_breakpoint.ipython'
```

Verify:

```bash
python -c 'import dotfiles_breakpoint; print(dotfiles_breakpoint.__file__)'
python -c 'breakpoint()'
```

Inside the embedded shell, run:

```python
print(get_ipython().colors)
```

It should print the same theme configured in the IPython profile, currently
`linux`. Exit the embedded shell with `exit`.

### Ranger under Python 3.14

The Ranger failure was caused by a stale pyenv shim resolving to an executable
installed under the renamed Python 3.7 environment. Its shebang still pointed
to the removed path:

```text
~/.pyenv/versions/3.7.2/bin/python3.7
```

The fix was:

```bash
python -m pip install 'ranger-fm==1.9.4'
pyenv rehash
```

Verify that Ranger now resolves under Python 3.14:

```bash
pyenv which ranger
head -n 1 "$(pyenv which ranger)"
TERM=xterm-256color ranger --version
```

Expected paths and versions include:

```text
~/.pyenv/versions/3.14.6/bin/ranger
Python version: 3.14.6
ranger version: ranger 1.9.4
```

In the repository's Ranger mappings, lowercase `q` closes the current tab and
uppercase `Q` exits Ranger.

## Final Verification Checklist

Run these checks after migrating another machine:

```bash
python --version
ipython --version
ipython --no-banner -c 'print(get_ipython().colors)'
python -c 'import dotfiles_breakpoint; print(dotfiles_breakpoint.__file__)'
pyenv which ranger
TERM=xterm-256color ranger --version
```

Then test the interactive behavior:

1. Start `ipython` and confirm Escape enters `[nav]` mode.
2. Run `python -c 'breakpoint()'` and confirm the configured theme has colors.
3. Start `ranger` and exit with uppercase `Q`.

If a command still resolves to an old Python installation, run:

```bash
pyenv rehash
hash -r
```

Then open a new shell and check the command again.
