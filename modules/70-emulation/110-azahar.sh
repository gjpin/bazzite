#!/usr/bin/bash

# Instal Azahar
sudo flatpak install -y flathub org.azahar_emu.Azahar

# Import Flatpak overrides
cp ./configs/flatpak/org.azahar_emu.Azahar ${HOME}/.local/share/flatpak/overrides/org.azahar_emu.Azahar