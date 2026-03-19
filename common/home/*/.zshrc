#!/usr/bin/env zsh
# ~/.zshrc

[[ -o interactive ]] || return 0

Z_CHPWD=true
Z_COLORS=true
Z_EXEC_TIME=true
Z_HIGHLIGHT=false
Z_NOTIFY=false
Z_NOTIFY_IGNORE+=($EDITOR)
Z_NOTIFY_SUCCESS=false
Z_NOTIFY_THRESHOLD=1 # s
Z_PROMPT_NEWLINE=true
Z_TITLE=true

if [[ -r "$HOME/.shrc" ]] ; then
    source "$HOME/.shrc"
elif [[ -r "/usr/local/etc/sh/rc" ]] ; then
    source "/usr/local/etc/sh/rc"
fi

if [[ -r "$HOME/.config/zsh/rc" ]] ; then
    source "$HOME/.config/zsh/rc"
elif [[ -r "/usr/local/etc/zsh/rc" ]] ; then
    source "/usr/local/etc/zsh/rc"
fi

true # $?

# EOF
