#!/bin/bash

#install git and yay so aur packages can be installed
sudo pacman -S git
pushd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# get back to this folder
cd $HOME
sudo rm -r ./yay
popd
# install packages from packages.txt
sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort packages.txt))
# install AUR packages, need keyserver fix for libxft to work
gpg --keyserver pool.sks-keyservers.net --recv-keys  4A193C06D35E7C670FA4EF0BA2FB9E081F2D130E
yay -S - < foreign_packages.txt
# install exa
cargo install exa
# install flatpaks
flatpak install - < flatpaks.txt
