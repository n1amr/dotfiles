#!/bin/bash

SCREENSHOTS_PATH='/mnt/Storage/Pictures/Screenshots'
scrot "$SCREENSHOTS_PATH/screenshot-%Y%m%d%H%M%S.png" -q 100
# scrot '/mnt/Storage/Pictures/Screenshots/screenshot-%Y%m%d%H%M%S.png' -q 100 -s # area
# scrot '/mnt/Storage/Pictures/Screenshots/screenshot-%Y%m%d%H%M%S.png' -q 100 -d 5 # delay
