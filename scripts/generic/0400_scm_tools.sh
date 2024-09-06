#!/bin/bash
set -e
echo "[software-provision] *** SCM TOOLS - start"

echo "[software-provision] [scm tools] install 'git'"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git

echo "[software-provision] *** SCM TOOLS - end"