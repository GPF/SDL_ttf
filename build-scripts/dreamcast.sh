#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD_DIR="$SCRIPT_DIR/dcbuild"

if [ -z "$KOS_BASE" ]; then
    . /opt/toolchains/dc/kos/environ.sh
fi

SDL3_DIR="${SDL3_DIR:-/opt/toolchains/dc/kos/addons/lib/dreamcast/cmake/SDL3}"

kos-cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX=/opt/toolchains/dc/kos/addons \
    -DCMAKE_INSTALL_LIBDIR=lib/dreamcast \
    -DCMAKE_INSTALL_INCLUDEDIR=include \
    -DCMAKE_INSTALL_DATAROOTDIR=share \
    -DSDLTTF_SAMPLES_INSTALL=ON \
    -DSDL3_DIR="$SDL3_DIR" \
    -DSDLTTF_SAMPLES=OFF

cmake --build "$BUILD_DIR"
cmake --install "$BUILD_DIR" --config Release
