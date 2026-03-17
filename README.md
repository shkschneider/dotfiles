# dotfiles

> This is my dotfiles. There are many like them, but those are mine.
> My dotfiles are my best friends. It is my life. I must master it as I must master my life.
> Without me, my dotfiles are useless. Without my dotfiles, I am useless.

Symlinks-based, much like GNU Stow, but strictly via files, never directories.
Which allows for local configurations without messing up with those ;
(If you want copies, use `rsync`.)

> NO WARRANTY. Use at your own risk.

## Usage

```bash
git clone https://github.com/shkschneider/dotfiles [~/.dot|/opt/dotfiles]
./dotfiles [-f|--force] [profile...]
```

## Profiles

_automatic by default_

- [common](common)
- [desktop](desktop)
- [laptop](laptop)
- [server](server)

## Typical Setups

**Desktop**

- ArchLinux
- gdm
- gnome-shell
- kitty / alacritty
- zsh / bash
- nemo
- brave
- outfit / jetbrains mono

**Laptop**

- ArchLinux
- greetd
- hyprland + waybar
- kitty / alacritty
- zsh / bash
- thunar / lf
- brave
- outfit / jetbrains mono

**Server**

- VoidLinux
- bash
- lf
- wget

**RIP**

- Debian (sysv)
- AwesomeWM (X11)

## (Notable) Scripts

- [bin/neo](common/usr/local/bin/neo) -- neofetch-like script
- [bin/copy](common/usr/local/bin/copy) -- cp with progress bar
- [bin/move](common/usr/local/bin/move) -- mv with progress bar
- [bin/trash](common/usr/local/bin/trash) -- safer rm for the cli
- [sbin/pkg](common/usr/local/sbin/pkg) -- one package manager (wrapper) to rule them all

## Undo

```sh
find ~/.* -type l -print # lists symlinks
#find ~/.* -type l -delete # removes symlinks
find ~ -xtype l -delete # broken symlinks
```

## Thanks

- _Linus Torvalds_ for _Linux_
- _Ian Murdock_ for _Debian_
- _Richard Stallman_ for the _FSF_ and _GNU_
- _DistroWatch_ for helping me distro-hop too much
- _ArchLinux_ for its Wiki and community
- _VoidLinux_ for its Handbook and community
- _Github_ for spreading open-source
- and _every-single-one-of-you_ for sharing code <3
