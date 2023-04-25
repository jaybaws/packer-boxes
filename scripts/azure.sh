#!/bin/bash
sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
sudo dnf install -y azure-cli
sudo az extension add --name amg
sudo az extension add --name application-insights
sudo az extension add --name azure-devops
sudo az extension add --name bastion
sudo az extension add --name image-gallery
sudo az extension add --name keyvault-preview
sudo az extension add --name log-analytics
