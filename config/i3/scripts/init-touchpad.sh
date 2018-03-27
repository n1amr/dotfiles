#!/bin/bash

for touchpad_id in $(xinput --list | grep 'Touchpad' -i | cut -d = -f 2 | awk '{print $1}'); do
    xinput --set-prop "$touchpad_id" 'Device Enabled' 1
    xinput --set-prop "$touchpad_id" 'libinput Natural Scrolling Enabled' 1
    xinput --set-prop "$touchpad_id" 'libinput Tapping Enabled' 1
    xinput --set-prop "$touchpad_id" 'libinput Tapping Drag Enabled' 1
    xinput --set-prop "$touchpad_id" 'libinput Tapping Button Mapping Enabled' 1, 0
done
