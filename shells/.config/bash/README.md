bashrc
======

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
