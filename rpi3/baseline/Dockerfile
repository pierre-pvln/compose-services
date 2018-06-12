FROM resin/rpi-raspbian

MAINTAINER Pierre Veelen <pierre@pvln.nl>

LABEL version="1.0" maintainer="Pierre Veelen <pierre@pvln.nl>"

# ==========================================
# START OF INSTALLING UTILITIES AND DEFAULTS
# ==========================================

RUN sudo apt-get update && sudo apt-get install -y \
    apt-utils \
    nano \
    ssh \
	net-tools && \
    sudo apt-get upgrade && \
    sudo apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# =============================
# END OF UTILITIES AND DEFAULTS
# =============================

#
# ENTRYPOINT & CMD
# ======
# Cancel pre-defined start-up instruction and allow us to use our own.
ENTRYPOINT []

CMD /bin/bash
