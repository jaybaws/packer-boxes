#!/bin/bash
set -e
echo "[software-provision] *** Azure CLI - start"

echo "[software-provision] [az_cli] Install Azure CLI"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "[software-provision] [az_cli] Install Azure CLI extensions"
sudo /usr/bin/az extension add --name amg
sudo /usr/bin/az extension add --name application-insights
sudo /usr/bin/az extension add --name azure-devops
sudo /usr/bin/az extension add --name bastion
sudo /usr/bin/az extension add --name image-gallery
sudo /usr/bin/az extension add --name log-analytics

echo "[software-provision] *** Azure CLI - end"