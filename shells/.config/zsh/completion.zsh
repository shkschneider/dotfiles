# completion.zsh
# ! after colors

zmodload zsh/complete
zmodload zsh/complist

setopt rec_exact # completes if correct even if more possibilities
setopt auto_param_slash # directories
setopt auto_menu ; unsetopt menu_complete # menu & auto-select-first-candidate
setopt complete_in_word ; setopt always_to_end
setopt list_types ; unsetopt list_ambiguous
unsetopt complete_aliases # https://stackoverflow.com/a/20643204
setopt glob_complete
unsetopt glob_dots # auto-include .*
unsetopt cdable_vars correct correct_all ; CORRECT_IGNORE="[_|.]*"
setopt always_last_prompt # completion below prompt

zource 'zsh-users/zsh-completions@0.34.0'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
zource 'zsh-users/zsh-autosuggestions@v0.6.4'

# https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
# https://thevaluable.dev/zsh-completion-guide-examples/
# https://stackoverflow.com/a/27643846
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZCONFDIR/.cache"
zstyle ':completion:*' rehash true
zstyle ':completion:*' squeeze-slashes true # // -> /
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' special-dirs false # . ..
zstyle ':completion:*' insert-tab pending # do not complete upon pasting tabs
zstyle ':completion:*' matcher-list '' # case-sensitive without partial mid-word completion
zstyle ':completion:*' completer _complete _files # _expand_alias _approximate _extensions _ignored
# :completion:<function>:<completer>:<command>:<argument>:<tag>
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '_*'
zstyle -e ':completion:*:complete:-command-:*:executables' ignored-patterns '[[ "$PREFIX" == ./* ]] && { reply=(./*(/)) }' # ./ ignores directories

zstyle ':completion:*' menu select # highlight
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%F{008}-- more --%f'
zstyle ':completion:*' select-prompt '%F{008}-- select --%f'
#zstyle ':completion:*:descriptions' format '%F{008}-- %d --%f'
zstyle ':completion:*:messages' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' remote-access no
zstyle ':completion:*:complete:ssh:*:*' ignored-patterns '_*'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# expand-or-complete-or-list-files
zstyle ':completion:*' insert-tab false
function expand-or-complete-or-list-files() {
  if [[ -z ${LBUFFER// } ]] ; then
    BUFFER="l "
    CURSOR=${#BUFFER}
    zle list-choices
    zle kill-buffer
  else
    zle expand-or-complete
  fi
}
zle -N expand-or-complete-or-list-files
bindkey '^I' expand-or-complete-or-list-files # tab

zmodload zsh/terminfo

bindkey "${terminfo[kcbt]}" reverse-menu-complete # shift-tab

autoload -Uz bashcompinit && bashcompinit

# EOF
