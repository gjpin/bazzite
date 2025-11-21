#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Install and start Syncthing
brew install syncthing
brew services start syncthing

log_success "Module completed successfully"
log_end
