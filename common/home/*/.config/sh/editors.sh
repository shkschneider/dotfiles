# ~/.config/sh/editors.sh

alias nano="nano -_"
alias emacs="emacs -nw"
alias micro="MICRO_TRUECOLOR=1 micro"
alias vim="vim -y"

alias e="$(command -v emacs || comman -v micro || command -v nano || echo 'vim -y')"
export EDITOR="$e"

# EOF
