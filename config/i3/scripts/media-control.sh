#!/bin/bash

# Depends on playerctl
# https://github.com/acrisci/playerctl/releases

source ~/.dotfiles_config
CUSTOM_PLAYERCTL="$DOTFILES_HOME/bin/custom-playerctl"
[[ ! -x "$CUSTOM_PLAYERCTL" ]] && CUSTOM_PLAYERCTL='playerctl'

LAST_ACTIVE_PLAYER_FILE="$(dirname "${BASH_SOURCE[0]}")/.media-control.last-active-player.tmp"
FOCUSED_PLAYER_FILE="$(dirname "${BASH_SOURCE[0]}")/.media-control.focused-player.tmp"

ignored_players=(
    # vlc
)

[[ ! -f "$LAST_ACTIVE_PLAYER_FILE" ]] && touch "$LAST_ACTIVE_PLAYER_FILE"

clean_focuded_player_file_if_old() {
    if [[ -f "$FOCUSED_PLAYER_FILE" ]]; then
        if [ "$(( $(date +"%s") - $(stat -c "%Y" "$FOCUSED_PLAYER_FILE") ))" -gt "5" ]; then
            rm -f "$FOCUSED_PLAYER_FILE"
        fi
    fi
}

clean_focuded_player_file_if_old

last_active_player() {
    if [[ -f "$LAST_ACTIVE_PLAYER_FILE" ]]; then
        cat "$LAST_ACTIVE_PLAYER_FILE"
    fi
}

focused_player() {
    if [[ -f "$FOCUSED_PLAYER_FILE" ]]; then
        cat "$FOCUSED_PLAYER_FILE"
    fi
}

mark_active_player() {
    local player="$1"
    [[ -n "$player" ]] && echo "$player" > "$LAST_ACTIVE_PLAYER_FILE"
}

mark_focused_player() {
    local player="$1"
    [[ -n "$player" ]] && echo "$player" > "$FOCUSED_PLAYER_FILE"
}

is_player_running() {
    local player="$1"
    if "$CUSTOM_PLAYERCTL" -p "$player" status | grep -P 'Playing|Paused' > /dev/null; then
        return 0
    fi
    return 1
}

is_player_playing() {
    local player="$1"

    if "$CUSTOM_PLAYERCTL" -p "$player" status | grep -P 'Playing' > /dev/null; then
        return 0
    fi
    return 1
}

is_ignored() {
    local item="$1"
    local p
    for p in "${ignored_players[@]}"; do
        [[ "$item" == "$p" ]] && return 0
    done
    return 1
}

non_ignored_running_players=()
playing_players_result=()
playing_players() {
    non_ignored_running_players=()
    playing_players_result=()

    # Paused or Playing (excludes Stopped)
    local running_players=( $("$CUSTOM_PLAYERCTL" -l) )

    local p
    for p in "${running_players[@]}"; do
        # Skip ignored players
        local is_item_in_array_input=("${ignored_players[@]}")
        if is_ignored "$p"; then
            continue
        fi

        non_ignored_running_players+=("$p")
        if is_player_running "$p"; then
            if [[ "$("$CUSTOM_PLAYERCTL" -p "$p" status)" == 'Playing' ]]; then
                playing_players_result+=("$p")
            fi
        fi
    done
}

player_track_info() {
    local player="$1"
    local tag="$2"

    if ! is_player_running "$player"; then
        echo ''
        return
    fi

    if [[ -z "$tag" ]]; then
        local artist="$("$CUSTOM_PLAYERCTL" -p "$player" metadata artist)"
        local title="$("$CUSTOM_PLAYERCTL" -p "$player" metadata title)"
        local output="$title - $artist"
        if [[ "$output" == ' - ' ]]; then
            output=''
        fi
        echo "$output"
    else
        echo "$("$CUSTOM_PLAYERCTL" -p "$player" metadata "$tag")"
    fi
}

selected_player=''
select_player() {
    playing_players

    if [[ "${#playing_players_result[@]}" == 1 ]]; then
        selected_player="${playing_players_result[0]}"
        mark_active_player "$selected_player"
    fi

    [[ -n "$selected_player" ]] && return

    # Last active player
    local last_player="$(last_active_player)"
    if is_player_running "$last_player"; then
        selected_player="$last_player"
    fi

    [[ -n "$selected_player" ]] && return

    selected_player="${non_ignored_running_players[0]}"
}

control_player() {
    local player="$1"
    local action="$2"
    mark_active_player "$player"
    "$CUSTOM_PLAYERCTL" -p "$player" "$action"
}

is_playing() {
    local player="$1"
    if [[ -z "$player" ]]; then
        player="$selected_player"
    elif [[ "$player" = '<ANY>' ]]; then
        for player in "${playing_players_result[@]}"; do
            echo true && return 0
        done
        echo false && return 1
    fi

    if is_player_playing "$player"; then
        echo 'true' && return 0
    fi
    echo 'false' && return 1
}

is_running() {
    local player="$1"
    if [[ -z "$player" ]]; then
        for player in "${non_ignored_running_players[@]}"; do
            echo true && return 0
        done
        echo false && return 1
    else
        if is_player_running "$player"; then
            echo 'true' && return 0
        fi
        echo 'false' && return 1
    fi
}

focus_player() {
    local player="$1"
    if is_player_running "$player"; then
        mark_focused_player "$player"
        if is_player_playing "$player"; then
            mark_active_player "$player"
        fi
        if ! is_playing '<ANY>'; then
            mark_active_player "$player"
        fi
    fi
}

list_playing_players() {
    local player
    for player in "${playing_players_result[@]}"; do
        echo "$player"
    done
}

list_running_players() {
    local player
    for player in "${non_ignored_running_players[@]}"; do
        echo "$player"
    done
}

display_notification() {
    "$CUSTOM_PLAYERCTL" -p "$selected_player" notification
}

select_player
if [[ -n "$(focused_player)" ]]; then
    selected_player="$(focused_player)"
fi
if [[ -z "$selected_player" ]]; then
    echo "There is no running player"
    exit 1
fi

playectl_command="$1"
shift
case "$playectl_command" in
    active-player)   echo "$selected_player"                         ;;
    is-running)      is_running "$@"                                 ;;
    is-playing)      is_playing "$@"                                 ;;
    focus-player)    focus_player "$@"                               ;;
    playing-players) list_playing_players                            ;;
    running-players) list_running_players                            ;;
    track-info)      player_track_info "$selected_player" "$@"       ;;
    play-pause)      control_player "$selected_player" play-pause    ;;
    next)            control_player "$selected_player" next          ;;
    prev)            control_player "$selected_player" previous      ;;
    play)            control_player "$selected_player" play          ;;
    pause)           control_player "$selected_player" pause         ;;
    notification)    display_notification                            ;;
    *)               echo "Unrecognized command '$playectl_command'" ;;
esac
