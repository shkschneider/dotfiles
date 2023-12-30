#!/usr/bin/env bash

if [ -n "$(pidof waybar)" ] ; then
    killall -SIGUSR2 waybar
else
    waybar &
fi

# EOF
