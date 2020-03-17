#!/usr/bin/sh


### SWAY ###

# Install
sudo pacman --noconfirm -S sway swayidle bemenu gtk-layer-shell grim jq xorg-server-xwayland qt5-wayland pulseaudio pamixer pavucontrol gsimplecal nm-connection-editor lxtask-gtk3 termite
#TODO remove waybar-git and install waybar via pacman when 0.9.2 is released
yay --noconfirm -S wofi waybar-git wlogout redshift-wlr-gamma-control

# Config
cp -r /home/jordan/GitRepo/LinuxSetup/Sway/config/* /home/jordan/.config/
cp /home/jordan/GitRepo/LinuxSetup/Sway/_.Xresources /home/jordan/.Xresources

# Enable services
systemctl --user enable waybar
systemctl --user enable swayidle@1800
systemctl --user enable redshift@4500
systemctl --user enable workspace_rules

# Startup
sudo cp /home/jordan/GitRepo/LinuxSetup/Sway/sway@.service /etc/systemd/system/
sudo cp /home/jordan/GitRepo/LinuxSetup/Sway/sway-debug@.service /etc/systemd/system/
sudo systemctl enable sway@1


### THEME ###

sudo pacman --noconfirm -S breeze breeze-gtk xsettingsd plasma-integration
gsettings set org.gnome.desktop.interface gtk-theme 'Breeze-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'breeze-dark'
flatpak --user install -y Breeze-Dark
cp /home/jordan/GitRepo/LinuxSetup/Sway/_.xsettingsd /home/jordan/.xsettingsd
systemctl --user enable --now xsettingsd


### FONTS ###

sudo pacman --noconfirm -S gsfonts ttf-dejavu noto-fonts-emoji otf-font-awesome
gsettings set org.gnome.desktop.interface font-name "Noto Sans Regular 10"
yay --noconfirm -S ttf-ms-fonts fontconfig-ubuntu cairo-ubuntu
fc-cache -f -v
sudo pacman --noconfirm -S gnome-settings-daemon # Fixes GTK flatpaks font rendering via wayland


### APPS ###

# General
sudo pacman --noconfirm -S thunar thunar-archive-plugin file-roller tumbler ristretto firefox mpv kcharselect
flatpak --user install -y flathub org.gimp.GIMP com.valvesoftware.Steam com.mojang.Minecraft com.github.wwmm.pulseeffects org.libreoffice.LibreOffice com.sublimetext.three org.kde.okular

# Steam Flatpak
sudo cp /home/jordan/GitRepo/LinuxSetup/Sway/steam_flatpak /usr/bin/steam
ln -snf /home/jordan/.var/app/com.valvesoftware.Steam/data/Steam/steamapps /home/jordan/SteamApps

# Minecraft
ln -snf /home/jordan/.var/app/com.mojang.Minecraft/.minecraft ~/.minecraft
ln -snf /home/jordan/.var/app/com.mojang.Minecraft/.minecraft ~/Minecraft

# Modular calculator
flatpak --user install jordan-repo io.github.jordanl2.ModularCalculator -y
