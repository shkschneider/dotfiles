# ~/.config/sh/aliases.sh

alias dot="git -C ~/.dot"

if [[ ! $OSTYPE == darwin* ]] || command -v gcp >/dev/null ; then
    alias cp="cp --recursive --verbose"
    alias mv="mv --verbose"
    alias rm="rm --verbose --interactive=once"
    alias mkdir="mkdir --parents --verbose"
fi

# u() {
#     export MICRO_TRUECOLOR=1
#     if test -d "$1" ; then
#         fd --relative-path --hidden --follow --one-file-system --type file --base-directory "${1:-.}" \
#             | fzf \
#             | xargs micro
#     else
#         micro $@
#     fi
# }

alias bc="bc --quiet"
alias bench="hyperfine -i"
alias blk="lsblk --fs --paths --output name,type,fstype,mode,owner,group,size,mountpoints"
alias curl="curl --silent"
alias cut="$(command -v tuc || command -v hck || command -v cut)"
alias emacs="emacs -nw"
alias f="$(command -v fzf || command -v fzy)"
alias fetch="$(command -v fastfetch || command -v neofetch)"
alias h="history"
alias htop="$(command -v btm || command -v gotop || command -v btop || which top)"
alias img="viu"
alias j="jobs"
alias lite="$(command -v lite-xl || command -v lite)"
alias md="glow --pager"
alias micro="MICRO_TRUECOLOR=1 micro"
alias mkdir="mkdir --parents"
alias nano="nano -_"
alias scp="scp -r"
alias tmux="tmux -u new -As0"
alias top="$(command -v procs || which top)"
alias t="tree -dx -ACF --noreport"
#alias vim="vim -y"
alias wget="wget --quiet"

case $OSTYPE in
    darwin*)
        alias afk="pmset displaysleepnow" # only works with Security&Privacy>General>RequirePassword=Immediately
        alias battery="pmset -g batt | grep -Eo "\d+%""
        ;;
    freebsd*)
        alias battery="sysctl -n hw.acpi.battery.life"
        ;;
    linux*)
        alias battery="acpi --battery"
        ;;
esac

#:packagemanager

alias pkg=$(command -v upt || echo "$HOME/.local/bin/pm")

#:grep

alias g="$(command -v rg || command -v ugrep || command -v grep)"

#:find

if command -v fzf >/dev/null ; then
    if command -v fd >/dev/null ; then
        alias fp="fd | fzf | xargs readlink -f"
    else
        alias fp="find | fzf | xargs readlink -f"
    fi
fi

#:ls

if command -v dircolors >/dev/null ; then
    for f in $HOME/.dir_colors $HOME/.config/dircolors /etc/dircolors ; do
        if test -f "$f" ; then
            eval "$(dircolors $f)"
            break
        fi
    done
fi

if command -v eza >/dev/null || command -v exa >/dev/null ; then
    l="$(command -v eza || command -v exa)"
    alias l="$l --grid --classify --group-directories-first"
    alias ll="$l --long --classify --group-directories-first --time-style=+%F --smart-group --modified --no-permissions --octal-permissions" #--icons
    alias la="l --almost-all"
    alias lla="ll --almost-all"
elif command -v lsd >/dev/null ; then
    alias l="lsd --classify --group-directories-first --human-readable --date=+%F --permission=octal"
    alias ll="l --long"
    alias la="l --almost-all"
    alias lla="ll --almost-all"
else
    alias l="ls -C --classify --group-directories-first"
    alias ll="l -l --human-readable"
    alias la="l --almost-all"
    alias lla="ll --almost-all"
fi

# EOF
