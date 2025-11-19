#!/usr/bin/bash

# Instal CEMU
sudo flatpak install -y flathub info.cemu.Cemu

# Import Flatpak overrides
cp ./configs/flatpak/info.cemu.Cemu ${HOME}/.local/share/flatpak/overrides/info.cemu.Cemu