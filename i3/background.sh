#!/usr/bin/bash
files=(~/.config/arts/*)
file_name="${files[RANDOM % ${#files[@]}]}"
WALLPAPER=$(printf "%s\n" $file_name)
feh -B white --bg-fill $WALLPAPER --bg-fill $WALLPAPER

i3path='~/.config/i3/'
/usr/bin/convert -resize 1920 $file_name .config/i3/pic1.png
/usr/bin/convert +append .config/i3/pic1.png .config/i3/pic1.png .config/i3/lockscreen.png
