#!/usr/bin/bash

# Instal Eden
sudo flatpak install -y private dev.edenemu.Eden

# Import Flatpak overrides
cp ./configs/flatpak/dev.edenemu.Eden ${HOME}/.local/share/flatpak/overrides/dev.edenemu.Eden