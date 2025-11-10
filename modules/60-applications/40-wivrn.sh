#!/usr/bin/bash

# Install WiVRn
sudo flatpak install -y flathub io.github.wivrn.wivrn
curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/flatpak/io.github.wivrn.wivrn -o ${HOME}/.local/share/flatpak/overrides/io.github.wivrn.wivrn