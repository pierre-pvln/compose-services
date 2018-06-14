# ==========================================
# Raspberry Pi 3 Baseline Dockerfile
# ==========================================

# Import baseline image
#
FROM resin/rpi-raspbian

MAINTAINER Pierre Veelen <pierre@pvln.nl>

LABEL version="1.0" maintainer="Pierre Veelen <pierre@pvln.nl>"

# ==========================================
# START OF INSTALLING UTILITIES AND DEFAULTS
# ==========================================

RUN sudo apt-get update && \
    sudo apg-get upgrade -y && \
    sudo apt-get install -y \
    apt-utils \
    nano \
    ssh \
    net-tools \
    locale && \
    sudo apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ==========================================
# CONFIGURE TIMEZONE AND LOCALE
# ==========================================
#
# Inspiration: https://github.com/jacksoncage/apache-docker
#

RUN echo "Europe/Amsterdam" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

RUN export LANGUAGE=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    locale-gen en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# ==========================================
# END OF UTILITIES AND DEFAULTS
# ==========================================

# ==========================================
# ENTRYPOINT & CMD
# ==========================================

# Cancel any pre-defined start-up instruction and allow us to use our own.
#
ENTRYPOINT []

# Add our own entrypoint scriptn.
#
ADD ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/bin/bash","entrypoint.sh"]

#CMD /bin/bash
