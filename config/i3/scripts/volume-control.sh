#!/bin/bash

source ~/.dotfiles_config

DELTA="5"
MIXER='pulse'

notify() {
    paplay "$DOTFILES_HOME/resources/sounds/audio-volume-change.oga"
}

volume_up() {
    volume_unmute
    # pactl set-sink-volume 0 +5%
    amixer -D "$MIXER" sset Master "${DELTA}%+"
}

volume_down() {
    volume_unmute
    # pactl set-sink-volume 0 -5%
    amixer -D "$MIXER" sset Master "${DELTA}%-"
}

volume_mute_toggle() {
    pactl set-sink-mute 0 toggle
}

volume_unmute() {
    pactl set-sink-mute 0 off
}

if [[ -n "$2" ]]; then
    DELTA="$2"
fi

case "$1" in
    up)          volume_up          && notify ;;
    down)        volume_down        && notify ;;
    mute-toggle) volume_mute_toggle && notify ;;
    *) echo "Error in arguments: $@" ;;
esac
