#!/usr/bin/bash

# Enable LUKS TPM unlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-luks/src/luks-enable-tpm2-autounlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-just/src/recipes/15-luks.just
ujust setup-luks-tpm-unlock

################################################
##### For reference only
################################################

# # Enrol TPM2 unlock
# if ! cryptsetup luksDump /dev/nvme0n1p2 | grep systemd-tpm2 > /dev/null; then
#     sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7+14 /dev/nvme0n1p2
# fi

# # Add tpm2-tss module to dracut
# if ! rpm-ostree initramfs | grep tpm2 > /dev/null; then
#     sudo rpm-ostree initramfs --enable --arg=--force-add --arg=tpm2-tss
# fi