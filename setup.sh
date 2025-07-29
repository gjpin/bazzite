#!/usr/bin/bash

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
flatpak uninstall -y --unused
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

# Desktop environment specific configurations
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    # Firefox Gnome theme integration
    mkdir -p ${FIREFOX_PROFILE_PATH}/chrome
    git clone https://github.com/rafaelmardojai/firefox-gnome-theme.git ${FIREFOX_PROFILE_PATH}/chrome/firefox-gnome-theme
    echo '@import "firefox-gnome-theme/userChrome.css"' > ${FIREFOX_PROFILE_PATH}/chrome/userChrome.css
    echo '@import "firefox-gnome-theme/userContent.css"' > ${FIREFOX_PROFILE_PATH}/chrome/userContent.css
    curl -sSL https://raw.githubusercontent.com/gjpin/bazzite/main/configs/firefox/gnome.js >> ${FIREFOX_PROFILE_PATH}/user.js

    # Firefox theme updater
    tee -a ${HOME}/.local/bin/update-all << 'EOF'

################################################
##### Firefox
################################################

# Update Firefox theme
FIREFOX_PROFILE_PATH=$(realpath ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox/*.default-release)
git -C ${FIREFOX_PROFILE_PATH}/chrome/firefox-gnome-theme pull
EOF
elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
    # Better KDE Plasma integration
    curl -sSL https://raw.githubusercontent.com/gjpin/bazzite/main/configs/firefox/plasma.js >> ${FIREFOX_PROFILE_PATH}/user.js

tee -a ${HOME}/.local/share/flatpak/overrides/org.mozilla.firefox << EOF

[Environment]
GTK_THEME=Breeze
EOF
fi