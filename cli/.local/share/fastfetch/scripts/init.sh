#!/usr/bin/env bash

init=""
session=""

init="$(cat /proc/1/comm)"

if test -d /var/run/systemd/sessions ; then
    session=$(grep -h ^SERVICE /var/run/systemd/sessions/* 2>/dev/null | head -1 | cut -d'=' -f2-)
else
    # https://wiki.archlinux.org/title/Display_desktop
    for s in cmd emptty entrance gdm greetd lemurs lightdm loginx lxdm ly sddm slim tbsm tdm xdm xfwm ; do
        if ps -C $s >/dev/null ; then
            session="$s"
            break
        fi
    done
    if test -z "$session" && ps -C sshd >/dev/null ; then
        session="sshd"
    fi
fi

echo "$init > ${session:-$(tty)}"

# EOF
