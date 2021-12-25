#!/bin/sh


# #install paru
echo "Installing Paru"
sudo pacman --needed -S git base-devel
pushd $HOME
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
# get back to this folder
popd
# Get rid of the paru install directory
sudo rm -r ~/paru


echo "Setting github"
# set git user and email
echo "Enter your email"
read email
echo "Enter your name"
read name
git config --global user.email "$email"
git config --global user.name "$name"

# Prompt to add ssh to gitlab/hub
echo "Please set up an SSH key (ssh-keygen) and add id_rsa.pub to github/lab"
read X


# install packages from packages.txt
echo "Installing necessary packages"
paru -S --needed $(comm -12 <(pacman -Slq | sort) <(sort packages.txt))
# # Pull dotfiles
pushd $HOME
echo "Installing dotfiles"
yadm clone git@gitlab.com:michaelagallo95/dotfiles.git
yadm remote set-url --add --push origin git@github.com:Michael-Gallo/dotfiles.git
# Set the shell to zsh
echo "Changing shell to zsh"
sudo chsh -s /bin/zsh $USER
# Install antibody extensions
pushd $HOME/.config/zsh
antibody bundle < ./zsh_plugins.txt > zsh_plugins.sh
$HOME/.config/zsh/install_zsh.sh
popd
# Config currently needs this file
mkdir -p $HOME/.config/bash
touch $HOME/.config/bash/private_env
# Install dwm
echo "Installing DWM"
pushd $HOME
git clone git@gitlab.com:michaelagallo95/dwm.git
git remote set-url --add --push origin git@github.com:Michael-Gallo/dwm.git
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
git remote set-url --add --push origin git@github.com:Michael-Gallo/dwl.git
cd dwl
sudo make clean install
popd
sudo cp dwl.desktop /usr/share/wayland-sessions
# Install dmenu
echo "Installing Dmenu"
pushd $HOME
git clone git@gitlab.com:michaelagallo95/dmenu.git
git remote set-url --add --push origin git@github.com:Michael-Gallo/dmenu.git
cd dmenu
sudo make clean install
popd
# Install Luke Smith's built of ST
pushd $HOME
echo "Installing st (Luke Smith's build)"
git clone https://github.com/LukeSmithxyz/st.git
cd st
sudo make install
popd
