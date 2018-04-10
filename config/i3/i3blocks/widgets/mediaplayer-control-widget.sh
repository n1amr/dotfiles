#!/bin/bash

ICON_PLAY=''
ICON_PAUSE=''
ICON_NEXT=''
ICON_PREV=''
ICON_STOP=''

MEDIA_CONTROLLER="$(dirname "${BASH_SOURCE[0]}")/../../scripts/media-control.sh"
if [[ "$("$MEDIA_CONTROLLER" is-running)" != 'true' ]]; then
    exit
fi

BLOCK_INSTANCE="${BLOCK_INSTANCE:-status}"

handle_next()   { "$MEDIA_CONTROLLER" next; }
handle_prev()   { "$MEDIA_CONTROLLER" prev; }
handle_toggle() { "$MEDIA_CONTROLLER" play-pause; }

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
    if [[ "$("$MEDIA_CONTROLLER" is-playing)" == 'true' ]]; then
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
    "$MEDIA_CONTROLLER" track-info
}

case "$BLOCK_BUTTON" in
    1) handle_click ;;
esac

case "$BLOCK_INSTANCE" in
    status)   render_status                   ;;
    button-*) render_button "$BLOCK_INSTANCE" ;;
    *)        echo 'INVALID BLOCK_INSTANCE'   ;;
esac
