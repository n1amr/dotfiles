#!/bin/bash

# Depends on playerctl
# https://github.com/acrisci/playerctl/releases

playectl_command="$1"

LAST_ACCESSED_PLAYER_FILE="$(dirname "${BASH_SOURCE[0]}")/.media-control.last-accessed-player"

ignored_players=(
    # vlc
)

[[ ! -f "$LAST_ACCESSED_PLAYER_FILE" ]] && touch "$LAST_ACCESSED_PLAYER_FILE"

last_accessed_player() {
    cat "$LAST_ACCESSED_PLAYER_FILE"
}

mark_accessed_player() {
    player="$1"
    echo "$player" > "$LAST_ACCESSED_PLAYER_FILE"
}

is_player_running() {
    player="$1"
    playerctl -p "$player" status > /dev/null 2>&1 \
        && ! playerctl -p "$player" status | grep 'Stopped' > /dev/null \
        && return 0
    return 1
}

is_ignored() {
    item="$1"
    for x in "${ignored_players[@]}"; do
        [[ "$item" == "$x" ]] && return 0
    done
    return 1
}

non_ignored_running_players=()
playing_players_result=()
playing_players() {
    non_ignored_running_players=()
    playing_players_result=()

    # Paused or Playing (excludes Stopped)
    running_players=( $(playerctl -l) )

    for p in "${running_players[@]}"; do
        # Skip ignored players
        is_item_in_array_input=("${ignored_players[@]}")
        if is_ignored "$p"; then
            continue
        fi

        non_ignored_running_players+=("$p")
        if is_player_running "$p"; then
            if [[ "$(playerctl -p "$p" status)" == 'Playing' ]]; then
                playing_players_result+=("$p")
            fi
        fi
    done
}

player_track_info() {
    player="$1"
    artist="$(playerctl -p "$player" metadata artist)"
    title="$(playerctl -p "$player" metadata title)"
    output="$title - $artist"
    if [[ "$output" == ' - ' ]]; then
        output=''
    fi
    echo "$output"
}

selected_player=''
select_player() {
    # First non ignored player in Playing state
    playing_players
    for p in "${playing_players_result[@]}"; do
        selected_player="$p"
        break
    done

    # Last accessed player
    if [[ -z "$selected_player" ]]; then
        last_player="$(last_accessed_player)"
        if ! is_ignored "$last_player"; then
            selected_player="$last_player"
        fi
    fi
}

control_player() {
    player="$1"
    action="$2"
    mark_accessed_player "$player"
    playerctl -p "$player" "$action"
}

is_playing() {
    for player in "${playing_players_result[@]}"; do
        echo 'true'
        return
    done
    echo 'false'
}

is_running() {
    for player in "${non_ignored_running_players[@]}"; do
        echo 'true'
        return
    done
    echo 'false'
}

select_player
if [[ -z "$selected_player" ]]; then
    exit
fi

case "$playectl_command" in
    is-running)     is_running                                   ;;
    is-playing)     is_playing                                   ;;
    active-player)  echo "$selected_player"                      ;;
    track-info)     player_track_info "$selected_player"         ;;
    play-pause)     control_player "$selected_player" play-pause ;;
    next)           control_player "$selected_player" next       ;;
    prev)           control_player "$selected_player" previous   ;;
    play)           control_player "$selected_player" play       ;;
    pause)          control_player "$selected_player" pause      ;;
esac
