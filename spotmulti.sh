#!/bin/bash

icon="/home/pints/.i3/i3lock/icon.png"
tmpbg="/home/pints/.i3/screen.png"
tmp_lock="/home/pints/.i3/lock_screen.png"
tmp_parts="/tmp/parts-*"

xaxis=$(xdpyinfo | grep dimensions | uniq | awk '{print $2}' | cut -d 'x' -f1)
yaxis=$(xdpyinfo | grep dimensions | uniq | awk '{print $2}' | cut -d 'x' -f2)

#Grab current screen contents
scrot -z -q 100 "$tmpbg"

#Pixelate
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"

#Split into 4 parts
convert "$tmpbg" -crop "$[xaxis / 4]"x"$yaxis" /tmp/parts-%d.png

#Tile a 10x10 circular cutout on each section
convert -sample 10x10 xc: -draw 'circle 5,5 5,9' -negate \
        -write mpr:spot +delete \
/tmp/parts-0.png -scale 100% -size "$[xaxis / 4]"x"$yaxis" tile:mpr:spot \
+swap -compose multiply -composite /tmp/parts-0.png

convert -sample 10x10 xc: -draw 'circle 5,5 5,9' -negate \
       -write mpr:spot +delete \
/tmp/parts-1.png -scale 100% -size "$[xaxis / 4]"x"$yaxis" tile:mpr:spot \
+swap -compose multiply -composite /tmp/parts-1.png

convert -sample 10x10 xc: -draw 'circle 5,5 5,9' -negate \
       -write mpr:spot +delete \
/tmp/parts-2.png -scale 100% -size "$[xaxis / 4]"x"$yaxis" tile:mpr:spot \
+swap -compose multiply -composite /tmp/parts-2.png

convert -sample 10x10 xc: -draw 'circle 5,5 5,9' -negate \
      -write mpr:spot +delete \
/tmp/parts-3.png -scale 100% -size "$[xaxis / 4]"x"$yaxis" tile:mpr:spot \
+swap -compose multiply -composite /tmp/parts-3.png

#Rejoin image components
convert "$tmp_parts" +append "$tmp_lock"

#Add a lock icon to the centre of the image
composite -gravity center "$icon" "$tmp_lock" "$tmp_lock"  

#enable i3lock with colours  modified image
i3lock --textcolor=ffffff00 --insidecolor=ffffff00 --ringcolor=ffffff00 --linecolor=ffffff00 --keyhlcolor=00FF0080 --ringvercolor=0000FF00 --insidevercolor=00000000 --ringwrongcolor=00000055 --insidewrongcolor=FF00001c  -i "$tmp_lock" 

#clean up
rm "$tmpbg" 
rm "$tmp_lock"
rm "$tmp_parts"
