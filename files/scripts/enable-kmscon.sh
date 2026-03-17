#!/usr/bin/env bash
set -oue pipefail

# Install kmscon.
dnf install kmscon kmscon-pango kmscon-gl

# Set as default VT.
 sudo ln -s /usr/lib/systemd/system/kmsconvt@.service /usr/etc/systemd/system/autovt@.service
