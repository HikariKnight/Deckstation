#!/usr/bin/env bash
set -oue pipefail

# Add deckstation justfile to 60-custom.just
echo 'import "/usr/share/ublue-os/just/65-deckstation.just"' >> /usr/share/ublue-os/justfile
