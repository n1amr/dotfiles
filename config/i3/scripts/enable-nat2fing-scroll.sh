#!/bin/bash

touchpad_id=$(xinput --list | grep Touchpad -i | cut -d = -f 2 | awk {'print $1'})
echo "Touchpad ID: $touchpad_id"

distance=$(xinput --list-props $touchpad_id | grep "Synaptics Scrolling Distance" | cut -d , -f 2 | awk {'print $1'})
echo "Distance: $distance"

if [[ $distance -gt 0 ]]; then
  echo "Distance not negative => NEGATING!!"
  xinput --set-prop $touchpad_id "Synaptics Scrolling Distance" -$distance, -$distance
fi

echo "Setting 2 finger scrolling"
xinput --set-prop $touchpad_id "Synaptics Two-Finger Scrolling" 1, 1
