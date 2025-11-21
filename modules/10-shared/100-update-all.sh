#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

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

log_success "Module completed successfully"
log_end
