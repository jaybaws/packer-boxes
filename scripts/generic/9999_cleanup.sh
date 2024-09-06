#!/bin/bash
set -e
echo "[clean-up] *** start"

echo "[clean-up] *** clear 'wget' history"
sudo rm -f /home/$TARGET_USER/.wget-hsts

echo "[clean-up] *** Assuring ownership of home directory"
sudo chown -R $TARGET_USER:$TARGET_USER /home/$TARGET_USER

echo "[clean-up] *** end"