#!/bin/bash
#set -e
echo "[software-provision] *** OPERATING SYSTEM - start"

echo "[software-provision] [os] install 'software-properties-common'"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common

echo "[software-provision] [os] update software cache"
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y

echo "[software-provision] [os] upgrade all tools"
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

echo "[software-provision] *** OPERATING SYSTEM - end"