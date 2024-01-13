#!/usr/bin/env bash

lock=' Lock'
logout=' Logout'
suspend=' Suspend'
shutdown=' Shutdown'
reboot=' Reboot'

_rofi() {
  rofi -dmenu -i -p "$(hostname)" -mesg "Uptime: $(uptime -p | cut -c4-)" -theme ~/.config/rofi/powermenu.rasi
}

# TODO: check for binaries

option=$(echo -e "$lock\n$logout\n$suspend\n$shutdown\n$reboot" | _rofi)
case $option in
  *Lock)
    i3lockr --blur=25
    ;;
  *Logout)
    kill -9 -1
    ;;
  *Suspend)
    exit 1
    ;;
  *Shutdown)
    loginctl poweroff
    ;;
  *Reboot)
    loginctl reboot
    ;;
  *) exit 1 ;;
esac
