#!/bin/bash

# Run using the main installer script

# Exit immediately if a command exits with a non-zero status
set -e

##
# 1. PRE-FLIGHT CHECKS & CONFIGURATION
##
# Check for root permissions, as required by sysctl
if [ "$(id -u)" -ne 0 ]; then
  echo "[Wazuh] This script must be run with root privileges"
  exit 1
fi

# Increase max_map_count on the host for Elasticsearch
if [ $(sysctl -n vm.max_map_count) -eq 262144 ]; then
  echo "[Wazuh] Kernel parameter already set, Skipping..."
else
  echo "[Wazuh] Configuring kernel parameter vm.max_map_count..."
  sysctl -w vm.max_map_count=262144 > /dev/null
fi

##
# 2. FETCH WAZUH-DOCKER REPOSITORY
##
if [ -d "wazuh-docker/single-node" ]; then
  echo -e "\n[Wazuh] Already installed, Skipping..."
  exit 0 
else
  echo "[Wazuh] Cloning the repository (v4.13.1)..."
  git clone --quiet https://github.com/wazuh/wazuh-docker.git -b v4.13.1 --depth 1 > /dev/null 2>&1

  ##
  # 3. GENERATE SSL CERTIFICATES
  ##
  echo "[Wazuh] Generating self-signed certificates..."
  # Change directory into the repository.
  cd wazuh-docker/single-node/

  # The volume paths are relative to the current directory (single-node)
  docker run --rm --hostname wazuh-certs-generator \
    -v "$(pwd)/config/wazuh_indexer_ssl_certs/:/certificates/" \
    -v "$(pwd)/config/certs.yml:/config/certs.yml" \
    wazuh/wazuh-certs-generator:0.0.2 > /dev/null 2>&1

  ##
  # 4. CLEANUP
  ##
  echo "[Wazuh] Cleaning up clutter..."
  # Go back to the root of the repository
  cd ..

  # Delete all other deployment options and non-essential files/folders
  # I promise I'm not stealing, I just hate clutter
  rm -rf multi-node \
         build-docker-images \
         wazuh-agent \
         indexer-certs-creator \
         docs \
         tools \
         .git \
         .github \
         single-node/docker-compose.yml \
         single-node/generate-indexer-certs.yml \
         single-node/README.md \
         .env \
         .gitignore \
         CHANGELOG.md \
         LICENSE \
         README.md \
         SECURITY.md \
         VERSION.json

  echo -e "\n[Wazuh] Ready"
fi
