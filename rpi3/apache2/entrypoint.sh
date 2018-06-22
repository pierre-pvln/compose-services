#!/bin/bash
# ==========================================
# Raspberry Pi 3 Apache2 entrypoint.sh 
# ==========================================

# This script is started (in the container) when the container is started
#

# default messag
echo "Running Apache2 entrypoint.sh" 

# Start Apache2 in foreground modus
#
/usr/sbin/apache2ctl -D FOREGROUND
