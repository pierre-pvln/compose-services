#!/bin/bash

# file:    entrypoint.sh
# version: 2018-06-12
#
# usage:   this script is started (in the container) when the container is started
#

# Start Apache2
#
echo "Running entrypoint.sh" 
/usr/sbin/apache2ctl -D FOREGROUND





# Start MYSQL
# inspiration https://stackoverflow.com/questions/9083408/fatal-error-cant-open-and-lock-privilege-tables-table-mysql-host-doesnt-ex
#

####chown -R mysql /var/lib/mysql
####chgrp -R mysql /var/lib/mysql
####service mysql start

# Create Joomla! entries and tables in MySQL database
#
####/usr/bin/mysql -uroot -proot --execute="create database joomla_db;
####    grant all on joomla_db.* to joomla@'localhost' identified by 'joomla';
####   grant all on joomla_db.* to joomla@'%' identified by 'joomla'; 
####    flush privileges;"
