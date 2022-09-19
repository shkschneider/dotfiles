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
| ~/.bash_profile          |(*)|   |   |
| ~/.bash_login            |(*)|   |   |
| ~/.profile               |(*)|   |   |
| ~/.bashrc                | ? | * |   |
| $BASHCONFDIR/bashrc      | * | * |   |
|   $BASHCONFDIR/*.bash    | * | * |   |
|   ~/.bashrc.*            | * | * |   |
| $BASH_ENV                |   |   | * |
| ~/.bash_logout           | * | * | * |
+--------------------------+---+---+---+

> Bash will source the first of .bash_profile, .bash_login or .profile.
> Bash won't source .bashrc automatically upon login.
