#!/usr/bin/bash

# Instal Citron
sudo flatpak install -y private org.citron-emu.Citron

# Import Flatpak overrides
cp ./configs/flatpak/org.citron-emu.Citron ${HOME}/.local/share/flatpak/overrides/org.citron-emu.Citron