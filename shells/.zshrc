# ~/.zshrc

Z_CHPWD=true
Z_COLORS=true
Z_HIGHLIGHT=false
Z_NOTIFY=true
Z_NOTIFY_THRESHOLD=1 # s
Z_NOTIFY_IGNORE+=($EDITOR)
Z_NOTIFY_SUCCESS=false
Z_TITLE=true

source "$HOME/.config/zsh/zshrc"

for rc in $(find $HOME -name '.zshrc.*') ; do
    source $rc
done

# EOF
