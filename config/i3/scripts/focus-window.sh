#!/bin/bash

selected_line="$(wmctrl -l | cut -d ' ' --complement -f '2-4' | dmenu -i -p 'Focus window:')"
selected_id="$(echo "$selected_line" | cut -d ' ' -f 1)"
wmctrl -i -a "$selected_id"
