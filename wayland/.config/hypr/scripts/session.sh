#!/usr/bin/env bash

#command -v loginctl >/dev/null || exit 1
command -v systemctl >/dev/null || exit 1

case $1 in
    l|[Ll]ock)
        st -T session-lock -t session-lock -e sh ~/.config/hypr/scripts/pipes.sh &
        wid=$(hyprctl clients | grep session-lock | head -1 | awk '{print $2}')
        hyprctl dispatch togglefloating window $wid
        hyprctl dispatch centerwindow $wid
        swaylock \
            --font="Hack Nerd Font Mono" --font-size=13 \
            --ignore-empty-password \
            --separator-color="#00000000" \
            --color="#00000088" \
            --text-color="#ffffff" --text-clear-color="#ffffff" --text-caps-lock-color="#ffffff" --text-ver-color="#ffffff" --text-wrong-color="#ff0000" \
            --inside-color="#00000000" --inside-clear-color="#00000000" --inside-caps-lock-color="#00000000" --inside-ver-color="#00000000" --inside-wrong-color="#00000000" \
            --line-color="#00000000" --line-clear-color="#00000000" --line-caps-lock-color="#00000000" --line-ver-color="#00000000" --line-wrong-color="#00000000" \
            --ring-color="#00000000" --ring-clear-color="#00000000" --ring-caps-lock-color="#00000000" --ring-ver-color="#00000000" --ring-wrong-color="#00000000"
        hyprctl clients | grep -B1 -A1 'session-lock' \
            | grep pid | head | awk '{print $NF}' | xargs \
            kill
        ;;
    L|[Ll]ogout)
        #loginctl terminate-user $USER
        systemctl soft-reboot
        ;;
    [Ss]|[Ss]hutdown)
        systemctl poweroff
        ;;
    [Rr]|[Rr]eboot)
        systemctl reboot
        ;;
    *)
        exit 1
        ;;
esac

# EOF
