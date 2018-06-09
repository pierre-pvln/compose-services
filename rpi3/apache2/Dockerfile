# Import baseline image
#
FROM pvln/rpi3-baseline:1.0

MAINTAINER Pierre Veelen <pierre@pvln.nl>

LABEL version="1.0" maintainer="Pierre Veelen <pierre@pvln.nl>"

# ===========================
# START OF INSTALLING APACHE2
# ===========================
#
# Inspiration: https://writing.pupius.co.uk/apache-and-php-on-docker-44faef716150
#              https://github.com/jacksoncage/apache-docker
#

# Install apache2 and cleanup afterwards
#
RUN sudo apt-get update && sudo apt-get install -y \
    apache2 && \
    sudo apt-get upgrade && \
    sudo apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up the minimum default apache environment variables
#
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid

# Set up the additional apache environment variables
#
ENV APACHE_SERVERNAME=localhost \
    APACHE_SERVERALIAS=www.localhost \
    APACHE_SERVERADMIN=pierre@pvln.nl 

# Enable apache mods.
RUN a2enmod rewrite

# Expose apache2 on port 80 of the container
#
EXPOSE 80

# Mountable datafolder path(s) within the container
#
VOLUME /var/www/html

# Copy this repo into place
# files/folder at host , files/folders in container
#
ADD ./files/default /var/www/html

#DBG
#
RUN ls -la /var/www/html

# Update the default apache site with the config we created.
#
ADD ./conf/apache2-config.conf /etc/apache2/sites-enabled/000-default.conf

# Change folder to sitename -> change  var/www/site to var/www/html
# sed -i "s/TextFrom/TextTo/" inWhichFile
# \/ is used to escape the / in the file path
#
RUN sed -i "s/var\/www\/site/var\/www\/html/" /etc/apache2/sites-enabled/000-default.conf

# set ownership of files
#
RUN chown -Rf ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www/html

# ========================= 
#
#
# TODO CHANGE WEBSITE SERVERNAME TO PREVENT WARNING
#
# =========================

# =========================
# END OF INSTALLING APACHE2
# =========================

#
# ENTRYPOINT & CMD
# ======
# Cancel pre-defined start-up instruction and allow us to use our own.
#ENTRYPOINT []

ADD ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/bin/bash","entrypoint.sh"]
 
# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

#CMD /bin/bash
