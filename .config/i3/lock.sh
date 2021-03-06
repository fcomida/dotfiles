#!/bin/bash

# Approximate timeout rate in milliseconds (checked every 5 seconds).
timeout="60000"

# Take a screenshot:
scrot /tmp/screen.png

# Add the lock to the swirled and blurred image:
[[ -f ~/.config/i3/lock_1.png ]] && convert /tmp/screen.png -paint 1 -swirl 360  ~/.config/i3/lock_1.png -gravity center -composite -matte /tmp/screen.png

# Pause music (mocp and mpd):
pactl set-sink-mute 0 toggle # mute sound
if [ "$(mpc | grep playing)" != "" ]; then mpc pause; fi

# Lock it up!
i3lock -e -f -c 000000 -i /tmp/screen.png

# If still locked after $timeout milliseconds, turn off screen.
while [[ $(pgrep -x i3lock) ]]; do
	[[ $timeout -lt $(xssstate -i) ]] && xset dpms force off
	sleep 5
done

pactl set-sink-mute 0 toggle # unmute sound
if [ "$(mpc | grep paused)" != "" ]; then mpc play; fi
