# ~/.config/sh/aliases.sh

[ -d "$HOME/.dot" ] && alias dot="git -C $HOME/.dot"
[ -d "/opt/dotfiles" ] && alias dot="git -C /opt/dotfiles"

# safety first

alias cp="cp --recursive --verbose"
alias mv="mv --verbose"
alias rm="rm --verbose --interactive=once"
alias mkdir="mkdir --parents --verbose"
#command -v trash >/dev/null && rm="trash"

if command -v eza >/dev/null ; then
    alias l="eza --grid --classify --group-directories-first --time-style=iso"
    alias ll="l --long"
elif command -v lsd >/dev/null ; then
    alias l="lsd --classify --group-directories-first --human-readable--date=+%F --permission=octal"
    alias ll="l --long"
else
    alias l="ls -C --classify --group-directories-first --human-readable"
    alias ll="l -l"
fi
alias la="l --almost-all"
alias lla="ll --almost-all"

alias bc="bc --quiet"
alias bench="hyperfine -i"
alias blk="lsblk --fs --paths --output name,type,fstype,mode,owner,group,size,mountpoints"
alias calc="bc --quiet"
alias curl="curl --silent"
alias f="$(command -v fzf || command -v fzy)"
alias fetch="$(command -v fastfetch || command -v neofetch || which neo 2>/dev/null)"
alias h="history"
alias img="$(command -v viu || command -v chafa)"
alias j="jobs"
alias md="glow --pager"
alias mkdir="mkdir --parents"
alias scp="scp -r"
alias tmux="tmux -u new -As0"
alias t="tree -dx -ACF --noreport"
alias wget="wget --quiet"

# potentially harmfull aliases

alias cc="$(command -v tuc || command -v hck || command -v cut)"
alias gg="$(command -v rg || command -v ugrep || command -v grep)"
alias pp="$(command -v procs || which ps)"
alias tt="$(command -v btm || command -v gotop || command -v btop || which top)"

# EOF
