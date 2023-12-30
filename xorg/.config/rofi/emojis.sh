#! /usr/bin/env bash

unicode=$(cat ~/.config/unicodes | \
  rofi -dmenu -i -theme ~/.config/rofi/launcher.rasi \
  -markup-rows -p "" | cut -d\' -f2 | tail -c +4 | head -c -2)

[ -n "$unicode" ] || exit 1

printf '\u'$unicode | xclip -selection c
printf '\u'$unicode

exit 0

# EOF
