#!/bin/bash
sudo yum install -y epel-release
sudo yum install -y ansible

sudo pip3.11 install \
	docker \
	selinux \
	molecule ansible-lint \
	"molecule-plugins[docker]"
