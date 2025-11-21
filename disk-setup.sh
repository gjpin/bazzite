#!/bin/bash

# Source logging functions
source lib/logging.sh

log_start

# Enable strict error handling
set -euo pipefail

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    log_error "Usage: $0 <disk_name> <mount_name>"
    log_error "Example: $0 nvme1n1 data"
    exit 1
fi

DISK_NAME="$1"
MOUNT_NAME="$2"
DISK_PATH="/dev/${DISK_NAME}"
MOUNT_PATH="/${MOUNT_NAME}"
log_info "Setting up disk: $DISK_NAME with mount name: $MOUNT_NAME"

# Determine partition suffix (nvme/loop/mmcblk use 'p1', others use '1')
if [[ "${DISK_NAME}" =~ ^(nvme|loop|mmcblk) ]]; then
    PARTITION_PATH="${DISK_PATH}p1"
else
    PARTITION_PATH="${DISK_PATH}1"
fi

log_info "Wiping existing partition layout on $DISK_PATH"
sudo wipefs -af "${DISK_PATH}"
sudo parted --script "${DISK_PATH}" mklabel gpt

log_info "Creating new partition on $DISK_PATH"
sudo parted --script "${DISK_PATH}" \
  mkpart primary 1MiB 100% \
  name 1 LUKSDATA \
  set 1 lvm off

log_info "Re-reading partition table"
sudo partprobe "${DISK_PATH}"

log_info "Encrypting partition with LUKS"
sudo cryptsetup luksFormat \
    --type luks2 \
    --cipher aes-xts-plain64 \
    --key-size 512 \
    --hash blake2b-512 \
    --pbkdf argon2id \
    --iter-time 2000 \
    --use-random \
    --sector-size 4096 \
    --align-payload=8192 \
    /dev/disk/by-partlabel/LUKSDATA

log_info "Backing up LUKS header"
sudo mkdir -p "${HOME}/.luks-headers"
sudo cryptsetup luksHeaderBackup "${PARTITION_PATH}" \
    --header-backup-file "${HOME}/.luks-headers/${MOUNT_NAME}-header-backup.img"

log_info "Opening LUKS partition"
sudo cryptsetup luksOpen /dev/disk/by-partlabel/LUKSDATA "${MOUNT_NAME}"

log_info "Formatting partition to BTRFS"
sudo mkfs.btrfs \
    -L "${MOUNT_NAME}" \
    --csum blake2b \
    --features free-space-tree,skinny-metadata \
    "/dev/mapper/${MOUNT_NAME}"

log_info "Creating mount point at $MOUNT_PATH"
sudo mkdir -p "${MOUNT_PATH}"

log_info "Adding to /etc/fstab for auto-mount"
sudo tee -a /etc/fstab << EOF

# ${MOUNT_NAME} disk
/dev/mapper/${MOUNT_NAME}  ${MOUNT_PATH}  btrfs  noatime,compress=zstd:3,discard=async,commit=120,x-systemd.requires=systemd-cryptsetup@${MOUNT_NAME}.service  0  0
EOF

log_info "Adding to /etc/crypttab for auto-unlock"
sudo tee -a /etc/crypttab << EOF

${MOUNT_NAME} UUID=$(sudo blkid -s UUID -o value ${PARTITION_PATH}) none luks
EOF

log_info "Reloading systemd configuration"
sudo systemctl daemon-reload

log_info "Enrolling TPM2 for auto-unlock"
sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=7+14 "${PARTITION_PATH}"

log_info "Mounting and setting ownership"
sudo mount "${MOUNT_PATH}"
sudo chown -R $USER:$USER "${MOUNT_PATH}"

log_end