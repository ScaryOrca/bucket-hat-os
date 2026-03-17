#!/usr/bin/env bash
set -euo pipefail

# Install latest lidm binary.
curl -Lo /usr/bin/lidm https://github.com/javalsai/lidm/releases/latest/download/lidm-amd64
chmod +x /usr/bin/lidm

# Install systemd service.
curl -Lo /usr/lib/systemd/system/lidm.service \
  https://raw.githubusercontent.com/javalsai/lidm/refs/heads/master/assets/services/systemd.service
