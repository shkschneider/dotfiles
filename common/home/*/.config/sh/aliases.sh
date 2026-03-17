#!/usr/bin/env sh
# ~/.config/sh/aliases.sh

if [ -d "$HOME/.dot" ] ; then
    # shellcheck disable=SC2139
    alias dot="git -C $HOME/.dot"
elif [ -d "/opt/dotfiles" ] ; then
    # shellcheck disable=SC2139
    alias dot='git -C /opt/dotfiles'
fi

# safety first

alias cp='cp --recursive --verbose'
alias mv='mv --verbose'
alias rm='rm --verbose --interactive=once'
alias mkdir='mkdir --parents --verbose'
#command -v trash >/dev/null && rm="trash"

# list

if command -v eza >/dev/null ; then
    alias l='eza --classify --group-directories-first --time-style=iso' #--grid
    alias ll='eza --long --classify --group-directories-first --time-style=iso' #--grid
elif command -v lsd >/dev/null ; then
    alias l='lsd --classify --group-directories-first --human-readable--date=+%F --permission=octal'
    alias ll='l --long'
else
    alias l='ls -C --classify --group-directories-first --human-readable'
    alias ll='l -l'
fi
alias la='l --almost-all'
alias lla='ll --almost-all'

# others

alias bc='bc --quiet'
alias bench='hyperfine -i'
alias blk='lsblk --fs --paths --output name,type,fstype,mode,owner,group,size,mountpoints'
alias curl='curl --silent'
# shellcheck disable=SC2139
alias f="$(command -v fzf || command -v fzy)"
# shellcheck disable=SC2139
alias fetch="$(command -v fastfetch || command -v neofetch || which neo 2>/dev/null)"
alias h='history'
# shellcheck disable=SC2139
alias img="$(command -v viu || command -v chafa)"
alias j='jobs'
alias md='glow --pager'
alias mkdir='mkdir --parents'
alias scp='scp -r'
alias tmux='tmux -u new -As0'
alias t='tree -dx -ACF --noreport'
alias wget='wget --quiet'

# beware

# shellcheck disable=SC2139
alias cc="$(command -v tuc || command -v hck || command -v cut)"
# shellcheck disable=SC2139
alias gg="$(command -v rg || command -v ugrep || command -v grep)"
# shellcheck disable=SC2139
alias pp="$(command -v procs || which ps)"
# shellcheck disable=SC2139
alias tt="$(command -v btm || command -v gotop || command -v btop || which top)"

# EOF
