#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Set Firefox profile path
export FIREFOX_PROFILE_PATH=$(find ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox -type d -name "*.default-release")

# Gnome specific configs
cat ./configs/firefox/gnome.js >> ${FIREFOX_PROFILE_PATH}/user.js

# Bazzite already includes and updates firefox-gnome-theme:
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/libexec/topgrade/mozilla-gnome-theme-update

################################################
##### For reference only
################################################

# # Install Firefox Gnome theme
# mkdir -p ${FIREFOX_PROFILE_PATH}/chrome
# git clone https://github.com/rafaelmardojai/firefox-gnome-theme.git ${FIREFOX_PROFILE_PATH}/chrome/firefox-gnome-theme
# echo '@import "firefox-gnome-theme/userChrome.css"' > ${FIREFOX_PROFILE_PATH}/chrome/userChrome.css
# echo '@import "firefox-gnome-theme/userContent.css"' > ${FIREFOX_PROFILE_PATH}/chrome/userContent.css
# cp ./configs/firefox/gnome.js >> ${FIREFOX_PROFILE_PATH}/user.js

# # Firefox theme updater
# tee -a ${HOME}/.local/bin/update-all << 'EOF'

# ################################################
# ##### Firefox
# ################################################

# # # Update Firefox theme
# FIREFOX_PROFILE_PATH=$(realpath ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox/*.default-release)
# git -C ${FIREFOX_PROFILE_PATH}/chrome/firefox-gnome-theme pull
# EOF

log_success "Module completed successfully"
log_end
