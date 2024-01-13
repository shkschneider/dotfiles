#!/usr/bin/env bash

if command -v dex >/dev/null ; then
    for file in /etc/xdg/autostart/*.desktop ; do
        dex $file
    done
    for file in $HOME/.config/autostart/*.desktop ; do
        dex $file
    done
    for file in $HOME/.config/autostart/*.sh ; do
        if [ ! -x $file ] ; then
            notify-send -u critical "Autostart script not executable!" "$file"
        else
            pkill -9 $(basename ${file%.sh}) 2>/dev/null
            sh $file &
        fi
    done
    exit 0
else
    notify-send -u critical "DEX not found: cannot autostart!" "$HOME/.config/autostart"
    exit 1
fi
