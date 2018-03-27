#!/bin/bash

# use arandr to generate mode

# cvt 1366 768
# xrandr --newmode "1368x768_60.00"   85.25  1368 1440 1576 1784  768 771 781 798 -hsync +vsync

gtf 1366 768 60.00
xrandr --newmode "1368x768_60.00"  85.86  1368 1440 1584 1800  768 769 772 795  -HSync +Vsync

xrandr --addmode eDP1 "1368x768_60.00"
xrandr --output eDP1 --mode "1368x768_60.00"
