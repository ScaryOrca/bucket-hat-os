#!/usr/bin/env bash
set -oue pipefail

# Create greetd directory and set correct permissions.
mkdir -p /var/lib/greetd
chown greetd:greetd /var/lib/greetd
