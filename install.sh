#!/bin/sh

#install paru
echo "Installing Paru"
sudo pacman -S git
pushd $HOME
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
# get back to this folder
cd $HOME
sudo rm -r ./paru
popd
echo "Setting github"
# Set github and gitlab to always use ssh
# set git user and email
echo "Enter your email"
read email
echo "Enter your name"
read name
git config --global user.email $email
git config --global user.name $name

# Prompt to add ssh to gitlab/hub
echo "Please set up an SSH key (ssh-keygen) and add id_rsa.pub to github/lab"
read X


# install packages from packages.txt
echo "Installing necessary packages"
paru -S --needed $(comm -12 <(pacman -Slq | sort) <(sort packages.txt))
# Pull dotfiles
pushd $HOME
echo "Installing dotfiles"
yadm clone git@github.com:Michael-Gallo/Dotfiles.git

# Set the shell to zsh
echo "Changing shell to zsh"
chsh --shell /bin/zsh $USER
# Install antibody extensions
pushd $HOME/.config/zsh
$HOME/.config/zsh/install_zsh.sh
popd
# Config currently needs this file
touch $HOME/.config/bash/private_env
# Install dwm
echo "Installing DWM"
pushd $HOME
git clone git@github.com:Michael-Gallo/dwm.git
cd dwm
sudo make clean install
cd blocks
sudo make clean install
popd
sudo cp dwm.desktop /usr/share/xsessions
# Install dwl
echo "Installing dwl"
pushd $HOME
git clone git@gitlab.com:michaelagallo95/dwl.git
cd dwl
sudo make clean install
popd
sudo cp dwl.desktop /usr/share/wayland-sessions
# Install dmenu
echo "Installing Dmenu"
pushd $HOME
git clone git@github.com:Michael-Gallo/dmenu.git
cd dmenu
sudo make clean install
popd
# Install Luke Smith's built of ST
echo "Installing st (Luke Smith's build)"
git clone git@github.com:LukeSmithxyz/st.git
cd st
sudo make install
cd ..
