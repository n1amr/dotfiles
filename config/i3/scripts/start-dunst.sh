#!/bin/bash

# depends on: apt install libxdg-basedir1

source ~/.dotfiles_config
source "$DOTFILES_HOME/bin/utils/flock"

if ! exlock_now; then
    echo "Error: Could not get lock $LOCKFILE"
    exit 1
fi

DUNST_CONFIG_FILE="$DOTFILES_HOME/config/i3/dunstrc"
DUNST_BIN="$DOTFILES_HOME/config/i3/bin/dunst"

if pgrep -x dunst > /dev/null; then
    echo "Another instance of dunst is running. Kill it first"
    exit 1
fi

exit_trap() {
    killall -15 dunst
}
trap exit_trap EXIT

while true; do
    msg="A new dunst instance started at $(date -Isec)"
    echo "$msg"
    (
        sleep 1
        notify-send -t 5000 -a 'dunst' "Dunst Started" "$msg"
    ) &
    "$DUNST_BIN" -config "$DUNST_CONFIG_FILE"
    sleep 0.5
done
