#!/usr/bin/env bash

case $1 in
    notify-low)
        shift
        dunstify --urgency="low" --timeout=1000 "$@"
        ;;
    notify-normal)
        dunstify --urgency="normal" --timeout=1000 "$@"
        shift
        ;;
    notify-critical)
        dunstify --urgency="critical" --timeout=1000 "$@"
        shift
        ;;
    close)
        dunstctl close $@
        ;;
    close-all)
        dunstctl close-all
        ;;
    test)
        dunstctl close-all
        killall dunst
        notify-send -u low "Low" "low..."
        notify-send -u normal "Normal" "normal1...\nnormal2...\nnormal3..."
        notify-send -u critical -i ~/.config/dunst/icons/critical.svg "Critical" "critical..."
        notify-send -h int:value:42 -u normal "Progress" "progress..."
        ;;
    *)
        dunstify --help
        exit 1
        ;;
esac

exit 0

# EOF
