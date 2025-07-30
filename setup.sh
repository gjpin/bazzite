#!/usr/bin/bash

################################################
##### Set variables
################################################

read -p "Hostname: " NEW_HOSTNAME
export NEW_HOSTNAME

################################################
##### General
################################################

# Set hostname
sudo hostnamectl set-hostname --pretty "${NEW_HOSTNAME}"
sudo hostnamectl set-hostname --static "${NEW_HOSTNAME}"

# Create common directories
mkdir -p \
    ${HOME}/.local/share/themes \
    ${HOME}/.local/bin

# Create WireGuard folder
sudo mkdir -p /etc/wireguard
sudo chmod 700 /etc/wireguard

# Make NM not block boot
sudo systemctl disable --now NetworkManager-wait-online.service

# Enable BTRFS dedup
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/85-bazzite-image.just#L4
ujust enable-deduplication

# Disable MOTD
ujust toggle-user-motd

# Install Decky Loader
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L274
ujust setup-decky install

# Enable LUKS TPM unlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-luks/src/luks-enable-tpm2-autounlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-just/src/recipes/15-luks.just
ujust setup-luks-tpm-unlock

# Enable automounting
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L201
ujust enable-automounting

# Add user to input group
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L193
ujust add-user-to-input-group

################################################
##### Device type specific configurations
################################################

# Desktop
if cat /sys/class/dmi/id/chassis_type | grep 3 > /dev/null; then
  # Enable WoL
  # https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/81-bazzite-fixes.just#L92
  ujust toggle-wol force-enable
  
  # Fix WoL
  sudo grubby --update-kernel=ALL --args=xhci_hcd.quirks=270336  
  
  # Enable Sunshine
  # https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-sunshine.just
  ujust setup-sunshine enable  
  
  # Full AMD GPU control
  if lspci | grep "VGA" | grep "AMD" > /dev/null; then
    sudo grubby --update-kernel=ALL --args=amdgpu.ppfeaturemask=0xffffffff
  fi

  # Install LACT
  # https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-apps.just#L28
  ujust install-lact
fi

# Steam Deck
SYS_ID="$(/usr/libexec/hwsupport/sysid)"
if [[ ":Jupiter:" =~ ":$SYS_ID:" || ":Galileo:" =~ ":$SYS_ID:" ]]; then
  # Enable Steam Deck bios/firmware updates
  # https://github.com/ublue-os/bazzite/blob/main/system_files/deck/shared/usr/share/ublue-os/just/85-bazzite-image.just#L41
  ujust enable-deck-bios-firmware-updates
fi

################################################
##### Updates
################################################

# Updater helper
tee ${HOME}/.local/bin/update-all << EOF
#!/usr/bin/bash

################################################
##### System and firmware
################################################

# Update bazzite
ujust update

# Update firmware
sudo fwupdmgr refresh
sudo fwupdmgr update

################################################
##### Flatpaks
################################################

# Update Flatpak apps
flatpak update -y

################################################
##### General
################################################

# Clean up unused resources
ujust clean-system
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

################################################
##### Desktop Environment
################################################

# Install and configure desktop environment
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  ./gnome.sh
elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
  ./plasma.sh
fi