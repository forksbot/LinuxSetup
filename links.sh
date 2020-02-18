#/bin/sh

cd ~


rm -rf Jordan
ln -s /mnt/jordan Jordan

rm -rf Documents
ln -s Jordan/Documents Documents

rm -rf Scripts
ln -s Jordan/Scripts Scripts

rm -rf Personal
ln -s Jordan/Personal Personal

rm -rf Stuff
ln -s Jordan/Personal/Stuff Stuff

rm -rf AppData
ln -s Jordan/AppData AppData


rm -rf Downloads
ln -s /mnt/download Downloads

rm -rf Public
ln -s /mnt/public Public


rm -rf Music
ln -s /mnt/multimedia/Music Music

rm -rf Videos
ln -s /mnt/multimedia/Videos Videos

rm -rf Pictures
ln -s /mnt/multimedia/Pictures Pictures

rm -rf Podcasts
ln -s /mnt/multimedia/Podcasts Podcasts

rm -rf Temp
mkdir Temp

