bashrc
======

- ...

Install
-------

~/.bash_login:

> source $HOME/.bashrc

~/.bashrc:

> source ${BASHCONFDIR:-$HOME/.config/bash}/bashrc

Extend or customize anything in any ~/.bashrc.*

Loading
-------

+--------------------------+---+---+---+
|                          | l | i | * |
+--------------------------+---+---+---+
| /etc/bash.bashrc         |   | * |   |
| /etc/profile             | * |   |   |
| ~/.bash_profile          |(1)|   |   |
| ~/.bash_login            |(2)|   |   |
| ~/.profile               |(3)|   |   |
| ~/.bashrc                |(4)| * |   |
| $BASHCONFDIR/bashrc      | * | * |   |
|   $BASHCONFDIR/*.bash    | * | * |   |
|   ~/.bashrc.*            | * | * |   |
| $BASH_ENV                |   |   | * |
| ~/.bash_logout           | * | * | * |
+--------------------------+---+---+---+

> If you use .bash_profile or .bash_login, source bashrc from there!

* 1/2/3: first one found only
* 4: not automatic in login
