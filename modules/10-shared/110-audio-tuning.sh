#!/usr/bin/bash

# References:
# https://www.reddit.com/r/Bazzite/comments/1o9kj1b/psa_fix_muddy_spotify_general_sound_issues_on/

# Create pipewire config directory
mkdir -p ${HOME}/.config/pipewire/pipewire.conf.d

# Allow 44.1 ↔ 48 kHz auto switching and boost quantum ("latency")
tee ${HOME}/.config/pipewire/pipewire.conf.d/60-rates.conf << 'EOF'
context.properties = {
    default.clock.allowed-rates = [ 44100 48000 ]
    default.clock.min-quantum = 256
    default.clock.max-quantum = 1024
    default.clock.quantum = 768
}
EOF

# Better resampling, sane volumes for Pulse apps (Spotify/Chrome/etc.) and audio format F32
tee ${HOME}/.config/pipewire/pipewire.conf.d/60-streams.conf << 'EOF'
server.properties = { flat-volumes = false }
stream.properties = {
    resample.quality = 10
    audio.format = F32
}
EOF

# Apply changes
systemctl --user restart pipewire wireplumber pipewire-pulse