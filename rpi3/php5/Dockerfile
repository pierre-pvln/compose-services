# Import baseline image
#
FROM pvln/rpi3-lvl1-apache2:1.0

MAINTAINER Pierre Veelen <pierre@pvln.nl>

LABEL version="1.0" maintainer="Pierre Veelen <pierre@pvln.nl>"

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
