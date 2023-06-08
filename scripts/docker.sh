#!/bin/bash
sudo yum remove \
	docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-engine

sudo yum install -y yum-utils
sudo yum-config-manager \
	--add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin

sudo usermod -aG docker $TARGET_USER

sudo systemctl enable docker.service
sudo systemctl enable containerd.service