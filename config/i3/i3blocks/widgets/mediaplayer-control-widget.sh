#!/bin/bash

ICON_PLAY=''
ICON_PAUSE=''
ICON_NEXT=''
ICON_PREV=''
ICON_STOP=''

BLOCK_INSTANCE="${BLOCK_INSTANCE:-status}"

playerctl status > /dev/null 2>&1 \
    && ! playerctl status | grep 'Stopped' > /dev/null \
    && is_running='true' || is_running='false'
if [[ "$is_running" == 'false' ]]; then
    exit
fi

handle_next() { playerctl next; }
handle_prev() { playerctl previous; }
handle_toggle() { playerctl play-pause; }

handle_click() {
    case "$BLOCK_INSTANCE" in
        button-toggle) handle_toggle ;;
        button-prev)   handle_prev ;;
        button-next)   handle_next ;;
    esac
}

render_prev_button() { echo "$ICON_PREV"; }
render_next_button() { echo "$ICON_NEXT"; }
render_toggle_button() {
    if playerctl status | grep 'Playing' > /dev/null; then
        echo "$ICON_PAUSE"
    else
        echo "$ICON_PLAY"
    fi
}

render_button() {
    button_type="$1"
    case "$button_type" in
        button-toggle) render_toggle_button ;;
        button-prev)   render_prev_button ;;
        button-next)   render_next_button ;;
    esac
}

render_status() {
    artist="$(playerctl metadata artist)"
    title="$(playerctl metadata title)"
    output="$title - $artist"
    if [[ "$output" == ' - ' ]]; then
        output=''
    fi
    echo "$output"
}

case "$BLOCK_BUTTON" in
    1) handle_click ;;
esac

case "$BLOCK_INSTANCE" in
    status)   render_status ;;
    button-*) render_button "$BLOCK_INSTANCE" ;;
    *)        echo 'INVALID BLOCK_INSTANCE' ;;
esac
