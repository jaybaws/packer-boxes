#!/bin/bash -eux

# Install Python3 and dependencies.
yum -y install gcc python3-pip python3-devel openssl-devel python3-libselinux

# Install Ansible, Molecule and linting tools.
python3 -m pip install -U pip
sudo -u vagrant pip3 install --user yamllint
sudo -u vagrant pip3 install --user ansible
sudo -u vagrant pip3 install --user ansible-lint
sudo -u vagrant pip3 install --user molecule[docker,lint]
sudo -u vagrant pip3 install --user pytest-testinfra
sudo -u vagrant pip3 install --user jmespath

# Install Docker.
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh
usermod -aG docker vagrant
systemctl enable docker

# Install GIT.
yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
yum -y install git

# Install Azure CLI
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/azure-cli.repo
yum -y install azure-cli
yum -y install https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
yum -y install dotnet-sdk-5.0
sudo -u vagrant az extension add --name azure-devops
