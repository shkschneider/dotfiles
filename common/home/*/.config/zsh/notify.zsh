#!/usr/bin/env zsh
# ~/.config/zsh/notify.zsh
# ! before timer

Z_NOTIFY=${Z_NOTIFY:-true}
[[ "${Z_NOTIFY:-}" == true ]] || return

Z_NOTIFY_THRESHOLD=${Z_NOTIFY_THRESHOLD:-60} # s
Z_NOTIFY_IGNORE=(${Z_NOTIFY_IGNORE:-${EDITOR:-nano} sleep})
Z_NOTIFY_SUCCESS=${Z_NOTIFY_SUCCESS:-false}
typeset -U Z_NOTIFY_IGNORE

function _notify() {
    [[ "${Z_NOTIFY_SUCCESS:-}" == false && $? -eq 0 ]] && return
    [ -n "$TIMER" ] || return
    [[ $TIMER =~ ^[0-9]+(\.[0-9]+)?$ ]] || return
    local argv="$(fc -ln -1)"
    local cmd="${argv%% *}"
    (( $Z_NOTIFY_IGNORE[(Ie)$cmd] )) && return
    local diff=$((EPOCHREALTIME - TIMER))
    [[ $diff -ge Z_NOTIFY_THRESHOLD ]] || return
    notify-send -u low "$cmd took ${diff%.*}s" 2>/dev/null
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _notify

# EOF
