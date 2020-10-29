#!/bin/bash
set -e
vagrant box add jaybaws/vscode-backend-centos7
curl -fsSL https://raw.githubusercontent.com/jaybaws/packer-boxes/main/Vagrantfile.tpl -o Vagrantfile
