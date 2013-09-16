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
    #─
    #┌
    #└
    #╭
    #╰
    jobs=$(jobs | wc -l)
    host=$(hostname)
    user=$(whoami)
    drive=$(df $(readlink -f .) | tail -1 | awk '{ print $1 }')
    if [ -n "$(echo $drive | egrep '^/dev/disk/by-uuid/')" ] ; then
        drive=$(readlink -f /dev/disk/by-uuid/$(ls -l $drive | awk '{print $NF}'))
    fi
    path=$(readlink -f . | sed "s#$HOME#~#")
    if [ -n "$(git rev-parse --git-dir 2>/dev/null)" ] ; then
        git_repo=$(dirname $(dirname $(readlink -f $(git rev-parse --git-dir 2>/dev/null))))
        git_path=$(readlink -f . | sed -r "s#^$repo/##")
        git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        git_ref=$(git rev-parse HEAD 2>/dev/null | cut -c1-7)
        git_status="+$(git rev-list HEAD --not --remotes | wc -l)/$(git status --porcelain 2>/dev/null | egrep '^\s' | wc -l)"
        export PS1="╭[$jobs] \e[1;32m[$user@$host] \e[1;34m[$drive:$path] \e[1;33m[$git_path:$git_branch@$git_ref $git_status]\n\e[0;0m╰\$ "
    else
        export PS1="╭[$jobs] \e[1;32m[$user@$host] \e[1;34m[$drive:$path]\n\e[0;0m╰\$ "
    fi
}
PROMPT_COMMAND=__ps1

# Custom
[ -f "$HOME/.mybashrc" ] && source "$HOME/.mybashrc"

# EOF
