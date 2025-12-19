#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Install BSManager
URL=$(curl -s https://api.github.com/repos/Zagrios/bs-manager/releases/latest | awk -F\" '/browser_download_url.*.flatpak/{print $(NF-1)}')
curl -sSL ${URL} -o ${HOME}/Downloads/BSManager.flatpak
sudo flatpak install -y ${HOME}/Downloads/BSManager.flatpak
rm -f ${HOME}/Downloads/BSManager.flatpak

# Import Flatpak overrides
# cp ./configs/flatpak/com.vysp3r.ProtonPlus ${HOME}/.local/share/flatpak/overrides/com.vysp3r.ProtonPlus

log_success "Module completed successfully"
log_end
