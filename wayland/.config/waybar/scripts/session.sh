#!/usr/bin/env bash

command -v wofi >/dev/null || exit 1

case $1 in
    l|[Ll]ock)
        r=$(echo -e "yes\nno" | wofi --dmenu --prompt="${1^}?" --lines=4)
        [ "$r" == "yes" ] || exit 1
        sh ~/.config/hypr/scripts/session.sh lock
        ;;
    L|[Ll]ogout)
        r=$(echo -e "yes\nno" | wofi --dmenu --prompt="${1^}?" --lines=4)
        [ "$r" == "yes" ] || exit 1
        sh ~/.config/hypr/scripts/session.sh logout
        ;;
    [Ss]|[Ss]hutdown)
        r=$(echo -e "yes\nno" | wofi --dmenu --prompt="${1^}?" --lines=4)
        [ "$r" == "yes" ] || exit 1
        sh ~/.config/hypr/scripts/session.sh shutdown
        ;;
    [Rr]|[Rr]eboot)
        r=$(echo -e "yes\nno" | wofi --dmenu --prompt="${1^}?" --lines=4)
        [ "$r" == "yes" ] || exit 1
        sh ~/.config/hypr/scripts/session.sh reboot
        ;;
    *)
        exit 1
        ;;
esac

# EOF
