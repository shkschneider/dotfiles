# ~/.profile

source "${SHCONFDIR:-$HOME/.config/sh}/shrc"

[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"

# EOF
