#!/bin/bash

#command that backs up the AUR packages installed
pacman -Qm | awk '{print $1}' > foreign_packages.txt

#backs up the normal packages into packages.txt
pacman -Qqe > packages.txt

# backs up flatpaks
flatpak list --app | awk '{print $2}' > flatpaks.txt

git commit foreign_packages.txt packages.txt flatpaks.txt -m "updated installed programs"
git push -f
