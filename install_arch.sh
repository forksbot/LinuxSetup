#!/usr/bin/sh


# Install basics
pacman --noconfirm -S efibootmgr vim ntp networkmanager cifs-utils git openssh screen intel-ucode man-db man-pages


### LOCALIZATION ###

ln -snf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

echo "en_GB.UTF-8" >> /etc/locale.gen
locale-gen

echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf


### HOSTNAME / HOSTS ###

echo "rupert" > /etc/hostname

echo "127.0.0.1       localhost
	127.0.1.1       rupert
	::1     localhost ip6-localhost ip6-loopback
	192.168.0.24    humphrey" > /etc/hosts


### USERS ###

# Set root password
echo "Enter root password"
passwd

useradd -m -g wheel jordan
echo "Enter jordan password"
passwd jordan

echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel


### BOOTLOADER ###

bootctl --path=/boot install
pacman --noconfirm -S linux linux-lts

echo "default arch
timeout  4
console-mode max" > /boot/loader/loader.conf

uuid=`lsblk -o UUID -n /dev/sda2 | perl -pe 'chomp' -`

echo "title Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=$uuid rw quiet loglevel=3 vga=current rd.systemd.show_status=auto rd.udev.log_priority=3 vt.global_cursor_default=0" > /boot/loader/entries/arch.conf

echo "title Arch Linux (LTS Kernel)
linux   /vmlinuz-linux-lts
initrd  /initramfs-linux-lts.img
options root=UUID=$uuid rw" > /boot/loader/entries/arch-lts.conf


### NETWORKING / TIME ###

systemctl enable NetworkManager.service
systemctl enable ntpd.service


### KERNEL ENTROPY FIX ###

pacman --noconfirm -S haveged
systemctl enable haveged.service


### NETWORK DRIVES ###

cd /tmp
wget https://raw.githubusercontent.com/JordanL2/LinuxSetup/master/fstab
read -p "Enter NAS password: " password
cat fstab | sed -e "s/__PASSWORD__/$password/" >> /etc/fstab
cd /mnt
mkdir jordan download public multimedia
