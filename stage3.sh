#!/usr/bin/env bash

set -euxo pipefail

. common.sh

# Build stage 3. Stage 3 produces all the relevant test images.
echo "Building stage 3 (version ${VERSION})"

# Build for test: gcc-8 (with-gssapi, with-libssh2) CHECKSRC=1
build_image_versioned gssapi_libssh2 base_gcc8 create_gssapi_libssh2.sh


# On Travis, push the images.
if [[ -n "${TRAVIS:-}" ]]
then
  push_image_versioned gssapi_libssh2
fi
