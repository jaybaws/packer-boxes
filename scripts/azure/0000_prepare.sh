#!/bin/bash
set -ex

echo "[azure] [prepare] *** AZURE PREPARATIONS - start"

echo "[azure] [prepare] Add user"
adduser --force-badname --shell /bin/bash $TARGET_USER

echo "[azure] [prepare] Add user to sudo group"
usermod -aG sudo $TARGET_USER

echo "[azure] [prepare] Grant passwordless sudo to our user"
echo "$TARGET_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$TARGET_USER

echo "[azure] [prepare] *** AZURE PREPARATIONS - end"