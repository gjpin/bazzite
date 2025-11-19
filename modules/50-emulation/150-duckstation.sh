#!/usr/bin/bash

# Instal DuckStation
sudo flatpak install -y private org.duckstation.DuckStation

# Import Flatpak overrides
cp ./configs/flatpak/org.duckstation.DuckStation ${HOME}/.local/share/flatpak/overrides/org.duckstation.DuckStation