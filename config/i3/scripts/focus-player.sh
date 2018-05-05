#!/bin/bash

source ~/.dotfiles_config

MEDIA_CONTROLLER="$(dirname "$0")/media-control.sh"
"$MEDIA_CONTROLLER" focus-player "$("$MEDIA_CONTROLLER" running-players | dmenu -i -p 'Focus player:')"
