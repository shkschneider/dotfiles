# /etc/profile.d/paths.sh ~/.config/profile.d/paths.sh

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.local/sbin" ]] && export PATH="$HOME/.local/sbin:$PATH"
command -v go >/dev/null && [[ -n "$GOPATH" ]] && export PATH="$GOPATH/bin:$PATH"
