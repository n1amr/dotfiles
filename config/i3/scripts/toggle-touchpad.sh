#!/bin/bash

touchpad_id="$(xinput --list | grep 'Touchpad' -i | head -1 | cut -d = -f 2 | awk '{print $1}')"
prop_name='Device Enabled'

current_value="$(xinput --list-props "$touchpad_id" | grep "$prop_name" | grep -Po '(\d+)$')"
if [[ "$current_value" == '1' ]]; then
    new_value='0'
else
    new_value='1'
fi

xinput --set-prop "$touchpad_id" "$prop_name" "$new_value"
