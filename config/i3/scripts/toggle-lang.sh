#!/bin/bash

curr_lang=$(setxkbmap -query | grep layout | awk {'print $2'})
case $curr_lang in
    us) setxkbmap ar;; 
    *)  setxkbmap us;;
esac
