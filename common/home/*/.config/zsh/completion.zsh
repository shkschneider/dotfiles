#!/usr/bin/env zsh
# ~/.config/zsh/completion.zsh
# ! after colors

zource 'zsh-users/zsh-completions@0.34.0'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
zource 'zsh-users/zsh-autosuggestions@v0.6.4'

# EOF
