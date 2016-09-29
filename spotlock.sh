#!/bin/bash

icon="/home/pints/.i3/i3lock/icon.png"
tmpbg="/home/pints/.i3/screen.png"
tmp_lock="/home/pints/.i3/lock_screen.png"

xaxis=$(xdpyinfo | grep dimensions | uniq | awk '{print $2}' | cut -d 'x' -f1)
yaxis=$(xdpyinfo | grep dimensions | uniq | awk '{print $2}' | cut -d 'x' -f2)

#Grab current screen contents
scrot -z -q 100 "$tmpbg"

#Pixelate
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"

#Tile a 10x10 circular cutout
convert -sample 10x10 xc: -draw 'circle 5,5 5,9' -negate \
        -write mpr:spot +delete \
"$tmpbg" -scale 100% -size "$xaxis"x"$yaxis" tile:mpr:spot \
+swap -compose multiply -composite "$tmp_lock"

#Add a lock icon to the centre of the image
composite -gravity center "$icon" "$tmp_lock" "$tmp_lock"  

#enable i3lock with colours  modified image
i3lock --textcolor=ffffff00 --insidecolor=ffffff00 --ringcolor=ffffff00 --linecolor=ffffff00 --keyhlcolor=00FF0080 --ringvercolor=0000FF00 --insidevercolor=00000000 --ringwrongcolor=00000055 --insidewrongcolor=FF00001c  -i "$tmp_lock" 

#clean up
rm "$tmpbg" 
rm "$tmp_lock" 
