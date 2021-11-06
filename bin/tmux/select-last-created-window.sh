#!/bin/bash

tmux select-window -t "$(tmux list-windows -F "#{window_id}" | tail -n 1)"
