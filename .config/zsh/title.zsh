# title.zsh

Z_TITLE=${Z_TITLE:-1}

[[ $Z_TITLE -ne 0 ]] || return

autoload -Uz add-zsh-hook

return # FIXME

zource 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/termsupport.zsh'
add-zsh-hook -d precmd omz_termsupport_precmd
add-zsh-hook -d preexec omz_termsupport_preexec

bin title || { zlog w 'title: missing termsupport' ; return }

function _title_preexec() {
  local -a argv=(${(z)1})
  title "${argv[1]}" "$argv"
}

function _title_precmd() {
  title "$SHELL" "$PWD"
}

add-zsh-hook preexec _title_preexec
add-zsh-hook precmd _title_precmd

return # TODO

function _title() {
  [[ $Z_TITLE -ne 0 ]] || return
  local s=$1
  s=${(V)s//\%/\%\%} # escapes
  s=${s//$'\n'/} # new lines
  if [[ -t 1 ]]; then
    print -n -- "\e]0;$s\a"
  elif [[ -w $TTY ]]; then
    print -n -- "\e]0;$s\a" >$TTY
  fi
}

function _title_preexec() {
  local -a argv=(${(z)1})
  _title "${argv[1]} ${PWD//$HOME/~}"
}

function _title_precmd() {
  _title "$SHELL ${PWD//$HOME/~}"
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _title_preexec
add-zsh-hook precmd _title_precmd

# EOF
