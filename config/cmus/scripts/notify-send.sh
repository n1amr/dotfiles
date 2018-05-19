#!/bin/bash

exec > >(tee -a ~/log)
exec 2>&1

artist=''
status=''
title=''
while [[ $# > 0 ]]; do
    echo "$1 = $2"
    case "$1" in
        artist) artist=$2 ;;
        status) status=$2 ;;
        title) title=$2 ;;
    esac
    shift
    shift
done

if [[ "$status" = 'playing' ]]; then
    notify-send -t 2000 -a 'cmus' "$title" "by $artist"
fi
