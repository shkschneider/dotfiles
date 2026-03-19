#!/usr/bin/env zsh
# /usr/local/etc/zsh/chpwd.zsh ~/.config/zsh/chpwd.zsh

Z_CHPWD=${Z_CHPWD:-true}
[[ "${Z_CHPWD:-}" == true ]] || return

autoload -Uz add-zsh-hook

function _chpwd() {
    ls -CF 2>/dev/null
}

add-zsh-hook chpwd _chpwd

# EOF
