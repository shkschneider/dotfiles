# chpwd.zsh
# ! after aliases

Z_CHPWD=${Z_CHPWD:-1}

autoload -U add-zsh-hook

function _chpwd() {
  [[ $Z_CHPWD -ne 0 ]] || return
  l 2>/dev/null || ls -C
}

add-zsh-hook chpwd _chpwd

# EOF
