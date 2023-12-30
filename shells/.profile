#!/usr/bin/env sh

#:user

for user in $(echo $USER) $(id --user --name) $(echo $LOGNAME) ; do
    export USER="$user"
    export LOGNAME="$user"
    break
done

#:host

for host in $(cat /proc/sys/kernel/hostname 2>/dev/null) $(echo $HOSTNAME) $(hostnamectl hostname 2>/dev/null) $(uname --nodename) ; do
    export HOST="$host"
    break
done

#:editor

for editor in $(command -v micro) $(command -v nano) ; do
    export EDITOR="$editor"
    break
done
alias e="$EDITOR"

#:pager

for pager in $(command -v most) $(command -v less) $(command -v more) $(command -v pg) ; do
    export PAGER="$pager"
    for opt in 'QUIT-AT-EOF' 'exit-on-eof' ; do
        test "$($pager --help 2>&1 | grep -c -- "--$opt")" != "0" && \
            export PAGER="$PAGER --$opt"
    done
    break
done
alias p="$PAGER"

#:ls

if command -v dircolors >/dev/null ; then
    for f in $HOME/.dir_colors $HOME/.config/dircolors /etc/dircolors ; do
        if test -f "$f" ; then
            eval "$(dircolors $f)" && break
        fi
    done
fi

for ls in $(command -v exa) $(command -v ls) ; do
    ll="-l"
    for opt in 'classify' 'group-directories-first' 'human-readable' 'group' 'modified' ; do
        test "$($ls --help 2>&1 | grep -c -- "--$opt")" != "0" && \
            ll="$ll --$opt"
    done
    alias ll="$ls $ll"
    la="-l"
    for opt in 'almost-all' 'all' ; do
        test "$($ls --help 2>&1 | grep -c -- "--$opt")" != "0" && \
            la="$la --$opt"
    done
    alias la="ll $la"
    break
done

# EOF
