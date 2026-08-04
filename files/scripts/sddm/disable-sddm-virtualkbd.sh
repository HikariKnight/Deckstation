#!/usr/bin/env bash
set -oue pipefail

# Remove virtual keyboard on SDDM
# as this image is for workstations and permanently docked steamdecks
# Remove the autologin to gamescope-session
if [ -f "/etc/sddm.conf.d/virtualkbd.conf" ]; then
    rm /etc/sddm.conf.d/virtualkbd.conf
elif [ -f "/etc/plasmalogin.conf.d/virtualkbd.conf" ]; then
    rm /etc/plasmalogin.conf.d/virtualkbd.conf
fi
