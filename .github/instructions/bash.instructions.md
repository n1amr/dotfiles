
---
name: Bash conventions
description: Conventions for creating and modifying Bash scripts.
applyTo: "**/*.sh"
---

# Bash scripting conventions

- Use `#!/bin/bash`, unless POSIX compatibility is explicitly required.
- Place `set -eu` immediately after the shebang.
- Do not use `set -o pipefail` unless pipeline failure handling is explicitly required.
- Use `main()` for non-trivial scripts and call `main "$@"` as the final line.
- Define helper functions before the main invocation.
- Parse arguments in a dedicated `parse_args()` function using a `while`/`case`/`shift` loop.
- Initialize argument variables with safe defaults.
- Store boolean flags as `"true"` or `"false"`.
- Use `[[ ]]` for conditionals and double-quote variable expansions.
- Use single quotes for literal strings where appropriate.
- Use `"$(...)"` instead of backticks.
- Declare function-scoped variables with `local`.
- Use arrays for argument lists, not command strings.
- Prefer early exits with `fail()` over deeply nested conditionals.
- Send diagnostics and usage errors to stderr.
- Use four-space indentation, no tabs, and no trailing whitespace.
- Align `case` arms vertically and leave one blank line between top-level functions.
- Use conditional debug logging and `exec` when handing off to another process.
- Preserve existing repository formatting and naming conventions.
