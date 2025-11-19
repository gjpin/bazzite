#!/usr/bin/bash

# Instal Citron
sudo flatpak install -y private org.citronemu.Citron

# Import Flatpak overrides
cp ./configs/flatpak/org.citronemu.Citron ${HOME}/.local/share/flatpak/overrides/org.citronemu.Citron