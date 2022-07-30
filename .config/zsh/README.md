zshrc
=====

A simple pure ZSH setup using no framework, powerful custom functions and very few plugins:
- zource (source plugins, files, dirs...)
- zarp (warp to bookmarked directories)
- custom (async) prompt (with VCS)
- completion
- history
- colors
- ...

It is strictly case-sensitive.

Install
-------

~/.zshenv.local:

> path+=$(...)

~/.zshrc:

> source ${ZCONFDIR:-$HOME/.config/zsh}/zshrc

Extend or customize anything in any ~/.zshrc.*

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
|   $ZDOTDIR/.zshenv.local | * | * |   |
|   $ZCONFDIR/*.zsh        | * | * |   |
|     $ZCONFDIR/src/*      | * | * |   |
|   $ZDOTDIR/.zshrc.*      | * | * |   |
| $ZDOTDIR/.zlogin         | * |   |   |
| $ZDOTDIR/.zlogout        | * |   |   |
+--------------------------+---+---+---+
