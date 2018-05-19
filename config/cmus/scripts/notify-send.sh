#!/bin/bash

set -e

artist=''
status=''
title=''
file=''
while [[ $# > 0 ]]; do
    echo "$1 = $2"
    case "$1" in
        artist) artist=$2 ;;
        status) status=$2 ;;
        title) title=$2 ;;
        file) file=$2 ;;
    esac
    shift
    shift
done

if [[ "$status" = 'playing' ]]; then
    notify-send -t 5000 -a 'cmus' "$title" "by $artist" -i "$(extract-album-art "$file")"
fi
