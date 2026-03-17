#!/usr/bin/env sh
# ~/.config/sh/paths.sh

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/sbin" ] && PATH="$HOME/.local/sbin:$PATH"

command -v go >/dev/null && GOPATH="${GOPATH:-$HOME/.go}"
command -v go >/dev/null && PATH="$GOPATH/bin:$PATH"
#command -v go >/dev/null && GO111MODULE=auto

command -v cargo >/dev/null && PATH="$HOME/.cargo/bin:$PATH"

export PATH

# EOF
