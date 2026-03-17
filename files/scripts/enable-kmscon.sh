#!/usr/bin/env bash
set -oue pipefail

# Install kmscon.
dnf install -y kmscon kmscon-pango kmscon-gl

# Set as default VT.
ln -s /usr/lib/systemd/system/kmsconvt@.service /usr/etc/systemd/system/autovt@.service
