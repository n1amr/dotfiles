#!/bin/bash

source ~/.dotfiles.env

CONNECTED_ICON=''
NOT_CONNECTED_ICON=''

if [[ -n "$DOTFILES_CONFIG_WIFI_INTERFACE" ]]; then
    INTERFACE="$DOTFILES_CONFIG_WIFI_INTERFACE"
else
    INTERFACE="${BLOCK_INSTANCE:-wlan0}"
fi

if [[ ! -d /sys/class/net/${INTERFACE}/wireless ]]; then
    exit 1
fi

state="$(cat /sys/class/net/${INTERFACE}/operstate)"
if [[ "$state" = 'up' ]]; then
    quelity=$(grep "$INTERFACE" /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

    echo "$CONNECTED_ICON" # full text
    echo "$CONNECTED_ICON" # short text

    # color
    if [[ $QUALITY -ge 80 ]]; then
        echo "#00FF00"
    elif [[ $QUALITY -lt 80 ]]; then
        echo "#FFF600"
    elif [[ $QUALITY -lt 60 ]]; then
        echo "#FFAE00"
    elif [[ $QUALITY -lt 40 ]]; then
        echo "#FF0000"
    fi
else
    echo "$NOT_CONNECTED_ICON"
fi
