#!/bin/bash

# Run from the root project folder not from within the setup dir

# Exit immediately if a command exits with a non-zero status
set -e

##
# 1. PRE-FLIGHT CHECKS & CONFIGURATION
##
echo "Starting Wazuh Docker setup..."

# Check for root permissions, as required by sysctl
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run with root privileges"
  exit 1
fi

# Increase max_map_count on the host for Elasticsearch
echo "Configuring kernel parameter vm.max_map_count..."
sysctl -w vm.max_map_count=262144 > /dev/null

##
# 2. FETCH WAZUH-DOCKER REPOSITORY
##
echo "Cloning the Wazuh Docker repository (v4.13.1)..."
# Remove the directory if it already exists to ensure a clean clone
rm -rf wazuh-docker
git clone --quiet https://github.com/wazuh/wazuh-docker.git -b v4.13.1 --depth 1 > /dev/null 2>&1

##
# 3. GENERATE SSL CERTIFICATES
##
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
echo "Cleaning up clutter..."
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

echo -e "\nSir, your wazuh deployment is ready"
