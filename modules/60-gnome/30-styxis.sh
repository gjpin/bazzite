#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Configure ptyxis shortcuts
gsettings set org.gnome.Ptyxis.Shortcuts move-next-tab '<Control>Tab'
gsettings set org.gnome.Ptyxis.Shortcuts move-previous-tab '<Shift><Control>Tab'
gsettings set org.gnome.Ptyxis.Shortcuts close-tab '<Control>w'
gsettings set org.gnome.Ptyxis.Shortcuts new-tab '<Control>t'
gsettings set org.gnome.Ptyxis.Shortcuts undo-close-tab '<Control><Shift>t'

log_success "Module completed successfully"
log_end
