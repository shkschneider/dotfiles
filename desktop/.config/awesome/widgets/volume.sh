#!/usr/bin/env bash

if [ $# -gt 0 ] ; then
    cmd="${1}" ; shift
    case "${cmd}" in
        "mute") pamixer --mute ;;
        "unmute") pamixer --unmute ;;
        "toggle") pamixer --toggle-mute ;;
        "get") pamixer --get-mute --get-volume ;;
        "set") pamixer --set-volume $@ ;;
        "increase") pamixer --increase $@ ;;
        "decrease") pamixer --decrease $@ ;;
        *) exit 1 ;;
    esac
else
    pamixer --get-mute --get-volume
fi

# EOF
