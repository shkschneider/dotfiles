# exit.zsh

function _exit() {
  rm -f /tmp/zsh_prompt_* 2>/dev/null >&2
}

autoload -Uz add-zsh-hook
add-zsh-hook zshexit _exit

# EOF
