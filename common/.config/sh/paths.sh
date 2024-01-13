# ~/.config/sh/paths.sh

test -d $HOME/.local/bin && export PATH="$HOME/.local/bin:$PATH"

command -v cargo >/dev/null && export PATH="$HOME/.cargo/bin:$PATH"
command -v go >/dev/null && GOPATH="${GOPATH:-$HOME/.go}"

# EOF
