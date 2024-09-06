#!/bin/bash
set -e
echo "[software-provision] *** Golang - start"

echo "[software-provision] [go] Install Golang"
sudo snap install --classic --channel=1.20/stable go

echo "[software-provision] *** Golang - end"