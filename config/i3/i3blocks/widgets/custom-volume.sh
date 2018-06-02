#!/bin/bash

source ~/.dotfiles_config
I3_HOME="$DOTFILES_HOME/config/i3"

SOUND_ICON=''
NO_SOUND_ICON=''

dir="$(dirname "${BASH_SOURCE[@]}")"

[[ -n "$BLOCK_BUTTON" ]] && (
    exec > /dev/null 2>&1

    case $BLOCK_BUTTON in
      1) "$I3_HOME/scripts/volume-control.sh" mute-toggle ;;  # click, mute/unmute
      4) "$I3_HOME/scripts/volume-control.sh" up          ;;  # scroll up
      5) "$I3_HOME/scripts/volume-control.sh" down        ;;  # scroll down
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
