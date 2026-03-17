# ~/.config/sh/paths.sh

test -d $HOME/.local/bin && export PATH="$HOME/.local/bin:$PATH"
test -d $HOME/.local/sbin && export PATH="$HOME/.local/sbin:$PATH"

command -v go >/dev/null && export GOPATH="${GOPATH:-$HOME/.go}"
command -v go >/dev/null && export PATH="$GOPATH/bin:$PATH"
command -v go >/dev/null && export GO111MODULE=auto

command -v cargo >/dev/null && export PATH="$HOME/.cargo/bin:$PATH"

# EOF
