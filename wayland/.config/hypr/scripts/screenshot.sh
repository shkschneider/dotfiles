#!/usr/bin/env bash

command -v hyprshot >/dev/null || exit 1

DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
[ -d "$DIR" ] || DIR="$HOME"
NAME="$(date +%Y-%m-%d_%H:%M).png"

case $1 in
    [Ww]indow)
        hyprshot --output-folder "$DIR" --filename "$NAME" --mode window --current --silent
        ;;
    [Aa]rea|[Rr]egion|[Zz]one)
        hyprshot --output-folder "$DIR" --filename "$NAME" --mode region --silent
        #grim -g "$(slurp)"
        ;;
    *)
        hyprshot --output-folder "$DIR" --filename "$NAME" --mode output --current --silent
        #grim
        ;;
esac

# EOF
