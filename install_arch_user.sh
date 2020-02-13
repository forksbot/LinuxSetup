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

sudo pacman -S git go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


### Bootloader Automatic Update ###

yay -S systemd-boot-pacman-hook


### Printing & Scanning ###

sudo pacman -S cups hplip sane python-pillow
sudo systemctl enable --now org.cups.cupsd.service
sudo hp-setup -i # select 1
sudo hp-plugin # select d
# To scan: hp-scan


### Update Mirror List ###

sudo cp /home/jordan/Scripts/LinuxSetup/mirrorlist2 /etc/pacman.d/mirrorlist
sudo pacman -Sc
sudo pacman-key --refresh-keys
sudo pacman -Syy


### Silent boot - fsck - https://wiki.archlinux.org/index.php/Silent_boot ###

vim /etc/mkinitcpio.conf
# On line "HOOKS (" replace "udev" with "systemd"
mkinitcpio -p linux
# For each of these files:
/usr/lib/systemd/system/systemd-fsck-root.service
/usr/lib/systemd/system/systemd-fsck\@.service
# Append:
StandardOutput=null
StandardError=journal+console


### Other ###

# Fix power button behaviour
sudo echo "HandlePowerKey=suspend" >> /etc/systemd/logind.conf
