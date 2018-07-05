#!/bin/bash

selected_line="$(wmctrl -lx | awk '{$2=$4=""; print}' | dmenu -i -p 'Focus window:')"
selected_id="$(echo "$selected_line" | cut -d ' ' -f 1)"
wmctrl -i -a "$selected_id"
