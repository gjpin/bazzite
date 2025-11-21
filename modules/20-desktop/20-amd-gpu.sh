#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Full AMD GPU control
if lspci | grep "VGA" | grep "AMD" > /dev/null; then
  sudo rpm-ostree kargs --append-if-missing="amdgpu.ppfeaturemask=0xffffffff"
fi

log_success "Module completed successfully"
log_end
