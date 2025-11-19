#!/usr/bin/bash

################################################
##### Directories
################################################

# Create ES-DE directory
mkdir -p ${HOME}/Games/Emulation/es-de

################################################
##### Download
################################################

# https://gitlab.com/es-de/emulationstation-de/-/packages
# project_id: 18817634 (found in the TML)

# Download ES-DE
export SYS_ID="$(/usr/libexec/hwsupport/sysid)"
export LATEST_ES_DE_VERSION=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages?package_name=ES-DE_Stable&order_by=version&sort=desc" | jq -r '.[0].version') # 3.4.0
export LATEST_ES_DE_PACKAGE_ID=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages?package_name=ES-DE_Stable&order_by=version&sort=desc" | jq -r '.[0].id') # 48345652

if [[ ":Jupiter:" =~ ":$SYS_ID:" || ":Galileo:" =~ ":$SYS_ID:" ]]; then
    # steam deck
    export LATEST_ES_DE_APPIMAGE_ID=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages/${LATEST_ES_DE_PACKAGE_ID}/package_files" | jq -r '.[] | select(.file_name == "ES-DE_x64_SteamDeck.AppImage") | .id') # 243196994
    export LATEST_ES_DE_DOWNLOAD_LINK="https://gitlab.com/es-de/emulationstation-de/-/package_files/${LATEST_ES_DE_APPIMAGE_ID}/download"
else
    # everything else
    export LATEST_ES_DE_APPIMAGE_ID=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages/${LATEST_ES_DE_PACKAGE_ID}/package_files" | jq -r '.[] | select(.file_name == "ES-DE_x64.AppImage") | .id') # 243196984
    export LATEST_ES_DE_DOWNLOAD_LINK="https://gitlab.com/es-de/emulationstation-de/-/package_files/${LATEST_ES_DE_APPIMAGE_ID}/download"
fi

curl -s -o ${HOME}/Games/Emulation/es-de/ES-DE.AppImage ${LATEST_ES_DE_DOWNLOAD_LINK}
chmod +x ${HOME}/Games/Emulation/es-de/ES-DE.AppImage

################################################
##### Shortcut
################################################

# Create ES-DE desktop shortcut
mkdir -p ${HOME}/.local/share/applications
tee ${HOME}/.local/share/applications/es-de.desktop << EOF
[Desktop Entry]
Name=ES-DE
GenericName=Emulator Frontend
Comment=EmulationStation Desktop Edition. An Emulator Frontend.
Exec=${HOME}/Games/Emulation/es-de/ES-DE.AppImage --home ${HOME}/Games/Emulation/es-de
Terminal=false
Icon=${HOME}/Games/Emulation/es-de/logo.png
Type=Application
Categories=Games;
EOF

# Copy ES-DE logo
cp ./configs/es-de/logo.png ${HOME}/Games/Emulation/es-de/logo.png

# Update desktop entries
update-desktop-database ${HOME}/.local/share/applications/

################################################
##### Configs
################################################

# Import launchers
cp -R ./configs/es-de/launchers ${HOME}/Games/Emulation/es-de

# Import ES-DE configuration
mkdir -p ${HOME}/Games/Emulation/es-de/ES-DE/{settings,downloaded_media,gamelists,themes,custom_systems}
envsubst < ./configs/es-de/settings/es_settings.xml | tee ${HOME}/Games/Emulation/es-de/ES-DE/settings/es_settings.xml
envsubst < ./configs/es-de/custom_systems/es_find_rules.xml | tee ${HOME}/Games/Emulation/es-de/ES-DE/custom_systems/es_find_rules.xml
cp -R ./configs/es-de/downloaded_media/* ${HOME}/Games/Emulation/es-de/ES-DE/downloaded_media
cp -R ./configs/es-de/gamelists/* ${HOME}/Games/Emulation/es-de/ES-DE/gamelists
cp -R ./configs/es-de/themes/* ${HOME}/Games/Emulation/es-de/ES-DE/themes

################################################
##### Updater
################################################

# ES-DE updater
tee -a ${HOME}/.local/bin/update-all << 'EOF'

################################################
##### ES-DE
################################################

export SYS_ID="$(/usr/libexec/hwsupport/sysid)"
export LATEST_ES_DE_VERSION=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages?package_name=ES-DE_Stable&order_by=version&sort=desc" | jq -r '.[0].version') # 3.4.0
export LATEST_ES_DE_PACKAGE_ID=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages?package_name=ES-DE_Stable&order_by=version&sort=desc" | jq -r '.[0].id') # 48345652

if [[ ":Jupiter:" =~ ":$SYS_ID:" || ":Galileo:" =~ ":$SYS_ID:" ]]; then
    # steam deck
    export LATEST_ES_DE_APPIMAGE_ID=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages/${LATEST_ES_DE_PACKAGE_ID}/package_files" | jq -r '.[] | select(.file_name == "ES-DE_x64_SteamDeck.AppImage") | .id') # 243196994
    export LATEST_ES_DE_DOWNLOAD_LINK="https://gitlab.com/es-de/emulationstation-de/-/package_files/${LATEST_ES_DE_APPIMAGE_ID}/download"
else
    # everything else
    export LATEST_ES_DE_APPIMAGE_ID=$(curl -s "https://gitlab.com/api/v4/projects/18817634/packages/${LATEST_ES_DE_PACKAGE_ID}/package_files" | jq -r '.[] | select(.file_name == "ES-DE_x64.AppImage") | .id') # 243196984
    export LATEST_ES_DE_DOWNLOAD_LINK="https://gitlab.com/es-de/emulationstation-de/-/package_files/${LATEST_ES_DE_APPIMAGE_ID}/download"
fi

curl -s -o ${HOME}/Games/Emulation/es-de/ES-DE.AppImage ${LATEST_ES_DE_DOWNLOAD_LINK}
chmod +x ${HOME}/Games/Emulation/es-de/ES-DE.AppImage
EOF