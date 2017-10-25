# Import baseline image
#
FROM pvln/${MY_PLATFORM}-baseline:1.0

MAINTAINER Pierre Veelen <pierre@pvln.nl>

# ===========================
# START OF INSTALLING APACHE2
# ===========================
#
# Inspiration: https://writing.pupius.co.uk/apache-and-php-on-docker-44faef716150
#              https://github.com/jacksoncage/apache-docker
#

# Setup the sitename through an environment variable set in the build script
# 
#ENV MY_SITENAME=${MY_APACHE2_SITENAME}

#DBG
RUN echo "MY_WEBFOLDER: $MY_WEBFOLDER" 

ENV MY_WEBFOLDER=html

#DBG
RUN echo "MY_WEBFOLDER: $MY_WEBFOLDER" 

# Install apache2 and cleanup afterwards
#
RUN sudo apt-get update && sudo apt-get install -y \
    apache2 && \
    sudo apt-get upgrade && \
    sudo apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable apache mods.
RUN a2enmod rewrite

# Set up the apache environment variables
#
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid \
    APACHE_DOCUMENTROOT=/var/www/${MY_WEBFOLDER} \
    APACHE_SERVERNAME=localhost \
    APACHE_SERVERADMIN=pierre@pvln.nl \
    APACHE_SERVERALIAS=www.localhost 

#DBG
RUN echo "APACHE_DOCUMENTROOT: $APACHE_DOCUMENTROOT"
	
# Expose apache2 on port 80
#
EXPOSE 80

# Mountable datafolder path
VOLUME ["$APACHE_DOCUMENTROOT"]

# Copy this repo into place
#
ADD ./files/default $APACHE_DOCUMENTROOT

# set ownership of files
#
RUN chown -Rf $APACHE_RUN_USER:$APACHE_RUN_GROUP ${APACHE_DOCUMENTROOT}

# Update the default apache site with the config we created.
#
ADD ./conf/apache2-config.conf /etc/apache2/sites-enabled/000-default.conf

# Change folder to sitename -> change  var/www/site to ${APACHE_DOCUMENTROOT}
# sed -i "s/TextFrom/TextTo/" inWhichFile
# \/ is used to escape the / in the file path
#
#RUN sed -i "s/var\/www\/site/var\/www\/${MY_APACHE2_SITENAME}/" /etc/apache2/sites-enabled/000-default.conf
RUN sed -i "s/var\/www\/site/var\/www\/${MY_WEBFOLDER}/" /etc/apache2/sites-enabled/000-default.conf

# TODO CHANGE WEBSITE SERVERNAME TO PREVENT WARNING

# =========================
# END OF INSTALLING APACHE2
# =========================

# ========================
# START OF INSTALLING PHP5
# ========================

# Install php5 and cleanup afterwards
#
RUN sudo apt-get update &&  sudo apt-get install -y \
	 libapache2-mod-php5 \
	 php5 \ 
	 php-pear \
	 php5-xcache \
	 php5-mysql \
	 php5-curl \
	 php5-gd && \
    sudo apt-get upgrade && \
    sudo apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Update the PHP.ini file, enable <? ?> tags and quieten logging.
#
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php5/apache2/php.ini

# Enable apache mods for PHP.
#
RUN a2enmod php5

# ======================
# END OF INSTALLING PHP5
# ======================

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
