#!/bin/sh
# export PATH=$HOME/.scripts:$PATH
# export PATH=$HOME/.local/bin/statusbar:$PATH
# export QT_QPA_PLATFORM=xcb
# export QT_QPA_PLATFORMTHEME='breeze-dark'
# export GTK_THEME=Breeze-Dark
# export GTK2_RC_FILES=/home/franco/.gtkrc-2.0-kde4
# export KDEDIRS=/usr
# export KDE_SESSION_UID=1000
# export KDE_SESSION_VERSION=5
# export XDG_CONFIG_DIRS=/etc/xdg:/usr/share/kde-settings/kde-profile/default/xdg
# export XDG_CURRENT_DESKTOP=KDE
# export XDG_SESSION_DESKTOP=KDE
# export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:/usr/share/pkgconfig
# export QT_PLUGIN_PATH=/usr/lib64/qt5/plugins/akonadi:/usr/lib64/qt5/plugins/audio:/usr/lib64/qt5/plugins/bearer:/usr/lib64/qt5/plugins/crypto:/usr/lib64/qt5/plugins/designer:/usr/lib64/qt5/plugins/digikam:/usr/lib64/qt5/plugins/egldeviceintegrations:/usr/lib64/qt5/plugins/gamepads:/usr/lib64/qt5/plugins/generic:/usr/lib64/qt5/plugins/geometryloaders:/usr/lib64/qt5/plugins/geoservices:/usr/lib64/qt5/plugins/iconengines:/usr/lib64/qt5/plugins/imageformats:/usr/lib64/qt5/plugins/kactivitymanagerd:/usr/lib64/qt5/plugins/kauth:/usr/lib64/qt5/plugins/kcms:/usr/lib64/qt5/plugins/kdeconnect:/usr/lib64/qt5/plugins/kf5:/usr/lib64/qt5/plugins/kpackage:/usr/lib64/qt5/plugins/ktexteditor:/usr/lib64/qt5/plugins/ktorrent:/usr/lib64/qt5/plugins/kwin:/usr/lib64/qt5/plugins/mediaservice:/usr/lib64/qt5/plugins/okular:/usr/lib64/qt5/plugins/org.kde.kdecoration2:/usr/lib64/qt5/plugins/org.kde.kglobalaccel5.platforms:/usr/lib64/qt5/plugins/org.kde.kwin.platforms:/usr/lib64/qt5/plugins/org.kde.kwin.scenes:/usr/lib64/qt5/plugins/phonon4qt5_backend:/usr/lib64/qt5/plugins/phonon_platform:/usr/lib64/qt5/plugins/plasma:/usr/lib64/qt5/plugins/plasmacalendarplugins:/usr/lib64/qt5/plugins/platforminputcontexts:/usr/lib64/qt5/plugins/platforms:/usr/lib64/qt5/plugins/platformthemes:/usr/lib64/qt5/plugins/playlistformats:/usr/lib64/qt5/plugins/position:/usr/lib64/qt5/plugins/printsupport:/usr/lib64/qt5/plugins/PyQt5:/usr/lib64/qt5/plugins/qmltooling:/usr/lib64/qt5/plugins/renderplugins:/usr/lib64/qt5/plugins/sceneparsers:/usr/lib64/qt5/plugins/script:/usr/lib64/qt5/plugins/sensorgestures:/usr/lib64/qt5/plugins/sensors:/usr/lib64/qt5/plugins/sqldrivers:/usr/lib64/qt5/plugins/styles:/usr/lib64/qt5/plugins/texttospeech:/usr/lib64/qt5/plugins/virtualkeyboard:/usr/lib64/qt5/plugins/wayland-decoration-client:/usr/lib64/qt5/plugins/wayland-graphics-integration-client:/usr/lib64/qt5/plugins/wayland-graphics-integration-server:/usr/lib64/qt5/plugins/wayland-shell-integration:/usr/lib64/qt5/plugins/xcbglintegrations

# Composite manager:
picom_launch &

if [ "$(pgrep -f pulseaudio-control-dwm)" = "" ]; then
    pulseaudio-control-dwm --listen &
fi

if [ "$(pgrep -f dconf-service)" = "" ]; then
    /usr/libexec/dconf-service &
fi

if [ "$(pgrep -f gconfd-2)" = "" ]; then
    /usr/libexec/gconfd-2 &
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

# Network Manager applet
#if [ "$(pgrep nm-applet)" = "" ]; then
#    nm-applet &
#fi

# Automounter
if [ "$(pgrep udiskie)" = "" ]; then
    udiskie -t -f dolphin &
fi

# Clipboard manager
#env XDG_CURRENT_DESKTOP=dwm QT_QPA_PLATFORMTHEME='qt5ct' copyq &
if [ "$(pgrep copyq)" = "" ]; then
    copyq &
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
#xinput set-prop 14 306 1
#xinput set-prop 14 326 0.8
touchpad-config &

# Conky
if [ "$(pgrep conky)" = "" ]; then
    conky -c ~/.conky/conkyrc_i3 &
    conky -c ~/.conky/Gotham/Gotham_i3 &
    cd ~/.conky-weather/; ./run &
fi

# IT keymap
setxkbmap -model asus_laptop -layout it -variant winkeys &

# Allow run some GUI apps as root
if [ "$(pgrep -f polkit-kde-authentication)" = "" ]; then
    /usr/libexec/kf5/polkit-kde-authentication-agent-1 &
fi

