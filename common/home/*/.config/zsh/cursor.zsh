#!/usr/bin/env zsh
# ~/.config/zsh/cursor.zsh

bindkey '\e[3;5~' kill-word # ctrl-delete
bindkey '^H' backward-kill-word # ctrl-backspace
bindkey '^[[1;5C' forward-word # ctrl-right
bindkey '^[[1;5D' backward-word # ctrl-left
bindkey '^[y' copy-prev-shell-word # alt-y
bindkey '^[z' undo # alt-z
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey '^l' clear-screen
bindkey '^u' kill-whole-line
bindkey '^w' backward-kill-line

zmodload zsh/terminfo

bindkey "${terminfo[kdch1]}" delete-char # del
bindkey "${terminfo[khome]}" beginning-of-line # home
bindkey "${terminfo[kend]}" end-of-line # end

# EOF
