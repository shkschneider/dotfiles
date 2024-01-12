#!/usr/bin/env bash

case $1 in
    l|[Ll]ock)
        command -v swaylock >/dev/null || exit 1
        bg="#00000000"
        fg="#ffffff"
        if command -v cool-retro-term >/dev/null ; then
            if command -v cmatrix >/dev/null ; then
                fg="#00FF41" # malachite
                cool-retro-term --default-settings --profile 'Monochrome Green' --fullscreen -T 'session-lock' -e cmatrix &
            else
                fg="#FFBF00" # amber
                cool-retro-term --default-settings --profile 'Default Amber' --fullscreen -T 'session-lock' \
                    -e sh ~/.config/hypr/scripts/pipes.sh &
            fi
        else
            c="#FFBF00" # amber
            st -T 'session-lock' -e sh ~/.config/hypr/scripts/pipes.sh &
        fi
        wid=$(hyprctl clients | grep session-lock | head -1 | awk '{print $2}')
        hyprctl dispatch togglefloating window $wid
        hyprctl dispatch centerwindow $wid
        swaylock \
            --font="Hack Nerd Font Mono" --font-size=13 \
            --ignore-empty-password \
            --separator-color="$bg" \
            --color="$bg" \
            --text-color="$fg" --text-clear-color="$fg" --text-caps-lock-color="$fg" --text-ver-color="$fg" --text-wrong-color="$c" \
            --inside-color="$bg" --inside-clear-color="$bg" --inside-caps-lock-color="$bg" --inside-ver-color="$bg" --inside-wrong-color="$bg" \
            --line-color="$bg" --line-clear-color="$bg" --line-caps-lock-color="$bg" --line-ver-color="$bg" --line-wrong-color="$bg" \
            --ring-color="$bg" --ring-clear-color="$bg" --ring-caps-lock-color="$bg" --ring-ver-color="$bg" --ring-wrong-color="$bg" \
            --key-hl-color="$fg" --bs-hl-color="$fg"
        hyprctl clients | grep -B1 -A1 'session-lock' \
            | grep pid | head | awk '{print $NF}' | xargs \
            kill
        ;;
    L|[Ll]ogout)
        if command -v loginctl ; then
            loginctl terminate-user $USER || kill -9 -1
        elif command -v systemctl ; then
            systemctl soft-reboot || kill -9 -1
        else
            kill -9 -1
        fi
        exit $?
        ;;
    [Ss]|[Ss]hutdown)
        poweroff
        exit $?
        ;;
    [Rr]|[Rr]eboot)
        reboot
        exit $?
        ;;
    *)
        exit 1
        ;;
esac

# EOF
