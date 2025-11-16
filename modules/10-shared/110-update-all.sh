#!/usr/bin/bash

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