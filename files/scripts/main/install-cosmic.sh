#!/usr/bin/env bash
set -oue pipefail

dnf5 copr enable -y ryanabx/cosmic-epoch
dnf5 -y install @cosmic-desktop @cosmic-desktop-apps
dnf5 clean all
