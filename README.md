Macbook Pro 2011
================

Prepare
-------
* get ubuntu 18.04 => mini.iso
* unetbootin mini.iso => usbstick
* boot macbook with ALT key pressed
* install with [x] open-ssh server
* see: _arch/_bash_history
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
* setup window server/manager
sudo apt install i3 xorg xserver-xorg mesa-utils mesa-utils-extra
# TODO: apt install compton numlockx xautolock scrot iwcd
# configure terminal emulator
# configs in _arch: _xinitrc, _Xdefaults, _config/i3

* terminal: xrvt
sudo apt install rxvt-unicode xclip
open https://wiki.archlinux.org/index.php/rxvt-unicode
xclip -o  # copy from console
# copy/paste in rxvt: ctrl+alt+c ctrl+alt+v

* remap caps-lock to escape
```sh
setxkbmap -option caps:escape
```

* maximize battery life
sudo apt install powertop

see: history
