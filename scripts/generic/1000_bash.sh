#!/bin/bash
set -e

echo "[software-provision] *** Bash customizations - start"

echo "[software-provision] [bash] Set up customized ~/.bash_aliases"
cp -f /tmp/.bash_aliases /home/$TARGET_USER/
# sudo rm -f /tmp/.bash_aliases

sudo apt install dos2unix
dos2unix /home/$TARGET_USER/.bash_aliases

echo "[software-provision] [bash] Inject box-version in ~/.bashrc"
printf "\nexport BOX_VERSION=$VERSION\n" >> /home/$TARGET_USER/.bashrc

echo "[software-provision] *** Bash customizations - end"