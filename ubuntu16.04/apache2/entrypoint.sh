#!/bin/bash
# ==========================================
# Ubuntu 16.04 Apache2 entrypoint.sh 
# ==========================================

# This script is started (in the container) when the container is started
#

# default messag
echo "Running Ubuntu 16.04 Apache2 entrypoint.sh" 

# Start Apache2 in foreground modus
#
/usr/sbin/apache2ctl -D FOREGROUND
