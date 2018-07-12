#!/bin/bash
# ==========================================
# Ubuntu 16.04 php 5.6 entrypoint.sh 
# ==========================================

# This script is started (in the container) when the container is started
#

# default message
echo "Running Ubuntu 16.04 php 5.6 entrypoint.sh" 
echo "============================================="
# list versions
sudo apache2 -v
echo "============================================="
sudo php -v
echo "============================================="

# Start Apache2 in foreground modus
#
/usr/sbin/apache2ctl -D FOREGROUND
