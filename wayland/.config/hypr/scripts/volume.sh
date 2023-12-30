#!/usr/bin/env bash

command -v pactl >/dev/null || exit 1

function _notify() {
    local v=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '[0-9][0-9]%' | tr -d '%' | head -1)
    sh ~/.config/hypr/scripts/notify.sh notify-low \
        "Volume" "$1 ($v%)" -h int:value:$v \
        -h string:x-dunst-stack-tag:volume
}

case $1 in
    toggle)
        if pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -c ': no' 2>/dev/null ; then
            pactl set-sink-mute @DEFAULT_SINK@ true
            _notify "mute"
        else
            pactl set-sink-mute @DEFAULT_SINK@ false
            _notify "unmute"
        fi
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ true
        _notify "mute"
        ;;
    unmute)
        pactl set-sink-mute @DEFAULT_SINK@ false
        _notify "unmute"
        ;;
    increase)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        _notify "increase"
        ;;
    decrease)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        _notify "decrease"
        ;;
    mic)
        if pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -c ': no' 2>/dev/null ; then
            pactl set-source-mute @DEFAULT_SOURCE@ true
            _notify "mic mute"
        else
            pactl set-source-mute @DEFAULT_SOURCE@ false
            _notify "mic unmute"
        fi
        ;;
    *[0-9]*)
        pactl set-sink-volume @DEFAULT_SINK@ ${1/[^0-9]/}%
        _notify "set"
        ;;
    *)
        pactl get-sink-volume @DEFAULT_SINK@
        pactl get-sink-mute @DEFAULT_SINK@
        ;;
esac

# EOF
