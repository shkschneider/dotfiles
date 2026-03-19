#!/bin/sh
# /usr/local/etc/sh/path.sh ~/.config/sh/path.sh

[ -d "/usr/local/sbin" ] && PATH="/usr/local/sbin:$PATH"
[ -d "/usr/local/bin"  ] && PATH="/usr/local/bin:$PATH"

[ -d "$HOME/.local/sbin" ] && PATH="$HOME/.local/sbin:$PATH"
[ -d "$HOME/.local/bin"  ] && PATH="$HOME/.local/bin:$PATH"

if command -v go >/dev/null ; then
    GOPATH="${GOPATH:-$HOME/.go}"
    export GOPATH
    PATH="$GOPATH/bin:$PATH"
fi

command -v cargo >/dev/null && PATH="$HOME/.cargo/bin:$PATH"

export PATH

# EOF
