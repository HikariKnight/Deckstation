#!/usr/bin/env bash
set -oue pipefail

# Create SELinux context so libvirt can use looking-glass shm
semanage fcontext -a -t svirt_tmpfs_t /dev/shm/looking-glass

IMAGE_REF="ostree-image-signed:docker://$IMAGE_REGISTRY/$IMAGE_NAME"
printf '{\n"image-ref": "'"$IMAGE_REF"'",\n"image-tag": "latest",\n"image-name": "'"$IMAGE_NAME"'"\n}' > /usr/share/ublue-os/image-info.json

# Add Klassy repo
#OS_VERSION=$(grep "VERSION_ID" /etc/os-release | sed 's/VERSION_ID=//')
curl -sL https://download.opensuse.org/repositories/home:paul4us/Fedora_${OS_VERSION}/home:paul4us.repo | tee /etc/yum.repos.d/home_paul4us.repo
sed -i 's@gpgcheck=1@gpgcheck=0@g' /etc/yum.repos.d/home_paul4us.repo

# Install Klassy window decorations
rpm-ostree install klassy

# Disable repository
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/home_paul4us.repo
