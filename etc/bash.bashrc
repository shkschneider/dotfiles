# @author shkschneider
# /etc/bash.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return 0

# Options
if [ -x "$(which stty)" ] ; then
    stty -ixon 2>/dev/null
    stty -ixoff 2>/dev/null
fi
if [ -x "$(which xset)" ] ; then
    xset -dpms 2>/dev/null
    xset s off 2>/dev/null
fi
#set -o noclobber
set -o emacs
#set -o ignoreeof
shopt -s autocd
shopt -s hostcomplete
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
shopt -s checkhash

# Environment
export HISTCONTROL=ignoreboth #ignoredups,ignorespace
export HISTIGNORE="&;cd:ls:pwd:exit:clear"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
export MYSQL_HISTFILE=/dev/null
[ -x "$(which nano)" ] && export EDITOR=nano
[ -x "$(which most)" ] && export PAGER=most || { export PAGER=less ; export LESS='--RAW-CONTROL-CHARS' ; }
[ -f "$HOME/.lessfilter" ] && export LESSOPEN='|~/.lessfilter %s'
export LSCOLORS="cxfxbxdxbxegedabagacad"

# Aliases
alias setenv=export
alias unsetenv=unset

# umask
umask 022

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && source /etc/bash_completion
if [ -n "$BASH_COMPLETION" ] ; then
    complete -cf sudo
    complete -cf man
fi

# Command not found
command_not_found_handle() { echo "bash: $1: command not found"; }

# Path
for path in bin sbin ; do
    [ -d "$HOME/$path" ] && export PATH="$PATH:$HOME/$path"
done

# Prompt
function __ps1() {
    c="$(tput bold)"
    [ $(id -u) -eq 0 ] && c="$c$(tput setaf 1)" || c="$c$(tput setaf 2)"

    user=$(whoami)
    host=$(hostname)
    [ -n "$SSH_CLIENT$SSH2_CLIENT" ] && host="ssh:"$host
    _user="$c⁅$user@$host⁆$(tput sgr0)"
    unset user host

    path=$(readlink -f "." | sed "s#$HOME#~#")
    _path="$(tput bold)$(tput setaf 4)⁅$path⁆$(tput sgr0)"
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

# Custom
[ -f "$HOME/.mybashrc" ] && [ -r "$HOME/.mybashrc" ] && source "$HOME/.mybashrc"

# EOF
