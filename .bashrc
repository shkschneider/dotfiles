# ~/.bashrc

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
[ -f "$HOME/lessfilter" ] && export LESSOPEN='|~/.lessfilter %s'
export LSCOLORS="cxfxbxdxbxegedabagacad"

# Aliases
alias setenv=export
alias unsetenv=unset

# umask
umask 022

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

# Command not found
command_not_found_handle() { echo "bash: command not found: \`$1'"; }

# Path
for path in bin sbin ; do
    [ -d "$HOME/$path" ] && export PATH="$PATH:~/$path"
done

# Prompt
function __ps1() {
    EXIT=$?
    if [ $EXIT -eq 0 ] ; then
        EXIT="\e[1;32m$EXIT"
    elif [ $EXIT -eq 148 ] ; then
        EXIT="\e[1;33m$EXIT"
    else
        EXIT="\e[1;31m$EXIT"
    fi
    JOBS=$(jobs | wc -l)
    [ $JOBS -eq 0 ] && JCOLOR="\e[1;32m"
    [ $JOBS -eq 1 ] && JCOLOR="\e[1;33m"
    [ $JOBS -gt 1 ] && JCOLOR="\e[1;31m"
    if [ $(id -u) -eq 0 ] ; then
        COLOR="\e[1;31m"
    elif [ -z "$(pwd | egrep "^$HOME")" ] ; then
        COLOR="\e[1;33m"
    else
        COLOR="\e[1;32m"
    fi
    export PS1="$EXIT $COLOR\u@\h $JCOLOR$JOBS \e[1;34m\w \$\e[0m "
}
PROMPT_COMMAND=__ps1

# Custom
[ -f "$HOME/.mybashrc" ] && source "$HOME/.mybashrc"

# EOF
