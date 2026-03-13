#!/usr/bin/env bash
set -oue pipefail

DEPS=(
  chafa
  faad2
  fftw
  glib2
  libatomic
  libogg
  libvorbis
  opus
  opusfile
  taglib
)

BUILD_DEPS=(
  chafa-devel
  faad2-devel
  fftw-devel
  glib2-devel
  libogg-devel
  libvorbis-devel
  opus-devel
  opusfile-devel
  taglib-devel
)

# Install dependencies.
dnf install -y "${DEPS[@]}" "${BUILD_DEPS[@]}"

git clone https://codeberg.org/ravachol/kew.git /tmp/kew
cd /tmp/kew
make -j$(nproc)
make install PREFIX=/usr

# Remove dependencies.
dnf remove -y "${BUILD_DEPS[@]}"
