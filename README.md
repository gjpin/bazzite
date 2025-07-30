# bazzite


## Format and encrypt extra drive
```bash
# Delete old partition layout and re-read partition table
sudo wipefs -af /dev/nvme1n1
sudo parted --script /dev/nvme1n1 mklabel gpt

# Partition disk and re-read partition table
sudo parted --script /dev/nvme1n1 \
  mkpart primary 0% 100% \
  name 1 LUKSDATA \
  set 1 lvm on

# Re-read partitions
sudo partprobe /dev/nvme1n1

# Encrypt and open LUKS partition
sudo cryptsetup \
    --type luks2 \
    --hash sha512 \
    --use-random \
    luksFormat /dev/disk/by-partlabel/LUKSDATA

sudo cryptsetup luksOpen /dev/disk/by-partlabel/LUKSDATA data

# Format partition to EXT4
sudo mkfs.btrfs -L data /dev/mapper/data
```