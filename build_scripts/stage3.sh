#!/usr/bin/env bash

# This script encompasses all the builds that should happen in stage 3 of
# the Travis build. This script is used locally to build all of the images in
# serial order.

set -euxo pipefail

# Import the common functionality.
. $(dirname "${BASH_SOURCE[0]}")/common.sh

# Build stage 3. Stage 3 produces all the relevant test images.
echo "Building stage 3"

# Build for test: gcc-8 (with-gssapi, with-libssh2) CHECKSRC=1
${SCRIPTDIR}/build_and_push.sh gssapi_libssh2 base_gcc8 create_gssapi_libssh2.sh
