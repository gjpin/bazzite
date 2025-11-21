#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Disable extensions
gnome-extensions disable blur-my-shell@aunetx
# gnome-extensions disable gsconnect@andyholmes.github.io
# gnome-extensions disable hotedge@jonathan.jdoda.ca

log_success "Module completed successfully"
log_end
