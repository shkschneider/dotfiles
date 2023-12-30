#!/usr/bin/env bash

command -v bluetoothctl >/dev/null || exit 1

case $1 in
    discoverable)
        bluetoothctl discoverable ${2:-on}
        ;;
    pairable)
        bluetoothctl pairable ${2:-on}
        ;;
    enable|up|on)
        bluetoothctl power on
        ;;
    disable|down|off)
        bluetoothctl power off
        ;;
    *)
        [ -n "$(bluetoothctl list 2>/dev/null | tr -d "\n")" ] && echo "on" || echo "off"
        ;;
esac

# EOF
