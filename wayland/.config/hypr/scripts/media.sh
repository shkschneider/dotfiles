#!/usr/bin/env bash

command -v playerctl >/dev/null || exit 1

function _notify() {
    local meta=$(playerctl metadata --format '{{title}}')
    sh ~/.config/hypr/scripts/notify.sh notify-low \
        "Media" "$@\n$meta" \
        -h string:x-dunst-stack-tag:media
}

case $1 in
    toggle)
        playerctl play-pause
        _notify "play/pause"
        ;;
    play)
        playerctl play
        _notify "play"
        ;;
    pause)
        playerctl pause
        _notify "pause"
        ;;
    next)
        playerctl next
        _notify "next"
        ;;
    previous)
        playerctl previous
        _notify "previous"
        ;;
    *)
        playerctl status
        ;;
esac

# EOF
