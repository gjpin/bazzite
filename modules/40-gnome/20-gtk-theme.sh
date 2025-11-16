#!/usr/bin/bash

# adw-gtk3 is already installed as part of the main image:
# https://github.com/ublue-os/main/blob/main/packages.json

# Install adw-gtk3 flatpak
flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3
flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3-dark

################################################
##### For reference only
################################################

# # Download and install latest adw-gtk3 release
# URL=$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | awk -F\" '/browser_download_url.*.tar.xz/{print $(NF-1)}')
# curl -sSL ${URL} -O
# tar -xf adw-*.tar.xz -C ${HOME}/.local/share/themes/
# rm -f adw-*.tar.xz

# # Set adw-gtk3 theme
# gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
# gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# # GTK theme updater
# tee -a ${HOME}/.local/bin/update-all << 'EOF'

# ################################################
# ##### GTK theme
# ################################################

# URL=$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | awk -F\" '/browser_download_url.*.tar.xz/{print $(NF-1)}')
# curl -sSL ${URL} -O
# rm -rf ${HOME}/.local/share/themes/adw-gtk3*
# tar -xf adw-*.tar.xz -C ${HOME}/.local/share/themes/
# rm -f adw-*.tar.xz
# EOF