#!/bin/bash

ICON_PLAY=''
ICON_PAUSE=''
ICON_NEXT=''
ICON_PREV=''
ICON_STOP=''

MEDIA_CONTROLLER="$(dirname "${BASH_SOURCE[0]}")/../../scripts/media-control.sh"
if ! "$MEDIA_CONTROLLER" is-running > /dev/null 2>&1; then
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
        button-next)   handle_next ;;
        status)        handle_status_click ;;
    esac
}

render_prev_button() { echo "$ICON_PREV"; }
render_next_button() { echo "$ICON_NEXT"; }
render_toggle_button() {
    if "$MEDIA_CONTROLLER" is-playing > /dev/null 2>&1; then
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

MAX_STATUS_LENGTH=20
render_status() {
    title="$("$MEDIA_CONTROLLER" track-info title)"
    artist="$("$MEDIA_CONTROLLER" track-info artist)"

    full_status="$title - $artist"

    if [[ "${#title}" -gt "$MAX_STATUS_LENGTH" ]]; then
        title="${title:0:$MAX_STATUS_LENGTH - 3}..."
    fi
    if [[ "${#artist}" -gt "$MAX_STATUS_LENGTH" ]]; then
        title="${artist:0:$MAX_STATUS_LENGTH - 3}..."
    fi

    short_status="$title - $artist"

    [[ "$full_status" = ' - ' ]] && full_status="[$("$MEDIA_CONTROLLER" active-player)]"
    [[ "$short_status" = ' - ' ]] && short_status="[$("$MEDIA_CONTROLLER" active-player)]"
    echo "$full_status"
    echo "$short_status"
}

handle_status_click() {
    app="$("$MEDIA_CONTROLLER" active-player)"
    title="$("$MEDIA_CONTROLLER" track-info title)"
    artist="$("$MEDIA_CONTROLLER" track-info artist)"
    [[ -z "$title" ]] && title='Unknown'
    [[ -z "$artist" ]] && artist='Unknown'

    icon_file="$("$MEDIA_CONTROLLER" track-info artFile)"

    notify-send -t 5000 -a "$app" "$title" "by $artist" -i "$icon_file"
}

case "$BLOCK_BUTTON" in
    1) handle_click ;;
esac

case "$BLOCK_INSTANCE" in
    status)   render_status                   ;;
    button-*) render_button "$BLOCK_INSTANCE" ;;
    *)        echo 'INVALID BLOCK_INSTANCE'   ;;
esac
