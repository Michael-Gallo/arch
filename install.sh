#!/bin/bash

#install git and yay so aur packages can be installed
sudo pacman -S git
cd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# install packages from packages.txt
sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort packages.txt))
# install AUR packages
yay -S < foreign_packages.txt
