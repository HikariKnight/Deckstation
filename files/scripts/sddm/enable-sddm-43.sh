#!/usr/bin/env bash
set -oue pipefail

# Remove the autologin to gamescope-session
if [ -f "/etc/sddm.conf.d/steamos.conf" ]; then
    rm /etc/sddm.conf.d/steamos.conf
elif [ -f "/etc/plasmalogin.conf.d/steamos.conf" ]; then
    rm /etc/plasmalogin.conf.d/steamos.conf
fi

# Undo some bazzite-deck specific services we do not need anymore
systemctl disable bazzite-autologin.service
