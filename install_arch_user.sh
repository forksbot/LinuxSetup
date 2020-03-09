#!/usr/bin/sh

# Before running this set:
# export ROOT=<your root disk device eg /dev/sda2>


### Home dir and basic config ###

cd ~
sh /mnt/gitrepo/LinuxSetup/links.sh
cp /home/jordan/GitRepo/LinuxSetup/.bash_profile .
cp /home/jordan/GitRepo/LinuxSetup/.bashrc .
cp /home/jordan/GitRepo/LinuxSetup/.vimrc .
cp /home/jordan/GitRepo/LinuxSetup/env.sh .
cp /home/jordan/GitRepo/LinuxSetup/aliases.sh .
sudo cp /home/jordan/GitRepo/LinuxSetup/.bash_profile /root/
sudo cp /home/jordan/GitRepo/LinuxSetup/root.bashrc /root/.bashrc
sudo cp /home/jordan/GitRepo/LinuxSetup/.vimrc /root/


### AUR / Yay ###

cd /tmp
sudo pacman --noconfirm -S git go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm


### Bootloader Automatic Update ###

yay --noconfirm -S systemd-boot-pacman-hook


### Apps ###

# Flatpak
sudo pacman --noconfirm -S flatpak # This should auto-select xdg-desktop-portal-gdk
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists jordan-repo /mnt/flatpakrepo/repo --gpg-import=/mnt/flatpakrepo/repo/jordan-repo.gpg

# Timeshift
sudo pacman  --noconfirm -S cronie
yay --noconfirm -S timeshift
sudo systemctl enable cronie.service
sudo cp /home/jordan/GitRepo/LinuxSetup/timeshift-* /etc/cron.d/
sudo chmod 0644 /etc/cron.d/timeshift-*
uuid=`lsblk -o UUID -n $ROOT | perl -pe 'chomp' -`
sudo sh -c "cat /home/jordan/GitRepo/LinuxSetup/timeshift.json | sed -e \"s/ROOT_DEVICE_UUID/$uuid/\" > /etc/timeshift.json"

# Software Installer
sudo ln -snf /home/jordan/GitRepo/SoftwareInstaller/softwareinstaller /usr/bin/si
