#!/usr/bin/env bash
set -oue pipefail

# Remove virtual keyboard on SDDM
# as this image is for workstations and permanently docked steamdecks
rm /etc/sddm.conf.d/virtualkbd.conf
