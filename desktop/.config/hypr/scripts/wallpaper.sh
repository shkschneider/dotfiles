#!/usr/bin/env bash

pkill swaybg

command -v swaybg >/dev/null || exit 1

DIR=${1:-${XDG_PICTURES_DIR:-$HOME/Pictures}}
[ -d "$DIR" ] || exit 1

function _25th_hour() {
    elapsed=$(date +%H*60+%M | bc)
    hours=0
    minutes=0
    while [[ $elapsed -gt 90 ]] ; do
        hours=$((hours + 1))
        minutes=$((minutes + 30))
        if [[ $minutes -ge 60 ]] ; then
            hours=$((hours + 1))
            minutes=0
        fi
        elapsed=$((elapsed - 90))
    done
    printf "$DIR/25th_hour/%02.0f%02.0f.png\n" $hours $minutes
}

function _random() {
    readlink -f $(find "$DIR" -type f | xargs file --mime-type 0 | grep -E ':\s+image/' | cut -d':' -f1 | shuf -n1)
}

killall swaybg >/dev/null 2>/dev/null
if test -f ~/.wallpaper ; then
    swaybg --image ~/.wallpaper
if [ -d "$DIR/25th_hour" ] ; then
    swaybg --image "$(_25th_hour)"
else
    swaybg --image "$(_random)"
fi

# EOF
