# ==========================================
# Raspberry Pi 3 MySQL 5.5 Dockerfile
# ==========================================

#
# Cleaned Dockerfile
# Optimized to only apt-date and clean only once
#

# Import baseline image
#
FROM pvln/rpi3-lvl1-baseline:1.0

MAINTAINER Pierre Veelen <pierre@pvln.nl>

LABEL version="1.0" maintainer="Pierre Veelen <pierre@pvln.nl>"

# ==========================================
# START OF INSTALLING APACHE2
# ==========================================
#
# Inspiration: https://writing.pupius.co.uk/apache-and-php-on-docker-44faef716150
#              https://github.com/jacksoncage/apache-docker
#

# Install apache2 and cleanup afterwards
#

# Important to update the packages list befor installing since they are removed after the install
RUN sudo apt-get update && \
    sudo apt-get upgrade && \
    sudo apt-get install -y \
    apache2 

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

# ========================================== 
#
#
# TODO CHANGE WEBSITE SERVERNAME TO PREVENT WARNING
#
# ==========================================

# ==========================================
# END OF INSTALLING APACHE2
# ==========================================

# ==========================================
# START OF INSTALLING PHP5
# ==========================================

# Install php5 and cleanup afterwards
#
RUN sudo apt-get install -y \
	 libapache2-mod-php5 \
	 php5 \
	 php-pear \
	 php5-xcache \
	 php5-mysql \
	 php5-curl \
	 php5-gd && \
   sudo apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Update the PHP.ini file, enable <? ?> tags and quieten logging.
#
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php5/apache2/php.ini

# Enable apache mods for PHP.
#
RUN a2enmod php5

# ==========================================
# END OF INSTALLING PHP5
# ==========================================

# ==========================================
# START OF INSTALLING MYSQL
# ==========================================

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# https://manpages.debian.org/jessie/passwd/groupadd.8.en.html
# https://manpages.debian.org/jessie/passwd/useradd.8.en.html
# 
# raspberry pi uses system groups 999(spi), 998(i2c), 997(gpio)
# http://www.arne.jachens.de/RaspberryPi#SPIBus
# and therefore gid is set to 995.
#
RUN groupadd --system --gid 995 mysql \ 
    && useradd --system --uid 995 -g mysql mysql

RUN apt-get update && apt-get install -y perl --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV MYSQL_VERSION 5.5

# the "/var/lib/mysql" stuff here is because the mysql-server postinst doesn't have an explicit way to disable 
# the mysql_install_db codepath besides having a database already "configured" (ie, stuff in /var/lib/mysql/mysql)
# also, we set debconf keys to make APT a little quieter
RUN { \
		echo mysql-server mysql-server/data-dir select ''; \
		echo mysql-server mysql-server/root-pass password ''; \
		echo mysql-server mysql-server/re-root-pass password ''; \
		echo mysql-server mysql-server/remove-test-db select false; \
	} | debconf-set-selections \
	&& apt-get update && apt-get install -y mysql-server="${MYSQL_VERSION}"* && rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# comment out a few problematic configuration values
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf

# ==========================================
# END OF INSTALLING MYSQL
# ==========================================

# ==========================================
# START OF PORTS AND VOLUMES
# ==========================================

# Expose apache2 on port 80 of the container
#
EXPOSE 80

# Expose mysql on port 3306 of the container
#
EXPOSE 3306

# Mountable datafolder path(s) within the container
#
# A key point to be aware of here is that anything after the VOLUME instruction
# in a Dockerfile will not be able to make changes to that volume
#

# Volumes for apache2
#
VOLUME /var/www/html
VOLUME /var/log/apache2

# Volume for MySQL
#
VOLUME /var/lib/mysql

# ==========================================
# END OF PORTS AND VOLUMES
# ==========================================

# ==========================================
# ENTRYPOINT & CMD
# ==========================================

#
# Inspiration: http://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/
#
# Prefer ENTRYPOINT to CMD when building executable Docker image and you need a command always to be executed.
# Additionally use CMD if you need to provide extra default arguments that could be overwritten from command line when docker container runs.
# Choose CMD if you need to provide a default command and/or arguments that can be overwritten from command line when docker container runs.
#

# Cancel pre-defined start-up instruction and allow us to use our own.
#
ENTRYPOINT []

ADD ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/bin/bash","entrypoint.sh"]

CMD ["mysqld"]
