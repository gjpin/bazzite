#!/usr/bin/bash

# Instal ES-DE
sudo flatpak install -y flathub org.es.ES-DE

# Import Flatpak overrides
cp ./configs/flatpak/org.es.ES-DE ${HOME}/.local/share/flatpak/overrides/org.es.ES-DE