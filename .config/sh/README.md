shrc
====

- ...

Install
-------

~/.profile:

> source $HOME/.config/sh/shrc

Loading
-------

+--------------------------+---+---+---+
|                          | l | i | * |
+--------------------------+---+---+---+
| ~/.profile               | * | * |   |
| ~/.config/sh/shrc        | * | * |   |
|   ~/.config/sh/*.sh      | * | * |   |
| $ENV                     |   |   | * |
+--------------------------+---+---+---+

* 1/2/3: first one found only
* 4: not automatic in login
