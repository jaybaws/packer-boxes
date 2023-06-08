#!/bin/bash
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