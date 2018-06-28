#!/bin/bash
# ==========================================
# Raspberry Pi 3 vsftp entrypoint.sh 
# ==========================================

# This script is started (in the container) when the container is started
#

# default message
echo "Running Raspberry Pi 3 vsftp entrypoint.sh " 

# start vsftp service
#
service vsftpd start
