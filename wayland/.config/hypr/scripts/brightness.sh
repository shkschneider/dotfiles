#!/usr/bin/env bash

command -v brightnessctl >/dev/null || exit 1

function _notify() {
    local b=$(brightnessctl info | grep -oP '[0-9]+%' | tr -d '%')
    sh ~/.config/hypr/scripts/notify.sh notify-low \
        "Brightness" "$@ ($b%)" -h int:value:$b \
        -h string:x-dunst-stack-tag:brightness
}

case $1 in
    increase|more|plus)
        brightnessctl set 5%+
        _notify "increase"
        ;;
    decrease|less|minus)
        brightnessctl set 5%-
        _notify "decrease"
        ;;
    *[0-9]*)
        brightnessctl set ${1/[^0-9]/}%
        _notify "set"
        ;;
    *)
        brightnessctl info | grep -oP '[0-9]+%' | tr -d '%'
        ;;
esac

# EOF
