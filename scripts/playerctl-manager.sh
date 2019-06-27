#!/bin/zsh

echo $0
echo $1
echo $2

declare -a PLAYERS
#PLAYERS=(
#    "mpd"
#    "plasma-browser-integration"
#    )
PLAYERS=( $(playerctl -l) )
declare -r PLAYERS

for (( i = 1; i <= $#PLAYERS; i++ )) do
    (
        echo $PLAYERS[i]
        playerctl -p $PLAYERS[i] status
    )
done
