#!/bin/bash

touchpad_id="$(xinput --list | grep 'Touchpad' -i | head -1 | cut -d = -f 2 | awk '{print $1}')"
echo "Touchpad ID: $touchpad_id"

prop_name='libinput Natural Scrolling Enabled'

# distance="$(xinput --list-props "$touchpad_id" | grep "$prop_name" | cut -d , -f 2 | awk '{print $1}')"
# echo "Distance: $distance"
# if [[ $distance -gt 0 ]]; then
#   echo "Distance not negative => NEGATING!!"
#   xinput --set-prop "$touchpad_id" "$prop_name" -$distance, -$distance
# fi

echo "Setting 2 finger scrolling"
xinput --set-prop "$touchpad_id" "$prop_name" 1
