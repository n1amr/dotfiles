#!/bin/sh

can_execute () {
    { which "$@" || type "$@"; } > /dev/null 2>&1
}

can_execute realpath || realpath () {
    local p
    for p in "$@"; do
        if [ -d "$p" ]; then
            echo "$(cd "$p" && pwd -P)"
        elif [ -f "$p" ]; then
            if [ -L "$p" ]; then
                readlink -f "$p"
            else
                echo "$(cd "$(dirname "$p")" && pwd -P)/$(basename "$p")"
            fi
        else
            local parent="$(dirname "$p")"
            if [ -d "$parent" ]; then
                echo "$(cd "$parent" && pwd -P)/$(basename "$p")"
            else
                echo >&2 "$0: $p: No such file or directory"
            fi
        fi
    done
}
