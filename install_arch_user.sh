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

cd /tmp
sudo pacman --noconfirm -S git go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm


### Bootloader Automatic Update ###

yay --noconfirm -S systemd-boot-pacman-hook


### Update Mirror List ###

sudo cp /home/jordan/Scripts/LinuxSetup/mirrorlist2 /etc/pacman.d/mirrorlist
sudo pacman --noconfirm -Sc
sudo pacman-key --noconfirm --refresh-keys
sudo pacman --noconfirm -Syy


### Apps ###

# Flatpak
sudo pacman --noconfirm -S flatpak # This should auto-select xdg-desktop-portal-gdk
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -y

# Timeshift
yay --noconfirm -S timeshift
sudo systemctl enable cronie.service
sudo cp /home/jordan/Scripts/LinuxSetup/timeshift-* /etc/cron.d/
sudo chmod 0644 /etc/cron.d/timeshift-*
uuid=`lsblk -o UUID -n /dev/sda2 | perl -pe 'chomp' -`
sudo sh -c "cat /home/jordan/Scripts/LinuxSetup/timeshift.json | sed -e \"s/ROOT_DEVICE_UUID/$uuid/\" > /etc/timeshift.json"

# Software Installer
sudo ln -snf /home/jordan/Scripts/python/softwareinstaller/softwareinstaller /usr/bin/si
