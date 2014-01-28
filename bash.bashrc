# /etc/bash.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Options
shopt -s autocd
shopt -s hostcomplete
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
shopt -s checkhash

# Environment
export HISTCONTROL=ignoredups
export MYSQL_HISTFILE=/dev/null
export EDITOR=nano
export LESS='-R'
[ -x "$(which most)" ] && export PAGER=most
[ -f "$HOME/.lessfilter" ] && export LESSOPEN='|~/.lessfilter %s'
export LSCOLORS="cxfxbxdxbxegedabagacad"

# Aliases
alias setenv=export
alias unsetenv=unset

# umask
umask 022

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && source /etc/bash_completion

# Command not found
command_not_found_handle() { echo "bash: $1: command not found"; }

# Path
for path in bin sbin ; do
    [ -d "$HOME/$path" ] && export PATH="$PATH:~/$path"
done

# Prompt
function __ps1() {
    c0="\e[0m"
    c1="\e[1;32m"
    [ $(id -u) -eq 0 ] && c1="\e[1;31m"
    c2="\e[1;34m"
    c3="\e[1;33m"
    user=$(whoami)
    [ -z "$user" ] && user="johndoe"
    host=$(hostname)
    [ -n "$SSH_CLIENT$SSH2_CLIENT" ] && host="ssh:$(hostname)"
    drive=$(df "$(readlink -f . 2>/dev/null)" | tail -1 | awk '{ print $1 }')
    [ -n "$(echo $drive | egrep '^/dev/disk/by-uuid/')" ] && drive=$(readlink -f "/dev/disk/by-uuid/$(ls -l $drive | awk '{print $NF}')")
    path=$(readlink -f "." | sed "s#$HOME#~#")
    #date=$(date +%G%m%d%H%M%S)

    # always surrounds non-printing sequences with \[...\]
    export PS1="\[$c1\][$user@$host] \[$c2\][$drive:$path]\n\[$c0\]\\$ "
}
PROMPT_COMMAND=__ps1

# Custom
[ -f "$HOME/.mybashrc" ] && source "$HOME/.mybashrc"

# EOF
