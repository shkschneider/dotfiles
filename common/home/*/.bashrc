# ~/.bashrc

source "$HOME/.config/bash/rc"

for rc in $(find "$HOME" -maxdepth 1 -name '.bashrc.*' 2>/dev/null) ; do
    source "$rc"
done

# EOF
