#!/usr/bin/env bash
set -oue pipefail

# Remove the autologin to gamescope-session
rm /usr/etc/sddm.conf.d/steamos.conf

# Remove virtual keyboard on SDDM
# as this image is for workstations and permanently docked steamdecks
rm /usr/etc/sddm.conf.d/virtualkbd.conf

# Add deckstation justfile to 60-custom.just
echo 'import "/usr/share/ublue-os/just/65-deckstation.just"' >> /usr/share/ublue-os/justfile

# Create SELinux context so libvirt can use looking-glass shm
semanage fcontext -a -t svirt_tmpfs_t /dev/shm/looking-glass

IMAGE_REF="ostree-image-signed:docker://$IMAGE_REGISTRY/$IMAGE_NAME"
printf '{\n"image-ref": "'"$IMAGE_REF"'",\n"image-tag": "latest",\n"image-name": "'"$IMAGE_NAME"'"\n}' > /usr/share/ublue-os/image-info.json

# Undo some bazzite-deck specific services we do not need anymore
systemctl disable bazzite-autologin.service && \
systemctl enable ublue-update.timer
