# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return 0

# Options
if [ -x "$(which stty)" ] ; then
    stty -ixon
    stty -ixoff
fi
umask 022
set -o noclobber
set -o emacs
#set -o ignoreeof
shopt -s autocd
shopt -s hostcomplete
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
shopt -s checkhash
if [ -n "$BASH_COMPLETION" ] ; then
    complete -cf sudo
    complete -cf man
fi
if [ -x "$(which xset)" ] ; then
    xset -dpms
    xset s off
fi

# Environment
export HISTCONTROL=ignoreboth #ignoredups,ignorespace
export HISTIGNORE="&;cd:ls:pwd:exit:clear"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
export MYSQL_HISTFILE=/dev/null
[ -x "$(which nano)" ] && export EDITOR=nano
export LESS='-R'
[ -x "$(which most)" ] && export PAGER=most || export PAGER=less
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
    c0="\e[m"
    c1="\e[1;32m"
    c2="\e[1;34m"
    c3="\e[1;33m"
    # ┌╭
    # ─
    # └╰
    jobs=$(jobs | wc -l)
    [ -z "$jobs" ] && jobs="0"
    user=$(whoami)
    [ -z "$user" ] && user="johndoe"
    host=$(hostname)
    [ -n "$SSH_CLIENT$SSH2_CLIENT" ] && host="ssh:$(hostname)"
    drive=$(df "$(readlink -f . 2>/dev/null)" | tail -1 | awk '{ print $1 }')
    [ -n "$(echo $drive | egrep '^/dev/disk/by-uuid/')" ] && drive=$(readlink -f "/dev/disk/by-uuid/$(ls -l $drive | awk '{print $NF}')")
    path=$(readlink -f "." | sed "s#$HOME#~#")

    PS1="[$jobs] $c1[$user@$host] $c2[$drive:$path]"
    # Git
    if [ -n "$(git rev-parse --git-dir 2>/dev/null)" ] ; then
        git_repo=$(basename "$(dirname "$(readlink -f "$(git rev-parse --git-dir)")")")
        git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "?")
        [ $(git status --porcelain 2>/dev/null | wc -l || echo "0") -gt 0 ] && git_branch="$git_branch*"
        git_status=$(git rev-list HEAD --not --remotes 2>/dev/null | wc -l || echo "0")
        PS1="[$jobs] $c1[$user@$host] $c2[$drive:$path] $c3[$git_repo:$git_branch +$git_status]"
    fi
    export PS1="$c0╭$PS1\n$c0╰\$ "
}
PROMPT_COMMAND=__ps1

# Custom
[ -f "$HOME/.mybashrc" ] && source "$HOME/.mybashrc"

# EOF
