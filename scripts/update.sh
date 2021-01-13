#!/bin/bash -eux

# Update
yum clean all
yum makecache
yum -y update
reboot