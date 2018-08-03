#!/bin/bash

ICON_PLAY=''
ICON_PAUSE=''
ICON_NEXT=''
ICON_PREV=''
ICON_STOP=''
ICON_MUSIC=''
ICON_PLAYER=''

source ~/.dotfiles_config
if [[ "$DOTFILES_CONFIG_I3_DISABLE_MEDIA_WIDGET" == 'true' ]]; then
    echo >&2 'Widget is disabled by variable DOTFILES_CONFIG_I3_DISABLE_MEDIA_WIDGET'
    exit 0
fi

MEDIA_CONTROLLER="$DOTFILES_HOME/config/i3/bin/mediactl"
BLOCK_INSTANCE="${BLOCK_INSTANCE:-status}"

handle_next()   { "$MEDIA_CONTROLLER" next; }
handle_prev()   { "$MEDIA_CONTROLLER" prev; }
handle_toggle() { "$MEDIA_CONTROLLER" play-pause; }
handle_status_click() { "$MEDIA_CONTROLLER" notification; }

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

escape_html() {
    sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
}

generate_status_markup() {
    title="$(echo "$1" | escape_html)"
    artist="$(echo "$2" | escape_html)"
    placeholder="$(echo "$3" | escape_html)"
    if [[ -z "$title" ]] && [[ -z "$artist" ]]; then
        echo "<span color='#BDBDBD'><b>$ICON_PLAYER</b> <i>$placeholder</i></span>"
    else
        title="${title:-Unknown}"
        echo -n "<span color='#FFD54F'><b>$ICON_MUSIC $title</b></span>"
        if [[ -n "$artist" ]]; then
            echo -n " <small>|</small> <span color='#00ff00'><b>$ICON_MUSIC $artist</b></span>"
        fi
        echo
    fi
}

MAX_STATUS_LENGTH=10
render_status() {
    title="$("$MEDIA_CONTROLLER" track-info title)"
    artist="$("$MEDIA_CONTROLLER" track-info artist)"

    placeholder="$("$MEDIA_CONTROLLER" active-player)"

    full_status="$(generate_status_markup "$title" "$artist" "$placeholder")"

    if [[ "${#title}" -gt "$MAX_STATUS_LENGTH" ]]; then
        title="${title:0:$MAX_STATUS_LENGTH - 3}..."
    fi
    if [[ "${#artist}" -gt "$MAX_STATUS_LENGTH" ]]; then
        artist="${artist:0:$MAX_STATUS_LENGTH - 3}..."
    fi

    short_status="$(generate_status_markup "$title" "$artist" "$placeholder")"

    echo "$full_status"
    echo "$short_status"
}

handle_events() {
    case "$BLOCK_BUTTON" in
        1) handle_click ;;
    esac
}

render() {
    if ! "$MEDIA_CONTROLLER" is-running > /dev/null 2>&1; then
        exit
    fi

    case "$BLOCK_INSTANCE" in
        status)   render_status                   ;;
        button-*) render_button "$BLOCK_INSTANCE" ;;
        *)        echo 'INVALID BLOCK_INSTANCE'   ;;
    esac
}

handle_events &
render &
