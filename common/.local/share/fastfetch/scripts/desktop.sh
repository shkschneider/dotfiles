#!/usr/bin/env bash

if test -d /var/run/systemd/sessions ; then
    system=$(grep -h ^TYPE /var/run/systemd/sessions/* 2>/dev/null | head -1 | cut -d'=' -f2-)
    session=$(grep -h ^SERVICE /var/run/systemd/sessions/* 2>/dev/null | head -1 | cut -d'=' -f2-)
    desktop=""
else
    system="$XDG_SESSION_TYPE"
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
    desktop=""
fi
desktop="${desktop:-$XDG_CURRENT_DESKTOP}"

echo "${session:-?} > ${desktop:-?} (${system:-?})"

# EOF
