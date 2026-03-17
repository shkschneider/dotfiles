# ~/.config/zsh/options.zsh
# https://zsh.sourceforge.io/Doc/Release/Options.html

bindkey -e # emacs

unsetopt beep list_beep hist_beep # stfu
unsetopt flow_control # suspend
unsetopt no_match
setopt clobber # override with redirects
setopt ignore_eof ; bindkey -r '^D' # exit
unsetopt rm_star_silent
setopt case_glob case_match # case-sensitives
setopt glob_complete # expand globbing
setopt interactive_comments

#:path

typeset -U path # no duplicates

setopt hash_executables_only

#EOF
