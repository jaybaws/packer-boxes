#!/bin/bash
sudo yum install -y \
	python3.11 \
	python3.11-cryptography \
	python3.11-devel

sudo python3.11 -m ensurepip --upgrade
sudo python3.11 -m pip install --upgrade pip selinux

sudo -u $TARGET_USER mkdir /home/$TARGET_USER/.venv

sudo -u $TARGET_USER \
	python3.11 -m venv /home/$TARGET_USER/.venv/python-generic && \
	source /home/$TARGET_USER/.venv/python-generic/bin/activate && \
	pip3 install --upgrade pip && \
	pip3 install \
		pytest \
		pytest-testinfra \
		black \
		flake8 \
		mypy \
		pylance \
		pylint \
		pyscaffold && \
	deactivate