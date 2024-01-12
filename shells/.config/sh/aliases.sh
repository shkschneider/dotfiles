# ~/.config/sh/aliases.sh

alias dot="git -C ~/.dot"

if [[ ! $OSTYPE == darwin* ]] || command -v gcp >/dev/null ; then
    alias cp="cp --recursive --verbose"
    alias mv="mv --verbose"
    alias rm="rm --verbose"
    alias mkdir="mkdir --parents --verbose"
fi

alias bc="bc --quiet"
alias curl="curl --silent"
alias emacs="emacs -nw"
alias f="fzf"
alias h="history"
alias htop="$(command -v btm || command -v gotop || command -v btop || which top)"
alias j="jobs"
alias lite="$(command -v lite-xl || command -v lite)"
alias md="glow --pager"
alias micro="MICRO_TRUECOLOR=1 micro"
alias nano="nano -_"
alias scp="scp -r"
alias tmux="tmux -u new -As0"
alias top="$(command -v procs || which top)"
alias t="tree -dx -ACF --noreport"
alias vim="vim -y"
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

#:grep

#alias g="$(command -v rg || command -v grep)"
if command -v rg >/dev/null ; then
    alias rgrep="rg -IoN"
    alias g="rg"
elif command -v ugrep >/dev/null ; then
    #alias ugrep="ugrep --sort=rchanged --files-with-matches --binary-files=without-match"
    #alias qgrep="ugrep -Q" # query
    #alias scripts="ugrep --file-magic="#!" """
    alias g="ugrep"
else
    alias g="grep"
fi

#:find

if command -v fd >/dev/null ; then
    alias fp="fd | fzf | xargs readlink -f"
else
    alias fp="find | fzf | xargs readlink -f"
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

for ls in $(command -v eza) $(command -v exa) $(command -v ls) ; do
    l="-l"
    for opt in '-C' '--grid' '--classify' '--group-directories-first' '--human-readable' '--group' '--modified' '--no-permissions' '--octal-permissions' ; do
        $ls --help 2>&1 | grep -c -- "$opt" >/dev/null && \
            l="$l $opt"
    done
    alias l="$ls $l"
    ll="-l"
    for opt in '--long' '--classify' '--group-directories-first' '--human-readable' '--modified' ; do
        $ls --help 2>&1 | grep -c -- "$opt" >/dev/null && \
            ll="$ll $opt"
    done
    alias ll="$ls $ll"
    la="-l"
    for opt in '--almost-all' ; do
        $ls --help 2>&1 | grep -c -- "$opt" >/dev/null && \
            la="$la $opt"
    done
    alias la="ll $la"
    break
done

# EOF
