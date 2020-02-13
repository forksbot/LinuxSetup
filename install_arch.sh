#!/usr/bin/sh


hostname=rupert
username=jordan


# Install basics
pacman --noconfirm -S vim git openssh screen intel-ucode man-db man-pages


### LOCALIZATION ###

ln -snf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

echo "en_GB.UTF-8" > /etc/locale.gen
locale-gen

echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf


### HOSTNAME / HOSTS ###

echo $hostname > /etc/hostname

echo "127.0.0.1       localhost
	127.0.1.1       $hostname
	::1     localhost ip6-localhost ip6-loopback
	192.168.0.24    humphrey" > /etc/hosts


### USERS ###

# Set root password
echo "Enter root password"
passwd

useradd -m -g wheel $username
echo "Enter $username password"
passwd $username

echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel


### BOOTLOADER ###

pacman --noconfirm -S efibootmgr
bootctl --path=/boot install
pacman --noconfirm -S linux linux-lts

echo "default arch
timeout 4
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


### SERVICES ###

# Network Manager
pacman --noconfirm -S networkmanager
systemctl enable NetworkManager.service

# Network Time
pacman --noconfirm -S ntp
systemctl enable ntpd.service

# Kernel entropy fix
pacman --noconfirm -S haveged
systemctl enable haveged.service


### NETWORK DRIVES ###

pacman --noconfirm -S cifs-utils
cd /tmp
wget https://raw.githubusercontent.com/JordanL2/LinuxSetup/master/fstab
read -p "Enter NAS password: " password
cat fstab | sed -e "s/__PASSWORD__/$password/" >> /etc/fstab
cd /mnt
mkdir jordan download public multimedia


### Printing & Scanning ###

pacman --noconfirm -S cups hplip sane python-pillow
systemctl enable --now org.cups.cupsd.service
#hp-setup -i -a -b net -x
#sudo hp-setup -i # select 1
#sudo hp-plugin # select d
# To scan: hp-scan



### Silent boot - fsck - https://wiki.archlinux.org/index.php/Silent_boot ###

sed -i -e "s/^HOOKS\\(.\\+\\) udev \\(.\\+\\)\$/HOOKS\\1 systemd \\2/" /etc/mkinitcpio.conf
mkinitcpio -p linux

for f in /usr/lib/systemd/system/systemd-fsck-root.service /usr/lib/systemd/system/systemd-fsck\@.service
do
	echo "StandardOutput=null
StandardError=journal+console" >> $f


### Other ###

# Fix power button behaviour
sed -i -e "s/^#\\?HandlePowerKey=.\\+\$/HandlePowerKey=suspend/" /etc/systemd/logind.conf
