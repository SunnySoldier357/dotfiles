# Awesome Config Dependencies (`awesome-git`)

- `acpi` (For battery widget)
- `alsa-utils` (For audio hotkeys)
- `betterlockscreen` ([For screen-locking](https://github.com/betterlockscreen/betterlockscreen))
- `brightnessctl` (For brightness hotkeys)
- `mpc`, `playerctl` (For media hotkeys)

## Appearance
- `lightdm`, `lightdm-webkit2-greeter`, `lightdm-webkit-theme-litarvan`
  ([Config Setup](https://github.com/Litarvan/lightdm-webkit-theme-litarvan#arch-linux-300))
> Enable `lightdm.service`
- `orchis-theme-git`
- `papirus-icon-theme`, `papirus-folders`
- `picom`
- `rofi`
- `xcursor-breeze`

```
paru -Sy --needed acpi alsa-utils brightnessctl mpc playerctl \
lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan \
orchis-theme-git papirus-icon-theme papirus-folders picom \
rofi xcursor-breeze
```

# System Packages
- `arandr` (Display Management)
- `blueman`, `bluez-utils` (Bluetooth)
> Enable `bluetooth.service`
- `cmatrix`
- `gnome-keyring`, `seahorse`
- `htop`
- `informant`
> Add user to `informant` group
- `lsd` (`ls` alternative)
- `lxappearance-gtk3`
- `man-db`, `man-pages`
- `ncmpcpp`
- `neofetch`
- `network-manager-applet`
- `numlockx` (Disable Num Lock on Startup)
- `nvidia`, `optimus-manager`
> Enable `optimus-manager.service`
- `polkit-gnome`
- `rcm`
- `redshift`
- `reflector`
- `timeshift`
- `ttf-fira-code`
- `zsh`, `zsh-autosuggestions`, `zsh-completions`, `zsh-syntax-highlighting`

```
paru -Sy --needed arandr blueman bluez-utils cmatrix \
gnome-keyring seahorse htop informant lsd lxappearance-gtk3 \
man-db man-pages ncmpcpp neofetch network-manager-applet \
numlockx nvidia optimus-manager polkit-gnome rcm redshift \
reflector timeshift ttf-fira-code zsh zsh-autosuggestions \
zsh-completions zsh-syntax-highlighting
```

# Applications
- `brave-bin`
- `caprine`
- `discord`
- `easytag`
- `firefox`
- `gnome-disk-utility`
- `kitty`
- `mailspring`
- `pavucontrol`
- `pcmanfm-gtk3`, `eog`, `engrampa`
- `visual-studio-code-bin`
- `xed` (Text Editor)

```
paru -Sy --needed brave-bin caprine discord easytag firefox \
gnome-disk-utility kitty mailspring pavucontrol pcmanfm-gtk3 \
eog engrampa visual-studio-code-bin xed
```

# Additional Setup

## [Displaylink](https://wiki.archlinux.org/title/DisplayLink#USB_3.0_DL-6xxx,_DL-5xxx,_DL-41xx,_DL-3xxx_Devices)

```
paru -Sy displaylink evdi-git
sudo systemctl enable displaylink
sudo echo 'Section "OutputClass"
        Identifier "DisplayLink"
        MatchDriver "evdi"
        Driver "modesetting"
        Option  "AccelMethod" "none"
EndSection' > /usr/share/X11/xorg.conf.d/20-evdidevice.conf
```

## `libinput` for Touchpad

```
sudo echo 'Section "InputClass"
Identifier "touchpad"
Driver "libinput"
  MatchIsTouchpad "on"
  Option "Tapping" "on"
  Option "NaturalScrolling" "on"
  Option "ClickMethod" "clickfinger"
EndSection' > /etc/X11/xorg.conf.d/30-touchpad.conf
```

## `rofi` Themes

https://github.com/adi1090x/rofi#installation

# Temp
- `libinput-gestures`
- `xbindkeys`, `xsel`, `xdotool`
  ([Disable Middle-Click Paste](https://gist.github.com/sam0x17/f1d89df55778e4317d8974623a62e8c6))

# Took stuff from..

- ChrisTitusTech's `material-awesome` repo
- Icons from optimus-manager-qt