#!/usr/bin/env bash
set -oue pipefail

# Create SELinux context so libvirt can use looking-glass shm
semanage fcontext -a -t svirt_tmpfs_t /dev/shm/looking-glass

IMAGE_REF="ostree-image-signed:docker://$IMAGE_REGISTRY/$IMAGE_NAME"
printf '{\n"image-ref": "'"$IMAGE_REF"'",\n"image-tag": "latest",\n"image-name": "'"$IMAGE_NAME"'"\n}' > /usr/share/ublue-os/image-info.json
