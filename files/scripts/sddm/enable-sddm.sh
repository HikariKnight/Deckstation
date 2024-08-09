#!/usr/bin/env bash
set -oue pipefail

# Remove the autologin to gamescope-session
rm /etc/sddm.conf.d/steamos.conf

# Undo some bazzite-deck specific services we do not need anymore
systemctl disable bazzite-autologin.service && \
systemctl enable ublue-update.timer
