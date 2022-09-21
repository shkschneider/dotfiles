--awful.util.shell = ""

defaults = {}

defaults.terminal = "alacritty"
defaults.file = "nautilus"
defaults.web = "brave"
defaults.lock = "i3lockr --blur=25"
defaults.run = "rofi -show drun -theme ~/.config/rofi/launcher.rasi"
--defaults.switch = "rofi -show window -theme ~/.config/rofi/launcher.rasi"
defaults.network = "nm-connection-editor"
defaults.hardware = "gnome-system-monitor"
defaults.disks = "gnome-disks"
defaults.power = "bash ~/.config/rofi/powermenu.sh"
--defaults.copy = "xsel | xsel -i -b"
--defaults.paste = "xsel -b | xsel"
--defaults.sound = "pavucontrol"

awful.spawn.with_shell("xdg-mime default nemo.desktop inode/directory")
--awful.spawn.with_shell("gsettings set org.nemo.desktop show-desktop-icons false")
awful.spawn.with_shell("gsettings set org.cinnamon.desktop.default-applications.terminal exec " .. defaults.terminal)
