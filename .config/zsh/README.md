zshrc
=====

TODO [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return

A simple pure ZSH setup using no framework, powerful custom functions and very few plugins:
- zource (source plugins, files, dirs...)
- warp (to bookmarked directories)
- custom (async) prompt (with VCS)
- completion
- history
- colors
- ...

It is strictly case-sensitive.

Install
-------

(MacOS) ~/.zshenv.local:

> eval $(/opt/homebrew/bin/brew shellenv)
> PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

~/.zprofile:

> source $HOME/.profile

~/.profile:

> source ${SHCONFDIR:-$HOME/.config/sh/shrc}

~/.zshrc:

> source ${ZCONFDIR:-$HOME/.config/zsh}/zshrc

Extend or customize anything in any ~/.zshrc.*

Configuration
-------------

ZDOTDIR=$HOME
ZCONFDIR=$HOME/.config/zsh
Z_CHPWD
Z_COLORS
Z_HIGHLIGHT
Z_NOTIFY
Z_NOTIFY_THRESHOLD
Z_NOTIFY_IGNORE
Z_NOTIFY_SUCCESS
Z_TITLE

Loading
-------

+--------------------------+---+---+---+
|                          | l | i | * |
+--------------------------+---+---+---+
| /etc/zsh/zshenv          | * | * | * |
| $ZDOTDIR/.zshenv         | * | * | * |
| /etc/zsh/zprofile        | * |   |   |
| $ZDOTDIR/.zprofile       | * |   |   |
| /etc/zsh/zshrc           | * | * |   |
| $ZDOTDIR/.zshrc          | * | * |   |
| $ZCONFDIR/zshrc          | * | * |   |
|   $ZCONFDIR/zfunctions/* | * | * |   |
|   $ZCONFDIR/*.zsh        | * | * |   |
|     $ZCONFDIR/src/*      | * | * |   |
| $ZDOTDIR/.zlogin         | * |   |   |
| $ZDOTDIR/.zlogout        | * |   |   |
+--------------------------+---+---+---+
