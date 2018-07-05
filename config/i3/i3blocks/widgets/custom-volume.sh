#!/bin/bash

source ~/.dotfiles_config
I3_HOME="$DOTFILES_HOME/config/i3"

SOUND_ICON=''
NO_SOUND_ICON=''

dir="$(dirname "${BASH_SOURCE[@]}")"
VOLUMECTL="$I3_HOME/bin/volumectl"

[[ -n "$BLOCK_BUTTON" ]] && (
    exec > /dev/null 2>&1

    case $BLOCK_BUTTON in
      1) "$VOLUMECTL" mute-toggle ;;  # click, mute/unmute
      4) "$VOLUMECTL" up          ;;  # scroll up
      5) "$VOLUMECTL" down        ;;  # scroll down
    esac
)

percentage="$(BLOCK_BUTTON='' "$dir/volume.sh" "${1:-5}" "${2:-pulse}")"

if [[ "$percentage" != 'MUTE' ]]; then
    echo "$SOUND_ICON $percentage"
else
    echo "$NO_SOUND_ICON"
    echo "$NO_SOUND_ICON"
    echo '#FF0000'
fi
