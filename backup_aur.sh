#!/bin/bash

#command that backs up the AUR packages installed
pacman -Qm | awk '{print $1}' > foreign_packages.txt
