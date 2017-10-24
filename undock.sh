#!/bin/bash

xrandr --output eDP1 --auto && xrandr --output DP1 --off
pkill lemonbuddy && i3-msg restart
./.fehbg
