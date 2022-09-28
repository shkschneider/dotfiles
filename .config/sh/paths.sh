# ~/.config/paths.sh

echo paths

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/sbin" ] && export PATH="$HOME/.local/sbin:$PATH"

export PATH

# EOF
