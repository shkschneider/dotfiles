#!/usr/bin/env bash

if [ $# -gt 0 ] ; then
    cmd="${1}" ; shift
    case "${cmd}" in
        "status") playerctl -a status ;;
        "play") playerctl play ;;
        "pause") playerctl pause ;;
        "toggle") playerctl play-pause ;;
        "stop") playerctl stop ;;
        "previous") playerctl previous ;;
        "next") playerctl next ;;
        *) exit 1 ;;
    esac
else
    echo -e $(
        playerctl metadata -f '{{playerName}}\n{{status}}\n{{artist}}\n{{album}}\n{{title}}\n{{position}}\n{{mpris:length}}\n{{mpris:artUrl}}' 2>/dev/null
    )
fi

# EOF
