#!/bin/bash

source ~/.dotfiles_config

for f in "$DOTFILES_CONFIG_GOOGLE_DRIVE_ROOT/Personal/Playlists"/*.m3u; do
    dst="$DOTFILES_HOME/custom/config/cmus/playlists/$(basename "${f%.*}").pl"
    cat "$f" | sed '/^#/d' > "$dst"
done
