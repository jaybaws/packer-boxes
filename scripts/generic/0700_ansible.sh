#!/bin/bash
set -e
echo "[software-provision] *** Ansible - start"

echo "[software-provision] [ansible] Install Ansible with frozen dependencies into (new) 'ansible-stable' venv"
sudo -u $TARGET_USER \
	python3.11 -m venv /home/$TARGET_USER/.venv/ansible-stable && \
	source /home/$TARGET_USER/.venv/ansible-stable/bin/activate && \
	pip3 install --upgrade pip && \
	pip3 install \
		docker==6.1.3 \
		selinux==0.3.0 \
		ansible-core==2.15.0 \
		molecule==5.0.1 \
		ansible-lint==6.16.2 \
		"molecule-plugins[docker]"==23.4.1 \
		jmespath==1.0.1 \
		libs==0.0.10 \
		lxml==4.9.2 \
		pyyaml==6.0 \
		requests==2.31.0 && \
	deactivate

echo "[software-provision] [ansible] Install Ansible with latest dependencies into (new) 'ansible-experimental' venv"
sudo -u $TARGET_USER \
	python3.11 -m venv /home/$TARGET_USER/.venv/ansible-experimental && \
	source /home/$TARGET_USER/.venv/ansible-experimental/bin/activate && \
	pip3 install --upgrade pip && \
	pip3 install \
		docker \
		selinux \
		ansible \
		molecule \
		ansible-lint \
		"molecule-plugins[docker]" \
		jmespath \
		libs \
		lxml \
		pyyaml \
		requests && \
	deactivate

echo "[software-provision] [ansible] Install relevant Ansible Collections into 'ansible-stable' venv"
sudo -u $TARGET_USER \
	/usr/bin/true && \
	source /home/$TARGET_USER/.venv/ansible-stable/bin/activate && \
	ansible-galaxy collection install -p /home/$TARGET_USER/.ansible-stable \
		ansible.netcommon:==5.1.1 \
		ansible.posix:==1.5.4 \
		ansible.utils:==2.10.3 \
		community.network:==5.0.0 \
		community.hashi_vault:==5.0.0 \
		community.general:==7.0.1 \
		community.docker:==3.4.7 \
		community.dns:==2.5.4 \
		community.crypto:==2.14.0 \
		kubernetes.core:==2.4.0 && \
	deactivate

echo "[software-provision] [ansible] Install relevant Ansible Collections into 'ansible-experimental' venv"
sudo -u $TARGET_USER \
	/usr/bin/true && \
	source /home/$TARGET_USER/.venv/ansible-experimental/bin/activate && \
	ansible-galaxy collection install -p /home/$TARGET_USER/.ansible-experimental  \
		ansible.netcommon \
		ansible.posix \
		ansible.utils \
		community.network \
		community.hashi_vault \
		community.general \
		community.docker \
		community.dns \
		community.crypto \
		kubernetes.core && \
	deactivate

echo "[software-provision] *** Ansible - end"