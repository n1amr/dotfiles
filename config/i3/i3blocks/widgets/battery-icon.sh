#!/bin/bash

charging_icon=''
non_charging_icon=''
battery_icons=(
    
    
    
    
    
)

color_default='#FFFFFF'
color_danger='#DC3545'
color_success='#28A745'
color_warning='#FFC107'

battery_status="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)"

charging_state="$(echo "$battery_status" | grep 'state')"
if echo "$charging_state" | grep 'discharging' > /dev/null; then
    charging='false'
else
    charging='true'
fi

battery_percentage="$(echo "$battery_status" | grep 'percentage' | grep -Po '(\d+)(?=%)')"
battery_level="$(( $battery_percentage / 25 ))"
battery_icon="${battery_icons[$battery_level]}"

charging_icon_color="$color_default"
battery_icon_color="$color_default"
if [[ "$charging" == 'true' ]]; then
    charging_status_icon="$charging_icon"
    charging_icon_color="$color_success"
    if [[ "$battery_level" = '4' ]]; then
        battery_icon_color="$color_success"
    fi
else
    charging_status_icon="$non_charging_icon"
    if [[ "$battery_level" -ge '2' ]]; then
        charging_icon_color="$color_default"
        battery_icon_color="$color_default"
    elif [[ "$battery_level" -ge '1' ]]; then
        charging_icon_color="$color_warning"
        battery_icon_color="$color_warning"
    else
        charging_icon_color="$color_danger"
        battery_icon_color="$color_danger"
    fi
fi

render() {
    html=''
    html+="<span foreground='$charging_icon_color'>${charging_status_icon}</span> "
    html+="<span foreground='$battery_icon_color'>${battery_icon}</span> "
    html+="<span>${battery_percentage}%</span>"

    echo "<span>${html}</span>"
}

handle_click() {
    "$(dirname "$0")/battery.sh"
}

case "$BLOCK_BUTTON" in
    1) handle_click ;;
    *) render       ;;
esac
