#!/usr/bin/sh


### Home dir and basic config ###

cd ~
/mnt/jordan/Scripts/LinuxSetup/links.sh
cp /home/jordan/Scripts/LinuxSetup/.bash_profile .
cp /home/jordan/Scripts/LinuxSetup/.bashrc .
cp /home/jordan/Scripts/LinuxSetup/.vimrc .
cp /home/jordan/Scripts/LinuxSetup/env.sh .
cp /home/jordan/Scripts/LinuxSetup/aliases .
sudo cp /home/jordan/Scripts/LinuxSetup/.bash_profile /root/
sudo cp /home/jordan/Scripts/LinuxSetup/root.bashrc /root/.bashrc
sudo cp /home/jordan/Scripts/LinuxSetup/.vimrc /root/


### AUR / Yay ###

sudo pacman --noconfirm -S git go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


### Bootloader Automatic Update ###

yay --noconfirm -S systemd-boot-pacman-hook


### Update Mirror List ###

sudo cp /home/jordan/Scripts/LinuxSetup/mirrorlist2 /etc/pacman.d/mirrorlist
sudo pacman --noconfirm -Sc
sudo pacman-key --noconfirm --refresh-keys
sudo pacman --noconfirm -Syy
