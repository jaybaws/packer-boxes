#!/bin/bash
sudo yum install -y \
	python3.11 \
	python3.11-pip \
	python3.11-cryptography \
	python3.11-devel \
	python3.11-jmespath \
	python3.11-libs \
	python3.11-lxml \
	python3.11-pyyaml \
	python3.11-requests

sudo yum install -y pipx

sudo pip3.11 install \
	pytest \
	pytest-testinfra \
	black \
	flake8 \
	mypy \
	pylance \
	pylint \
	pyscaffold
