# history.zsh

HISTFILE="$ZCONFDIR/.history"

# fc -l 1 | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " a }' | grep -v "./" | sort -nr | head -n 20

setopt extended_history # timestamp
setopt append_history inc_append_history # incremental not at exit
setopt hist_find_no_dups hist_ignore_dups hist_ignore_space hist_reduce_blanks ; unsetopt hist_save_no_dups # clean
unsetopt share_history

zmodload zsh/terminfo

autoload -Uz history-search-end && {
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  bindkey '^[[A' history-beginning-search-backward-end # up
  bindkey '^[[B' history-beginning-search-forward-end # down
} || {
  bindkey '^[[A' history-beginning-search-backward # up
  bindkey '^[[B' history-beginning-search-forward # down
}

bindkey -r '^R' # history-incremental-search-backward

# EOF
