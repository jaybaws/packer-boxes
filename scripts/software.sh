#!/bin/bash -eux

# Install Python3 and dependencies.
yum -y install gcc python3-pip python3-devel openssl-devel python3-libselinux

# Install Ansible, Molecule and linting tools.
sudo -u vagrant pip3 install --user yamllint
sudo -u vagrant pip3 install --user ansible
sudo -u vagrant pip3 install --user ansible-lint
sudo -u vagrant pip3 install --user molecule[docker,lint]

# Install Docker.
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh
usermod -aG docker vagrant
systemctl enable docker

# Install GIT.
yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
yum -y install git