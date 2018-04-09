#!/bin/bash

source ~/.dotfiles_config

"$DOTFILES_HOME/config/i3/scripts/lock.sh" && sleep 1 && systemctl hibernate
