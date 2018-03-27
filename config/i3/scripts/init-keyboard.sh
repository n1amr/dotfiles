#!/bin/bash

setxkbmap -layout us,ar
setxkbmap -option ""
setxkbmap -option caps:escape
setxkbmap -option grp:alt_shift_toggle
setxkbmap -option shift:both_capslock

type numlockx > /dev/null 2>&1 && numlockx on

[ -x ~/.xinitrc ] && ~/.xinitrc
