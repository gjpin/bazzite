#!/usr/bin/bash

################################################
##### Set variables
################################################

read -p "Hostname: " NEW_HOSTNAME
export NEW_HOSTNAME

################################################
##### General
################################################

# Create common directories
mkdir -p \
    ${HOME}/ssh \
    ${HOME}/.local/share/themes \
    ${HOME}/.local/bin \
    ${HOME}/.local/share/flatpak/overrides \
    ${HOME}/.config/systemd/user

# Create WireGuard folder
sudo mkdir -p /etc/wireguard
sudo chmod 700 /etc/wireguard

################################################
##### Device type specific configurations
################################################

# Desktop
if cat /sys/class/dmi/id/chassis_type | grep 3 > /dev/null; then
  for module in modules/20-desktop/*.sh; do
    if [ -f "$module" ]; then
      echo "Running desktop module: $module"
      bash "$module"
    fi
  done
fi

# Steam Deck
SYS_ID="$(/usr/libexec/hwsupport/sysid)"
if [[ ":Jupiter:" =~ ":$SYS_ID:" || ":Galileo:" =~ ":$SYS_ID:" ]]; then
  for module in modules/30-deck/*.sh; do
    if [ -f "$module" ]; then
      echo "Running Steam Deck module: $module"
      bash "$module"
    fi
  done
fi

################################################
##### Desktop environment specific configurations
################################################

# Install and configure desktop environment
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  ./gnome.sh
elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
  ./plasma.sh
fi

################################################
##### Updates
################################################

# Updater helper
tee ${HOME}/.local/bin/update-all << EOF
#!/usr/bin/bash

################################################
##### System
################################################

# Update bazzite
ujust update
EOF

chmod +x ${HOME}/.local/bin/update-all

################################################
##### Firefox
################################################

# Set Firefox profile path
export FIREFOX_PROFILE_PATH=$(find ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox -type d -name "*.default-release")

# Import extensions
mkdir -p ${FIREFOX_PROFILE_PATH}/extensions
curl https://addons.mozilla.org/firefox/downloads/file/4003969/ublock_origin-latest.xpi -o ${FIREFOX_PROFILE_PATH}/extensions/uBlock0@raymondhill.net.xpi

# Import Firefox configs
curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/firefox/user.js -o ${FIREFOX_PROFILE_PATH}/user.js