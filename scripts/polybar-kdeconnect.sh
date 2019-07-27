#!/usr/bin/env bash

# CONFIGURATION
LOCATION=0
YOFFSET=0
XOFFSET=0
WIDTH=24
WIDTH_WIDE=48
THEME=Monokai

# Color Settings of Icon shown in Polybar
COLOR_DISCONNECTED='#000'       # Device Disconnected
COLOR_NEWDEVICE='#ff0'          # New Device
COLOR_BATTERY_90='#fff'         # Battery >= 90
COLOR_BATTERY_80='#ccc'         # Battery >= 80
COLOR_BATTERY_70='#aaa'         # Battery >= 70
COLOR_BATTERY_60='#888'         # Battery >= 60
COLOR_BATTERY_50='#666'         # Battery >= 50
COLOR_BATTERY_LOW='#f00'        # Battery <  50

# Icons shown in Polybar
ICON_SMARTPHONE=''
ICON_SMARTPHONE=''
ICON_SMARTPHONE='☎'
ICON_SMARTPHONE=''
ICON_TABLET=''
SEPERATOR='|'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

show_devices (){
    IFS=$','
    devices=""
    for device in $(qdbus-qt5 --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        if [ "$device" == "{}" ]
        then
            break
        fi

        deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
        devicename=$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$deviceid org.kde.kdeconnect.device.name)
        devicetype=$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$deviceid org.kde.kdeconnect.device.type)
        isreach="$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$deviceid org.kde.kdeconnect.device.isReachable)"
        istrust="$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$deviceid org.kde.kdeconnect.device.isTrusted)"
        if [ "$isreach" = "true" ] && [ "$istrust" = "true" ]
        then
            battery="$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$deviceid org.kde.kdeconnect.device.battery.charge)"
            icon=$(get_icon $battery $devicetype)
            devices+="%{A1:. $DIR/polybar-kdeconnect.sh; show_menu $devicename $deviceid $battery:}$icon%{A}$SEPERATOR"
        elif [ "$isreach" = "false" ] && [ "$istrust" = "true" ]
        then
            devices+="$(get_icon -1 $devicetype)$SEPERATOR"
        else
            haspairing="$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$deviceid org.kde.kdeconnect.device.hasPairingRequests)"
            if [ "$haspairing" = "true" ]
            then
                show_pmenu2 $devicename $deviceid
            fi
            icon=$(get_icon -2 $devicetype)
            devices+="%{A1:. $DIR/polybar-kdeconnect.sh; show_pmenu $devicename $deviceid $:}$icon%{A}$SEPERATOR"

        fi
    done
    if [ "$device" == "{}" ]
    then
        echo ""
    else
        echo "${devices::-1}"
    fi
}

show_menu () {
    menu="$(rofi -sep "|" -dmenu -i -p "$1" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 4 -padding 20 -lines 5 <<< "Batteria: $4%|Ping|Trova il telefono|Invia file|Disassocia")"
                case "$menu" in
                    *Ping) qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$3/ping org.kde.kdeconnect.device.ping.sendPing ;;
                    *'Trova il telefono') qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$3/findmyphone org.kde.kdeconnect.device.findmyphone.ring ;;
                    #*'Send File') qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$2/share org.kde.kdeconnect.device.share.shareUrl "file://$(zenity --file-selection)" ;;
                    *'Invia file') qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$3/share org.kde.kdeconnect.device.share.shareUrl "file://$(kdialog --getopenfilename)" ;;
                    *'Disassocia' ) qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$3 org.kde.kdeconnect.device.unpair
                esac
}

show_pmenu () {
    menu="$(rofi -sep "|" -dmenu -i -p "$1" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 1 -padding 20 -lines 1 <<< "Associa telefono")"
                case "$menu" in
                    *'Associa telefono') qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$3 org.kde.kdeconnect.device.requestPair
                esac
}

show_pmenu2 () {
    menu="$(rofi -sep "|" -dmenu -i -p "$1 ha inviato una richiesta di associazione" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH_WIDE -hide-scrollbar -line-padding 4 -padding 20 -lines 2 <<< "Accetta|Rifiuta")"
                case "$menu" in
                    *'Accetta') qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$2 org.kde.kdeconnect.device.acceptPairing ;;
                    *) qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$2 org.kde.kdeconnect.device.rejectPairing
                esac

}
get_icon () {
    if [ "$2" = "tablet" ]
    then
        icon=$ICON_TABLET
    else
        icon=$ICON_SMARTPHONE
    fi
    case $1 in
    "-1")     ICON="%{F$COLOR_DISCONNECTED}"$icon"%{F-}" ;;
    "-2")     ICON="%{F$COLOR_NEWDEVICE}"$icon"%{F-}" ;;
    5*)     ICON="%{F$COLOR_BATTERY_50}"$icon"%{F-}" ;;
    6*)     ICON="%{F$COLOR_BATTERY_60}"$icon"%{F-}" ;;
    7*)     ICON="%{F$COLOR_BATTERY_70}"$icon"%{F-}" ;;
    8*)     ICON="%{F$COLOR_BATTERY_80}"$icon"%{F-}" ;;
    9*|100) ICON="%{F$COLOR_BATTERY_90}"$icon"%{F-}" ;;
    *)      ICON="%{F$COLOR_BATTERY_LOW}"$icon"%{F-}" ;;
    esac
    echo $ICON
}

