### Install NixOS onto another device.

```BASH
nix run github:nix-community/nixos-anywhere \
  --extra-experimental-features "nix-command flakes" \
  -- --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
  --flake '.#pothos-services' \
  --ssh-option "IdentityAgent=none" \
  --build-on-remote \
  nixos@10.10.10.21

  nix run github:nix-community/nixos-anywhere \
    --extra-experimental-features "nix-command flakes" \
    -- --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
    --flake '.#pothos-services' \
    pothos-services
```

### Pothos-0

disks

- nvme0n1
- sda

# lsblk
NAME          MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda             8:0    0 223.6G  0 disk
nvme0n1       259:0    0 238.5G  0 disk
├─nvme0n1p1   259:1    0     1M  0 part
├─nvme0n1p2   259:2    0   500M  0 part /boot
└─nvme0n1p3   259:3    0   238G  0 part
  └─pool-root 254:0    0   238G  0 lvm  /nix/store

ip: 10.10.10.21


[nixos@isopothos:~]$ curl -fsSL -o install.sh https://raw.githubusercontent.com/GuidoOffermans/nix-homelab/main/install.sh

[nixos@isopothos:~]$ which bash
/run/current-system/sw/bin/bash

[nixos@isopothos:~]$ sudo /run/current-system/sw/bin/bash install.sh
Linux detected

curl -fsSL -o install.sh https://raw.githubusercontent.com/GuidoOffermans/nix-homelab/main/install.sh
sudo /run/current-system/sw/bin/bash install.sh
