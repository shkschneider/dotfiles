#!/usr/bin/env sh
# ~/.config/sh/editors.sh

alias nano="nano -_"
alias emacs="emacs -nw"
alias micro="MICRO_TRUECOLOR=1 micro"
alias vim="vim -y"

VISUAL="${VISUAL:-$(command -v emacs || comman -v micro || echo 'vim -y')}"
export VISUAL
EDITOR="${EDITOR:-$(command -v micro || command -v nano || echo 'vi')}"
export EDITOR

# VISUAL > EDITOR
# shellcheck disable=SC2139
alias e="${VISUAL:-$EDITOR}"

# EOF
