# Bash Script Style and Format Guide

> **Scope:** This guide reflects the conventions used in the most recent scripts
> in this repository (post-2023 commits). Earlier scripts may not fully conform.
> When writing new scripts or refactoring old ones, follow this guide.

---

## 1. Shebang

Always use `#!/bin/bash`. Do not use `#!/bin/sh` for new scripts unless the
script must run in a POSIX-only environment (e.g., `install`, `demo`). Python
utilities use `#!/usr/bin/env python`.

```bash
#!/bin/bash
```

---

## 2. Strict Mode

Place strict mode flags immediately after the shebang, before any other code.
Use `set -eu` as the standard. Add `set -x` only temporarily or conditionally
via a `--debug` flag.

```bash
#!/bin/bash

set -eu
```

- `-e`: exit immediately on error
- `-u`: treat unset variables as errors

Do **not** use `set -o pipefail` by default — it is not consistently applied
across the repo. Only add it if the script critically depends on pipeline exit
codes.

---

## 3. Script Structure

Use the `main`-first, call-at-bottom pattern for all non-trivial scripts.

```bash
#!/bin/bash

set -eu

main() {
    parse_args "$@"
    auto_calculate_args
    log_args

    # ... core logic ...
}

parse_args() { ... }
auto_calculate_args() { ... }
log_args() { ... }
fail() { echo >&2 "FAILED: $*"; exit 1; }
info() { echo "INFO: $*"; }
debug() { return; }

main "$@"
```

**Rules:**
- `main()` is defined first and called last.
- Helper functions (`fail`, `info`, `debug`) are defined before `main "$@"`.
- `main "$@"` is the **last line** of the script.

For simple, single-purpose scripts (10–20 lines) a `main()` wrapper is
optional — write top-level code directly.

---

## 4. Argument Parsing

Parse arguments in a dedicated `parse_args()` function using a
`while [ $# != 0 ]; do case ... esac; shift; done` loop.

```bash
parse_args() {
    branch=''
    remote_name='origin'
    fetch='true'
    debug='false'

    while [ $# != 0 ]; do
        case "$1" in
            --branch|-b)     branch="$2";      shift ;;
            --remote|-r)     remote_name="$2"; shift ;;
            --no-fetch)      fetch='false' ;;
            --debug)         debug='true' ;;

            *)
                if [[ -z "$branch" ]]; then
                    branch="$1"
                else
                    fail "Invalid syntax. Unknown argument: '$1'."
                fi
            ;;
        esac
        shift
    done

    if [[ "$debug" == 'true' ]]; then
        debug() { echo "DEBUG: $*"; }
        set -x
    else
        debug() { return; }
    fi
}
```

**Rules:**
- Initialise all variables at the top of `parse_args()` with safe defaults.
- Flags that take a value `shift` twice (once in the case arm, once at the end of the loop).
- Boolean flags are **strings** `'true'`/`'false'`, never `0`/`1`.
- Align case arms vertically: pad the `)` and the assignment so values start at the same column.
- Long option first (`--flag`), short option alias second (`-f`), separated by `|`.
- Unknown positional arguments: assign to the relevant variable if unset; otherwise call `fail`.

---

## 5. Derived Arguments

After `parse_args`, compute values that depend on the parsed arguments in a
separate `auto_calculate_args()` function.

```bash
auto_calculate_args() {
    if [[ -z "$branch" ]]; then
        branch="$(git current-branch)"
    fi
}
```

---

## 6. Debug Logging

Use the conditional `debug` function pattern. Define it inside `parse_args` so
it is available for the rest of the script.

```bash
if [[ "$debug" == 'true' ]]; then
    debug() { echo "DEBUG: $*"; }
    set -x
else
    debug() { return; }
fi
```

Call debug logging with key=value pairs:

```bash
log_args() {
    debug branch="$branch"
    debug remote_name="$remote_name"
    debug fetch="$fetch"
}
```

---

## 7. Output and Logging

**Inline (script does not source `bin/lib/log`):**

```bash
info()    { echo "INFO: $*"; }
fail()    { echo >&2 "FAILED: $*"; exit 1; }
```

**With lib (script sources `bin/lib/log`):**

```bash
source "$DOTFILES_HOME/bin/lib/log"
# Provides: info, warning, error, fatal
```

`bin/lib/log` writes to stderr **and** to `$DOTFILES_LOG_FILE`, with a
timestamp prefix: `[YYYY-MM-DD HH:MM:SS.ns] LEVEL: message`.

**Rules:**
- Normal output → stdout.
- Errors and diagnostics → stderr (`>&2`).
- Usage messages → stderr with `exit 1`.
- `fatal()` prints and exits. `fail()` (inline version) does the same.

---

## 8. Environment Setup

Source `~/.dotfiles.env` at the top of scripts that need `DOTFILES_HOME` or
other exported variables.

```bash
source ~/.dotfiles.env
```

Source library files using `$DOTFILES_HOME`:

```bash
source "$DOTFILES_HOME/bin/lib/log"
source "$DOTFILES_HOME/bin/lib/assert_file"
```

Augment `PATH` when calling sibling scripts:

```bash
PATH="$DOTFILES_HOME/bin:$PATH"
```

---

## 9. Variable Naming

| Scope | Convention | Example |
|---|---|---|
| Local (inside function) | `snake_case`, declared with `local` | `local branch_name=''` |
| Script-global | `snake_case` | `profile_dir=''` |
| Environment / exported | `UPPER_SNAKE_CASE` | `DOTFILES_HOME`, `SYNCF_DESTINATION_DIR` |
| Config knobs (feature flags) | `DOTFILES_CONFIG_*` | `DOTFILES_CONFIG_EMAIL_NOTIFICATION` |

Always `local` function-scoped variables:

```bash
send_email() {
    local subject="$1"
    local body
    body="$(cat)"
    ...
}
```

---

## 10. Quoting

- **Always double-quote variable expansions**: `"$var"`, `"${var}"`.
- **Single-quote literal strings**: `'true'`, `'false'`, `'origin'`.
- **Arrays**: expand with `"${array[@]}"`.

```bash
local attachments=("$@")
rsync "${RSYNC_ARGS[@]}" "$src" "$dst"
```

---

## 11. Conditionals and Tests

Use `[[ ... ]]` (bash extended test) throughout. Reserve `[ ... ]` for places
where POSIX portability is required (e.g., inside `#!/bin/sh` scripts or
subshells that may run under `sh`).

```bash
# Preferred
if [[ "$fetch" == 'true' ]]; then ...
if [[ -z "$branch" ]]; then ...
if [[ -n "${var:-}" ]]; then ...

# POSIX fallback (in sh-compatible scripts only)
if [ -f "$config_file" ]; then ...
```

Default-value expansion for potentially unset variables inside `[[ ]]`:

```bash
if [[ -z "${var:-}" ]]; then ...
```

---

## 12. Command Substitution

Always use `$()`. Never use backticks.

```bash
repo_dir="$(git rev-parse --show-toplevel)"
timestamp="$(date -u +"%Y%m%d%H%M%S")"
```

---

## 13. Arrays

Use bash arrays for lists of arguments or file paths. Never construct a
command as a single string.

```bash
RSYNC_ARGS=(-av --delete --relative)
RSYNC_ARGS+=(--exclude-from="$excludes_file")
RSYNC_ARGS+=(--log-file="$log_file")

rsync "${RSYNC_ARGS[@]}" "$src" "$dst"
```

---

## 14. Error Handling

Prefer early exit with `fail` over deeply nested conditionals.

```bash
fail() { echo >&2 "FAILED: $*"; exit 1; }

[[ -f "$config_file" ]] || fail "Config file not found: $config_file"
```

For blocks that are allowed to fail (e.g., looping rsync), temporarily disable
`-e`:

```bash
set +e
while IFS='' read -r line; do
    rsync "${RSYNC_ARGS[@]}" "$line" "$dst"
done < "$includes_file"
set -e
```

---

## 15. Usage Messages

Print usage to stderr and exit 1.

```bash
if [[ "$#" -eq 0 ]]; then
    echo "Usage: echo 'body' | $0 <SUBJECT> [ATTACHMENTS...]" >&2
    exit 1
fi
```

---

## 16. Library Guard Pattern

Library files (under `bin/lib/`) guard against double-sourcing:

```bash
[ -n "$DOTFILES_HELPERS" ] && return || export DOTFILES_HELPERS=true
```

---

## 17. Indentation and Formatting

- **4 spaces** per indent level. No tabs in bash scripts.
- Case arms: align `)` and the RHS value vertically using spaces:

  ```bash
  case "$1" in
      --branch|-b)     branch="$2";      shift ;;
      --remote|-r)     remote_name="$2"; shift ;;
      --no-fetch)      fetch='false' ;;
  esac
  ```

- One blank line between top-level function definitions.
- No trailing whitespace.

---

## 18. Comments

- Use comments for **section labels**, **install hints**, **non-obvious logic**, and **TODOs**.
- Do not comment self-evident code.

```bash
# Config locations
config_file="$("$DOTFILES_HOME/bin/custom-env-resolve" 'config/marks.tsv')"

# Install using: brew install qrencode
qrencode -o "$out_path"

# TODO: Fix email authentication failure.
```

---

## 19. `exec` and Process Replacement

Use `exec` when a script's sole remaining job is to hand off to another process
(avoids a dangling shell process):

```bash
exec "${SHELL:-bash}"
exec "$DOTFILES_HOME/install" "$@"
```

---

## 20. Script Checklist

Before committing a new or refactored script verify:

- [ ] `#!/bin/bash` shebang
- [ ] `set -eu` at the top
- [ ] `main()` function defined; `main "$@"` as the last line (for non-trivial scripts)
- [ ] Argument parsing in `parse_args()`; defaults initialised at the top of that function
- [ ] All variables inside functions declared with `local`
- [ ] All variable expansions double-quoted
- [ ] Boolean flags stored as strings `'true'`/`'false'`
- [ ] Error messages sent to stderr (`>&2`)
- [ ] Usage message printed to stderr on bad input
- [ ] `[[ ]]` used for conditionals
- [ ] `$()` used for command substitution (no backticks)
