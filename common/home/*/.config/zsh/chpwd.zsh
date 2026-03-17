# ~/.config/zsh/chpwd.zsh
# ! after aliases

Z_CHPWD=${Z_CHPWD:-true}
[[ "${Z_CHPWD:-}" == true ]] || return

autoload -U add-zsh-hook

function _chpwd() {
  l -C 2>/dev/null || ls -C 2>/dev/null
}

add-zsh-hook chpwd _chpwd

# EOF
