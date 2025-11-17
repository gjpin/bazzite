#!/usr/bin/bash

# Instal Eden
sudo flatpak install -y private dev.eden-emu.Eden

# Import Flatpak overrides
cp ./configs/flatpak/dev.eden-emu.Eden ${HOME}/.local/share/flatpak/overrides/dev.eden-emu.Eden