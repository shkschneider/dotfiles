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
[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

# Command not found
command_not_found_handle() { echo "bash: $1: command not found"; }

# Path
for path in bin sbin ; do
    [ -d "$HOME/$path" ] && export PATH="$PATH:~/$path"
done

# Prompt
function __ps1() {
    code=$(printf "%03d" $?)
    jobs=$(printf "%03d" $(jobs | wc -l))
    host=$(hostname)
    #date=$(date +%X)
    user=$(whoami)
    drive=$(df $(readlink -f .) | tail -1 | awk '{ print $1 }')
    if [ -n "$(echo $drive | egrep '^/dev/disk/by-uuid/')" ] ; then
        drive=$(readlink -f /dev/disk/by-uuid/$(ls -l $drive | awk '{print $NF}'))
    fi
    path=$(readlink -f $PWD)

    if [ -n "$(git rev-parse --git-dir 2>/dev/null)" ] ; then
        user=$(git config --get user.name || whoami)
        repo=$(dirname $(dirname $(readlink -f $(git rev-parse --git-dir))))
        path=$(readlink -f . | sed -r "s#^$repo/##")
        branch=$(git rev-parse --abbrev-ref HEAD)
        ref=$(git rev-parse HEAD | cut -c1-7)
        diff=$(git rev-list HEAD --not --remotes | wc -l)
        status=$(git status --porcelain | grep '?' | wc -l)
        export PS1="\e[1;34m[$jobs $path:$branch/$ref+$diff|$status]\n\e[1;32m[$code $user] \$\e[0m "
    # others
    # ...
    else
        export PS1="\e[1;34m[$jobs $drive:$path]\n\e[1;32m[$code $user@$host] \$\e[0m "
    fi
}
PROMPT_COMMAND=__ps1

# Custom
[ -f "$HOME/.mybashrc" ] && source "$HOME/.mybashrc"

# EOF
