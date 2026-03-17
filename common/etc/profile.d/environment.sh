# /etc/profile.d/environment.sh ~/.config/profile.d/environment.sh

export TERM=xterm-256color #xterm-color xterm linux

# LANGUAGE > LC_ALL > LANG
export LC_ALL=C.UTF-8

# VISUAL > EDITOR
export VISUAL=EDITOR=$(command -v emacs || command -v micro || command -v nano || echo 'vim -y')

export PAGER='less -R'
export MANPAGER=$PAGER
command -v git >/dev/null && export GIT_PAGER=$PAGER
