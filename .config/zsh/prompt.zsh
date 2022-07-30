# prompt.zsh

setopt prompt_subst # dynamic
unsetopt print_exit_value

autoload -Uz promptinit ; promptinit

function _pwd() {
  # https://unix.stackexchange.com/a/273567
  echo -n "%(5~|%-1~/…/%3~|%4~)"
}

TIMER=""
function _timer() {
  echo -n "%F{008}$TIMER%f"
}

function prompt() {
  local uh
  [[ $EUID -eq 0 ]] && uh="%F{red}%n%f" || uh="%F{green}%n%f"
  [ -n "$SSH_TTY" ] && uh="$uh%F{blue}@%m%f"
  local d="%F{cyan}$(_pwd)%f"
  # › 0x203a
  # ❯ 0x276f
  local c="%(?.›.%B%F{red}!%f%b)" # %(!.#.$)
  echo "$uh $d $1\n$c"
}

function rprompt() {
  local j=$(jobs | wc -l | tr -d '[:space:]')
  [[ $j -eq 0 ]] && j="%F{008}[$j]%f" || j="%F{magenta}[$j]%f"
  echo -n "$1 $j $(_timer)"
}

PROMPT=$'$(prompt) '
export SHELL=$(ps -o command -h $$ | sed '1d' | cut -d' ' -f1 | xargs basename)
RPROMPT=$'$(rprompt "%F{008}${SHELL:t}(%L)%f") '

autoload -Uz vcs_info
zource 'yonchu/zsh-vcs-prompt@1.1' 'lib/vcsstatus.sh'

autoload add-zsh-hook
# async: https://www.anishathalye.com/2015/02/07/an-asynchronous-shell-prompt/
_PROMPT_ASYNC=0 # pid
_PROMPT_TMP=/tmp/zsh_prompt_$$
function _vcs_info() {
  function _vcs_info_async() {
    if [ -n "$(git rev-parse --show-toplevel 2>/dev/null)" ] ; then
    local -a x=($(_zsh_vcs_prompt_vcs_detail_info 2>/dev/null))
    [[ $? -eq 0 ]] || return $?
    local sys="${x[1]}" #; [ "$sys" = "git" ] && sys="±"
    local branch="${x[3]}@$(_git_head)"
    local diff="${x[5]}↓↑${x[4]}"
    local conflicts="${x[7]}!"
    local action="<${x[2]}>"
    local g="$sys:$branch"
    [ "$diff" != "-0+0" ] && g="$g $diff"
    [ "$conflicts" != "0!" ] && g="$g $conflicts"
    g="$g $(_git_status)"
    [ "$action" != "<0>" ] && g="$g $action"
    echo -n "$(prompt "%F{yellow}$g%f")" > "$_PROMPT_TMP"
    else
    echo -n "$(prompt "%F{yellow}$g%f")" > "$_PROMPT_TMP"
    fi
    kill -s USR1 $$ 2>/dev/null
  }
  [[ "$_PROMPT_ASYNC" != 0 ]] && kill -s HUP $_PROMPT_ASYNC >/dev/null 2>&1 || :
  _vcs_info_async &!
  _PROMPT_ASYNC=$!
}
add-zsh-hook precmd _vcs_info
function TRAPUSR1() {
  PROMPT="$(cat $_PROMPT_TMP)%f "
  _PROMPT_ASYNC=0
  zle && zle reset-prompt
}

# EOF
