#!/usr/bin/env zsh
# /usr/local/etc/zsh/options.zsh ~/.config/zsh/options.zsh

command -v emacs >/dev/null && bindkey -e # emacs

setopt   case_glob case_match # case-sensitives
setopt   check_jobs # upon exit
setopt   clobber # override with redirects
setopt   glob_complete # expand globbing
setopt   hup # upon exit
setopt   ignore_eof ; bindkey -r '^D' # exit
setopt   interactive_comments
setopt   monitor # jobs
setopt   no_notify
setopt   posix_jobs # not in subshells
unsetopt beep list_beep hist_beep # stfu
unsetopt flow_control # suspend
unsetopt no_match
unsetopt rm_star_silent

typeset -U path # no duplicates
setopt   hash_executables_only

#EOF
