#!/usr/bin/env bash

# Print out debug info and fail if a sub-step fails
set -exuo pipefail

# Install --with-gssapi and --with-libssh2 development packages.
apt-get -y install krb5-user libssh2-1-dev
