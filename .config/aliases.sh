# ~/.config/aliases.sh

type bin &>/dev/null || {
  bin() {
    type $@ &>/dev/null
  }
}

# TODO missing coreutils

[[ ! $OSTYPE == darwin* ]] || bin gls && {
  alias ls='ls --classify --human-readable --group-directories-first --color=auto'
  alias la='ls -A'
  alias lla='ls -lA'
} || {
  alias ls='ls -Fh --color'
  alias la='ls -a'
  alias lla='ls -la'
}
[[ ! $OSTYPE == darwin* ]] || bin gcp && alias cp='cp --recursive --verbose'
[[ ! $OSTYPE == darwin* ]] || bin gcp && alias mv='mv --verbose'
[[ ! $OSTYPE == darwin* ]] || bin gcp && alias rm='rm --verbose'
[[ ! $OSTYPE == darwin* ]] || bin gcp && alias mkdir='mkdir --parents --verbose'
alias l='ls -C'
alias ll='ls -l'
alias lld='ll -d */'
alias llt='tree -d'
alias nano='nano --unix'
alias scp='scp -r'
alias wget='wget --quiet'
alias curl='curl --silent'
alias bc='bc --quiet'
alias less='less -FX' # exit on EOF
alias more='more -e' # exit on EOF
alias nano='nano -z' # suspend
alias j='jobs'
alias h='history'
alias hh='history | grep -i'
case $OSTYPE in
  darwin*)
    alias afk='pmset displaysleepnow' # only works with Security&Privacy>General>RequirePassword=Immediately
    alias battery='pmset -g batt | grep -Eo "\d+%"'
    ;;
  freebsd*)
    alias battery='sysctl -n hw.acpi.battery.life'
    ;;
  linux*)
    # TODO acpi / acpitool
    ;;
esac

bin calc && alias calc="noglob calc"
bin ugrep && {
  alias ugrep='ugrep --sort=rchanged --files-with-matches --binary-files=without-match'
  alias qgrep='ugrep -Q' # query
  alias scripts="ugrep --file-magic='#!' ''"
}

# EOF
