# chpwd.zsh
# ! after aliases

Z_CHPWD=${Z_CHPWD:-true}

[[ "${Z_CHPWD:-}" == true ]] || return

autoload -U add-zsh-hook

function _chpwd() {
  [[ $Z_CHPWD -ne 0 ]] || return
  l 2>/dev/null || ls -C
}

add-zsh-hook chpwd _chpwd

# EOF
