#!/bin/sh
# ~/.profile

if [[ -r "/usr/local/etc/profile" ]] ; then
    . "/usr/local/etc/profile"
fi

for rc in $(find "$HOME/.config/profile.d/" -name '*.sh' 2>/dev/null) ; do
    [ -r "$rc" ] && . "$rc"
    unset rc
done

true # $?

# EOF
