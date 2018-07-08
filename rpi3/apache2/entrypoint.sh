#!/bin/bash
# ==========================================
# Raspberry Pi 3 Apache2 entrypoint.sh 
# ==========================================

# This script is started (in the container) when the container is started
#

# default message
echo "Running Raspberry Pi 3 Apache2 entrypoint.sh" 
echo "============================================="
# list versions
sudo apache2 -v
echo "============================================="

# Start Apache2 in foreground modus
#
/usr/sbin/apache2ctl -D FOREGROUND
