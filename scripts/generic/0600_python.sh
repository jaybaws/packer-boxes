#!/bin/bash
set -e
echo "[software-provision] *** Python - start"

echo "[software-provision] [python] Add the Python repository"
sudo add-apt-repository ppa:deadsnakes/ppa

echo "[software-provision] [python] Install Python (+ dev libs + venv)"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3.11 python3.11-dev python3.11-venv
sudo chown -f -R $TARGET_USER:$TARGET_USER /home/$TARGET_USER/.cache || true

echo "[software-provision] [python] Install pip"
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

echo "[software-provision] [python] Install poetry"
curl -sSL https://install.python-poetry.org | sudo -u $TARGET_USER python3.11 -
sudo chown -R $TARGET_USER:$TARGET_USER /home/$TARGET_USER/.local

echo "[software-provision] [python] Customize poetry"
sudo -u $TARGET_USER /home/$TARGET_USER/.local/bin/poetry completions bash >> ~/.bash_completion
sudo -u $TARGET_USER /home/$TARGET_USER/.local/bin/poetry config virtualenvs.path ~/.venv/
sudo -u $TARGET_USER /home/$TARGET_USER/.local/bin/poetry config virtualenvs.in-project true

echo "[software-provision] [python] Add global libs"
sudo -u $TARGET_USER pip3 install \
	selinux \
	pytest \
	pytest-testinfra \
	black \
	flake8 \
	mypy \
	pylance \
	pylint \
	pyscaffold

echo "[software-provision] [python] Create 'python-generic' venv"
sudo -u $TARGET_USER mkdir /home/$TARGET_USER/.venv
sudo -u $TARGET_USER python3.11 -m venv /home/$TARGET_USER/.venv/python-generic

echo "[software-provision] *** Python - end"