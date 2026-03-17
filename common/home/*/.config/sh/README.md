shrc
====

Central point of all shells: sh, bash, zsh...

_NOT_ sourced automatically, as this would be dangerous.

Customize _extreme_ caution!

> for rc in $HOME/.config/sh/*.sh ; do
>   source $rc
> done

Loading
-------

+--------------------------+---+---+---+
|                          | l | i | * |
+--------------------------+---+---+---+
| ~/.profile               | * | * |   |
| ~/.profile.local         | * | * |   |
| $ENV                     |   |   | * |
+--------------------------+---+---+---+
