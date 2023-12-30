dotfiles
========

> This is my dotfiles. There are many like them, but those are mine.
> My dotfiles are my best friends. It is my life. I must master it as I must master my life.
> Without me, my dotfiles are useless. Without my dotfiles, I am useless.

```
 shk@cell
󰔛 up 42 day, 4 hour, 2 minutes
 linux
 arch/void
󰌧 systemd/runit
 wayland
 hyprland
 alacritty
 zsh/bash
```

Usage
-----

Symlinks-based, much like GNU Stow.
More advanced features done by scripts (dot.script).

```
$ git clone https://github.com/shkschneider/dotfiles.git ~/.dot
$ ./dot [--help] # please NOT as root
```

> Use at your own risk.

Hightlights
-----------

- Display Managers
  - autologin: sddm (if full disk encryption)
  - otherwise: ly
- Window Managers
  - wayland: hyprland + waybar + dunst/mako
  - x11: awesome / gnome-shell
- Terminals
  - alacritty
  - terminator
- Shells
  - bash + starship (no bash-it)
  - zsh + starship (no oh-my-zsh)
- Editors
  - intellij'idea / (space|e)macs
  - micro / nano
- File Managers
  - ranger
  - nemo
- Web Browsers
  - brave

Notable Scripts
---------------

- ./dot
- cli/.local/bin/*
  - barrel: loading spinners
  - casse: capitalizze, lower, upper, kebab, pascal, snake...
  - demon: one service manager (wrapper) to rule them all
  - neo: system information
  - pm: one package manager (wrapper) to rule them all
  - rc: config files for machine type, kernel, hostname, .local...
- root/install/
  post-installation text files (not scripts)

Dependencies
------------

> wget, git, unzip, tar, sassc, ...

Post-Scriptum
-------------

Putting aside evertythin that is a fork of a fork or to serve a niche,
there is pretty much only Arch and Debian; plus Void; and maybe Nix; and...

> The interface you see from a distro doesn't matter.
> What matters are the supported architectures, package manager and packages/updates.

- Started on Debian (stable)
- Used many, in particular: LinuxMint, Manjaro and Fedora
- Now running Arch and Void

Thanks
------

- Richard Stallman / FSF / GNU
- Linus Torvalds / Linux
- Ian Murdock / Debian
- Arch Linux / Wiki
- Void Linux
- DistroWatch
- Github
- and everybody that shares open source <3
