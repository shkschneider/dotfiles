# ~/.config/bash/prompt.bash

export PS1='\h:\W \u\$ '

function __ps1() {
  c="$(tput bold)"
  [ $(id -u) -eq 0 ] && c="$c$(tput setaf 1)" || c="$c$(tput setaf 2)"

  user=$(whoami)
  host=$(hostname -s)
  [ -n "$SSH_CLIENT$SSH2_CLIENT" ] && host="ssh:"$host
  _user="$c[$user@$host]$(tput sgr0)"
  unset user host

  path=$(readlink -f "." | sed "s#$HOME#~#")
  _path="$(tput bold)$(tput setaf 4)[$path]$(tput sgr0)"
  unset path

  _prompt=""
  j=$(jobs | wc -l)
  [ $j -gt 0 ] && _prompt="$_prompt $(tput setaf 3)+$j$(tput sgr0)"
  [ $SHLVL -gt 1 ] && _prompt="$_prompt $SHLVL"
  _prompt="$_prompt\n"
  [ $(id -u) -eq 0 ] && _prompt="$_prompt""#" || _prompt="$_prompt""$"
  _prompt="$_prompt "
  unset j

  export PS1=$_user" "$_path""$_prompt
  unset c _user _path _prompt git_dir
}
PROMPT_COMMAND=__ps1

# EOF
