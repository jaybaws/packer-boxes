#!/bin/bash
set -e
echo "[software-provision] *** Docker - start"

echo "[software-provision] [docker] update software cache"
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y

echo "[software-provision] [docker] install 'ca-certificates', 'curl' and 'gnupg'"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl gnupg

echo "[software-provision] [docker] install the keyrings"
sudo install -m 0755 -d /etc/apt/keyrings

echo "[software-provision] [docker] Add the Docker repo"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[software-provision] [docker] update software cache - again (after Docker repo was added)"
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y

echo "[software-provision] [docker] install docker (ce, ce-cli, compose)"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[software-provision] [docker] add user to docker group"
sudo usermod -aG docker $TARGET_USER

echo "[software-provision] [docker] Enable services"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo "[software-provision] *** Docker - end"