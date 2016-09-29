#!/bin/bash

icon="/home/pints/.i3/i3lock/icon.png"
tmpbg='/tmp/screen.png'
tmpbg_lego='/tmp/lego_screen.png'
tmp_parts='/tmp/parts*'
tmp_lock='/tmp/lock_screen.png'

#Grab current screen contents
scrot -z -q 100 "$tmpbg"

#Pixelate (unused)
#convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
#composite -gravity center "$icon" "$tmpbg" "$tmpbg"

#Split into multiple parts
convert "$tmpbg" -repage 1280x800 "$tmpbg"
convert "$tmpbg" -crop 320x800 /tmp/parts-%d.png

#Legofy, 4 processes parallel
legofy --scale 60 /tmp/parts-0.png &
legofy --scale 60 /tmp/parts-1.png &
legofy --scale 60 /tmp/parts-2.png &
legofy --scale 60 /tmp/parts-3.png &

wait

#rejoin to full resolution
convert /tmp/lego_parts-* +append "$tmpbg_lego"

wait

#resize to screen geometry
convert "$tmpbg_lego" -resize 1280x800 "$tmpbg_lego"

#add lock icon to centre of modified screenshot
composite -gravity center "$icon" "$tmpbg_lego" "$tmp_lock"

#enable i3lock with colours & modified image
i3lock --textcolor=ffffff00 --insidecolor=ffffff00 --ringcolor=ffffff00 --linecolor=ffffff00 --keyhlcolor=FF000080 --ringvercolor=0000FF00 --insidevercolor=00000000 --ringwrongcolor=00000055 --insidewrongcolor=FF00001c  -i "$tmp_lock"

#clean up
rm "$tmpbg"
rm "$tmpbg_lego"
rm /tmp/parts*
rm /tmp/lego_*
rm "$tmp_lock"


