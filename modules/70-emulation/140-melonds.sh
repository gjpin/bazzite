#!/usr/bin/bash

# Instal melonDS
sudo flatpak install -y flathub net.kuribo64.melonDS

# Import Flatpak overrides
cp ./configs/flatpak/net.kuribo64.melonDS ${HOME}/.local/share/flatpak/overrides/net.kuribo64.melonDS