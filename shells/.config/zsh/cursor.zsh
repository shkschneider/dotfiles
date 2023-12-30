# cursor.zsh

case $OSTYPE in
  darwin*)
    bindkey '^[[1;2D' backward-word # shift-left
    bindkey '^[[1;2C' forward-word # shift-right
    bindkey '^[OH' backward-kill-word # ctrl-left
    bindkey '^[OF' kill-word # ctrl-right
    bindkey 'Ω' undo # alt-z
    bindkey '¥' copy-prev-shell-word # alt-y
    ;;
  *)
    # TODO linux
    bindkey '^[[1;5D' backward-word # ctrl-left
    bindkey '^[[1;5C' forward-word # ctrl-right
    bindkey '^H' backward-kill-word # ctrl-backspace
    bindkey '\e[3;5~' kill-word # ctrl-delete
    bindkey '^[z' undo # alt-z
    bindkey '^[y' copy-prev-shell-word # alt-y
    ;;
esac
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey '^w' backward-kill-line
bindkey '^u' kill-whole-line
bindkey '^l' clear-screen

zmodload zsh/terminfo

bindkey "${terminfo[kdch1]}" delete-char # del
# TODO bindkey "${terminfo[kpp]}" beginning-of-buffer-or-history # page-up
# TODO bindkey "${terminfo[knp]}" end-of-buffer-or-history # page-down
bindkey "${terminfo[khome]}" beginning-of-line # home
bindkey "${terminfo[kend]}" end-of-line # end

# EOF
