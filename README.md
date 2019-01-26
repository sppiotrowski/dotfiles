Macbook Pro 2011
================

Prepare
-------
* get ubuntu 18.04 => mini.iso
* unetbootin mini.iso => usbstick
* boot macbook with ALT key pressed
* install with [x] open-ssh server
```sh
hostname -I  # get ip

sudo apt install vim wget unzip
```
* backup
```sh
# backup
NAME='bakcup.tar.gz' tar -cvpzf "$NAME" --exclude="/$NAME" --exclude=/proc \
  --exclude=/tmp --exclude=/mnt --exclude=/dev \
  --exclude=/sys --exclude=/run --exclude=/media \
  --exclude=/var/log --exclude=/var/cache/apt/archives \
  --exclude=/usr/src/linux-headers* --exclude=/home/*/.cache /
# restore
sudo tar xvpfz backup.tar.gz -C /
```
* setup wifi
```sh
# setup
apt install ubuntu-drivers-common
ubuntu-drivers autoinstall
apt-get install network-manager
/bin/systemctl enable network-manager
/bin/systemctl start network-manager

# usage
nmtui  # ncurses network-manager gui
```
* setup vga drivers
```sh
sudo apt install mesa-utils mesa-utils-extra

# utils / info
lspci -v | VGA
glxifno | grep OpenGL
glxgears -info  # test performance
```
* maximize battery life
sudo apt install powertop

* setup window server/manager
sudo apt install i3 xorg xserver-xorg
# TODO: apt install compton numlockx xautolock scrot iwcd

* setup terminal: xrvt
sudo apt install rxvt-unicode xclip
open https://wiki.archlinux.org/index.php/rxvt-unicode
xclip -o  # copy from console
# copy/paste in rxvt: ctrl+alt+c ctrl+alt+v

* setup configs
```sh
mkdir -p ~/projects && cd $_
git clone git@github.com:sppiotrowski/dotfiles.git
cd dotfiles && ./install
```
* setup cli
```sh
mkdir -p ~/projects && cd $_
git clone git@github.com:sppiotrowski/cli.git
cd cli && make install
```
* remap caps-lock to escape (in: setup configs)
```sh
setxkbmap -option caps:escape
```
see: history
* setup backlight (dotfiles: bin/backlight)
* setup sound (already in distro)
alsamixer
