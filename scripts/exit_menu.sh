#!/bin/sh

# CONFIGURATION
LOCATION=0
YOFFSET=0
XOFFSET=0
WIDTH=24
WIDTH_WIDE=48
THEME=solarized

menu="$(rofi -sep "|" -dmenu -i -p "$1" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 4 -padding 20 -lines 5 <<< "Chiudi la sessione|Blocca lo schermo|Sospendi in RAM|Spegni il computer|Riavvia il computer")"
                case "$menu" in
                    *'Chiudi la sessione')  i3-msg exit ;;
                    *'Blocca lo schermo') ~/.config/i3/lock.sh ;;
                    *'Sospendi in RAM') sudo systemctl suspend ;;
                    *'Spegni il computer') sudo systemctl poweroff ;;
                    *'Riavvia il computer') sudo systemctl reboot ;;
                esac
