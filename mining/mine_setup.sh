#!/bin/sh
# Sets up mining
CARD_STATES_FILE="amdgpu-custom-states.card0"
MINING_STRING="GRUB_CMDLINE_LINUX_DEFAULT=amdgpu.ppfeaturemask=0xfff7ffff"
echo "Appending Kernel Parameter"
sudo echo $MINING_STRING >> /etc/default/grub
echo "Rebuilding Grubs"
sudo grub-mkconfig -o /boot/grub/grub.cfg


echo "Setting up GPU Clocks"
paru -Syu amdgpu-clocks amdgpu-fan
sudo cp $CARD_STATES_FILE /etc/default/
