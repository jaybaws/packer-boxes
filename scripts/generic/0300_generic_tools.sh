#!/bin/bash
#set -e
echo "[software-provision] *** GENERIC TOOLS - start"

echo "[software-provision] [generic tools] install 'zip'"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zip

echo "[software-provision] [generic tools] install 'unzip'"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unzip

echo "[software-provision] [generic tools] install 'mlocate'"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mlocate

echo "[software-provision] [generic tools] install 'yq'"
sudo snap install yq

echo "[software-provision] [generic tools] install 'jq'"
sudo snap install jq

echo "[software-provision] *** GENERIC TOOLS - end"