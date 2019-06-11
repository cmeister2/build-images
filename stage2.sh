#!/usr/bin/env bash

# This script encompasses all the builds that should happen in stage 2 of
# the Travis build. This script is used locally to build all of the images in
# serial order.

set -euxo pipefail

# Build stage 2. Stage 2 produces images with gcc-8 and clang-7 installed.
echo "Building stage 2"

# Build gcc-8. Depends on `base_image` from stage1
./build_and_push.sh base_gcc8 base_image install_gcc8.sh

# Build clang-7. Depends on `base_image` from stage1
./build_and_push.sh base_clang7 base_image install_clang7.sh
