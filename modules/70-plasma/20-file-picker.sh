#!/usr/bin/bash

# Use KDE file picker in Flatpak applications
mkdir -p ${HOME}/.config/xdg-desktop-portal
tee -a ${HOME}/.config/xdg-desktop-portal/portals.conf << 'EOF'
[preferred]
default=kde
org.freedesktop.impl.portal.FileChooser=kde
EOF

# Use KDE file picker in GTK applications
sudo tee -a /etc/environment << EOF

# KDE file picker
GDK_DEBUG=portals
GTK_USE_PORTAL=1
EOF