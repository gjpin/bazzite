#!/usr/bin/bash

# Instal RetroDeck
sudo flatpak install -y private net.retrodeck.retrodeck

# Import Flatpak overrides
cp ./configs/flatpak/net.retrodeck.retrodeck ${HOME}/.local/share/flatpak/overrides/net.retrodeck.retrodeck