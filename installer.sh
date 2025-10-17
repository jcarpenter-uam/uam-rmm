#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check for root permissions
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run with root privileges"
  exit 1
fi

echo "[Installer] Starting setup..."
# Children scripts to run
./setup/wazuh.sh

echo -e "\n[Installer] Sir, your enviornment is ready to deploy"
