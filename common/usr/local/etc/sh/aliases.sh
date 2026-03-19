#!/bin/sh
# /usr/local/etc/sh/aliases.sh ~/.config/sh/aliases.sh

if [ -d "$HOME/.dot" ] ; then
    # shellcheck disable=SC2139
    alias dot="git -C $HOME/.dot"
elif [ -d "/opt/dotfiles" ] ; then
    # shellcheck disable=SC2139
    alias dot='git -C /opt/dotfiles'
fi

alias cp='cp -rv' # recursive
alias mkdir='mkdir -pv' # parents
alias mv='mv -iv' # no-overwrite
alias rm='rm -v -I' # interactive once
alias rmdir='rmdir -v'

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

command -v bc    >/dev/null && alias bc='bc --quiet'
command -v curl  >/dev/null && alias curl='curl --silent'
command -v glow  >/dev/null && alias glow='PAGER= glow' && alias md='glow'
command -v lsblk >/dev/null && alias blk='lsblk --fs --paths --output name,type,fstype,mode,owner,group,size,mountpoints'
command -v scp   >/dev/null && alias scp='scp -r'
command -v tmux  >/dev/null && alias tmux='tmux -u new -As0'
command -v wget  >/dev/null && alias wget='wget --quiet'

alias j='jobs'
alias h='history'

# shellcheck disable=SC2139
alias c="$(command -v tuc || command -v hck || command -v cut)"
# shellcheck disable=SC2139
alias f="$(command -v fzf || command -v fzy)"
# shellcheck disable=SC2139
alias g="$(command -v rg || command -v ugrep || command -v grep)"
# shellcheck disable=SC2139
alias i="$(command -v viu || command -v chafa)"
# shellcheck disable=SC2139
alias p="$(command -v procs || which ps)"

command -v tree >/dev/null && alias t='tree -dx -ACF --noreport' || alias t="find * -type d -not -path '*/.*'"

# shellcheck disable=SC2139
alias fetch="$(command -v fastfetch || command -v neofetch || which neo 2>/dev/null)"

# EOF
