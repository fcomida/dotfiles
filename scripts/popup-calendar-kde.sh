#!/bin/sh

YAD_WIDTH=200
YAD_HEIGHT=300
BOTTOM=false
DATE="$(date +"%a %d %b %H:%M")"

case "$1" in
    --popup)
        eval "$(xdotool getmouselocation --shell)"

        if [ $BOTTOM = true ]; then
            : $(( pos_y = Y - YAD_HEIGHT - 20 ))
            : $(( pos_x = X - (YAD_WIDTH / 2) ))
        else
            : $(( pos_y = Y + 10 ))
            : $(( pos_x = X - 60 - (YAD_WIDTH / 2) ))
        fi

        kdialog \
            --geometry=200x300+$pos_x+$pos_y --title "Calendario" --calendar "$(date)" \
            $DATE \
            > /dev/null
        ;;
    *)
        echo "$DATE"
        ;;
esac
