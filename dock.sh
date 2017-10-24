#!/bin/bash

xrandr --output DP1 --auto --left-of eDP1 && xrandr --output eDP1 --off
pkill lemonbuddy && i3-msg restart
./.fehbg
