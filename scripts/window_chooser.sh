#!/bin/sh

# CONFIGURATION
LOCATION=0
YOFFSET=0
XOFFSET=0
WIDTH=48
WIDTH_WIDE=48
THEME=solarized

rofi -sep "|" -show window -i -p "$1" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 4 -padding 20
