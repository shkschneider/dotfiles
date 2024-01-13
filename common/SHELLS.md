Shells
======

sh
--

_NOT_ sourced automatically, as this would be dangerous

```
+------------------------------+---+---+---+
|                              | l | i | * |
+------------------------------+---+---+---+
| ~/.profile                   | * | * |   |
|   ~/.profile.{*,local}       | * | * |   |
| ~/.config/sh/shrc            | * | * |   |
|   ~/.config/sh/*.sh          | * | * |   |
| $ENV                         |   |   | * |
+------------------------------+---+---+---+
```

bash
----

```
+------------------------------+---+---+---+
|                              | l | i | * |
+------------------------------+---+---+---+
| /etc/bash.bashrc             |   | * |   |
| /etc/profile                 | * |   |   |
| ~/.bash_profile              | * |   |   |
| ~/.bash_login                |   |   |   |
| ~/.bashrc                    | * | * |   |
|   ~/.profile                 | * | * |   |
|   ~/.config/bash/bashrc      |   | * |   |
|     ~/.config/sh/shrc        |   | * |   |
|       ~/.config/sh/*.sh      |   | * |   |
|     ~/.config/bash/*.bash    |   | * |   |
|     ~/.bashrc.{*,local}      |   | * |   |
| $BASH_ENV                    |   |   | * |
| ~/.bash_logout               | * |   |   |
+------------------------------+---+---+---+
```

zsh
---

Pure setup without any framework:
- zource (source plugins from github, local files...)
- zarp (alias 'z') to bookmark directories
- zlog
- completion
- history
- colors

Configuration:
- Z_CHPWD
- Z_COLORS
- Z_HIGHLIGHT
- Z_NOTIFY
- Z_NOTIFY_THRESHOLD
- Z_NOTIFY_IGNORE
- Z_NOTIFY_SUCCESS
- Z_TITLE

```
+------------------------------+---+---+---+
|                              | l | i | * |
+------------------------------+---+---+---+
| /etc/zsh/zshenv              | * | * | * |
| ~/.zshenv                    | * | * | * |
|   ~/.zshenv.{*,local}        | * | * | * |
| /etc/zsh/zprofile            | * |   |   |
| ~/.zprofile                  | * |   |   |
| ~/.profile                   |   | * |   |
| /etc/zsh/zshrc               | * | * |   |
| ~/.zshrc                     | * | * |   |
|   ~/.config/zsh/zshrc        | * | * |   |
|     ~/.config/sh/shrc        | * | * |   |
|       ~/.config/sh/*.sh      | * | * |   |
|     ~/.config/zsh/zfunc.../* |   | * |   |
|     ~/.config/zsh/*.zsh      |   | * |   |
|   ~/.zshrc.{*,local}         | * | * |   |
| ~/.zlogin                    | * |   |   |
| ~/.zlogout                   | * |   |   |
+------------------------------+---+---+---+
```
