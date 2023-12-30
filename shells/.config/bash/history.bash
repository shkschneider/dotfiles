export HISTFILE=${BASHCONFDIR:-$HOME/.config/bash}/.history
export HISTCONTROL=ignoreboth #ignoredups,ignorespace
export HISTIGNORE="&;cd:ls:pwd:exit:clear"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '

history | sed -r 's;^[^a-z]+;;g' | fzf -0 -1 | bash
