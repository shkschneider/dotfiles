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

Symlinks-based, much like GNU Stow, but strictly via files, never directories.
More advanced features done by scripts (dot.script).

```
$ git clone https://github.com/shkschneider/dotfiles.git ~/.dot
$ ./dot [--help] # use at your own risk
```

Hightlights
-----------

- Display Managers
  - autologin: sddm (if full disk encryption)
  - otherwise: ly
- Window Managers
  - wayland: hyprland + waybar + dunst
  - x11: awesome / gnome-shell
- Terminals
  - alacritty
  - terminator
- Shells
  - zsh + starship (no oh-my-zsh)
  - bash + starship (no bash-it)
- Editors
  - intellij'idea / lite-xl
  - helix / micro / nano
- File Managers
  - lf
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

I haven't done an exhaustive list of dependencies, but you might want:

> wget, curl, make, git, unzip, tar, sassc, tree, bc...

Post-Scriptum
-------------

Putting aside evertything that is a fork of a fork or to serve a niche,
there is pretty much only Arch and Debian; plus Void; and maybe Nix; and...

> The interface you see from a distro doesn't matter.
> What matters are the supported architectures, package manager and packages/updates.

- My first love was Debian
- My exploration phase was mainly done on Manjaro and Fedora
- Now running Arch and Void

Thanks
------

- Linus Torvalds / Linux
- Richard Stallman / FSF / GNU
- Ian Murdock / Debian
- Arch Linux, its Wiki and community
- Void Linux, its Handbook and community
- DistroWatch
- Github
- and every-single-one-of-you that shared open source <3

