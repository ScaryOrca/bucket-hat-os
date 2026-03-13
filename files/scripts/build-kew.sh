#!/usr/bin/env bash
set -oue pipefail

DEPS=(
  chafa-devel
  fftw-devel
  glib2-devel
  libatomic
  libogg-devel
  libvorbis-devel
  opus-devel
  opusfile-devel
  taglib-devel
)

# Install dependencies.
dnf install -y "${DEPS[@]}"

git clone https://codeberg.org/ravachol/kew.git && cd kew
make -j4
make install

# Remove dependencies.
dnf remove -y "${DEPS[@]}"
