#!/bin/bash

source "$HOME/.profile"

# Composite manager:
picom_launch &

if [ "$(pgrep -f dconf-service)" = "" ]; then
    /usr/libexec/dconf-service &
fi

if [ "$(pgrep -f gconfd-2)" = "" ]; then
    /usr/libexec/gconfd-2 &
fi

if [ "$(pgrep -f xiccd)" = "" ]; then
    /usr/bin/xiccd &
fi
# Disable DPMS
xset -dpms &
xset s off &

# Setting the background:
feh --bg-fill ~/.config/i3/default-wallpaper &

# Starts dunst for notifications:
if [ "$(pgrep dunst)" = "" ]; then
    dunst &
fi

# xbanish - hide the X11 mouse cursor when a key is pressed
if [ "$(pgrep xbanish)" = "" ]; then
    xbanish &
fi

# Automounter
if [ "$(pgrep udiskie)" = "" ]; then
    udiskie -s -f dolphin &
fi

# Clipboard manager
if [ "$(pgrep clipit)" = "" ]; then
    clipit &
fi

# Redshift
if [ "$(pgrep redshift-gtk)" = "" ]; then
    redshift-gtk &
fi

# KDE Connect
if [ "$(pgrep kdeconnect-indi)" = "" ]; then
    env XDG_CURRENT_DESKTOP=dwm QT_QPA_PLATFORMTHEME='qt5ct' kdeconnect-indicator &
fi

# Touchpad tap and speed
touchpad-config &

# Conky
if [ "$(pgrep conky)" = "" ]; then
    conky -c ~/.conky/conkyrc_i3 &
    conky -c ~/.conky/Gotham/Gotham_i3 &
    cd ~/.conky-weather/; ./run &
fi

# Allow run some GUI apps as root
if [ "$(pgrep -f polkit-kde-authentication)" = "" ]; then
    /usr/libexec/kf5/polkit-kde-authentication-agent-1 &
fi

