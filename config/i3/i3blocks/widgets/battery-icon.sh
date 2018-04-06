#!/bin/bash

charging_icon=''
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
show_charging_icon="false"
if [[ "$charging" == 'true' ]]; then
    charging_icon_color="$color_success"
    if [[ "$battery_level" = '4' ]]; then
        battery_icon_color="$color_success"
    fi
    show_charging_icon="true"
else
    if [[ "$battery_level" -ge '2' ]]; then
        charging_icon_color="$color_default"
        battery_icon_color="$color_default"
    elif [[ "$battery_level" -ge '1' ]]; then
        charging_icon_color="$color_warning"
        battery_icon_color="$color_warning"
        show_charging_icon="true"
    else
        charging_icon_color="$color_danger"
        battery_icon_color="$color_danger"
        show_charging_icon="true"
    fi
fi

html=''
[[ "$show_charging_icon" == "true" ]] && html+="<span foreground='$charging_icon_color'>${charging_icon}</span> "
html+="<span foreground='$battery_icon_color'>${battery_icon}</span>" 

echo "<span>${html}</span>" 
