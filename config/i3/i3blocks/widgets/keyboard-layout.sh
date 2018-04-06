#!/bin/bash

current_layout() {
    setxkbmap -query | grep 'layout:' | sed 's/layout:\s\+//'
}

handle_click() {
    if [[ "$(current_layout)" == 'us' ]]; then
        setxkbmap -layout ar
    else
        setxkbmap -layout us
    fi
}

render() {
    current_layout | tr a-z A-Z
}

case "$BLOCK_BUTTON" in
    1) handle_click ;;
esac

render
