#!/bin/bash

source ~/.dotfiles_config

DUNST_CONFIG_FILE="$DOTFILES_HOME/config/i3/dunstrc"
DUNST_BIN="$DOTFILES_HOME/config/i3/bin/dunst"

killall dunst
"$DUNST_BIN" -config "$DUNST_CONFIG_FILE" &
