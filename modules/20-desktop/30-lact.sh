#!/usr/bin/bash

# Instal LACT
sudo flatpak install -y flathub io.github.ilya_zlobintsev.LACT

# Import Flatpak overrides
cp ./configs/flatpak/io.github.ilya_zlobintsev.LACT ${HOME}/.local/share/flatpak/overrides/io.github.ilya_zlobintsev.LACT