#!/bin/bash
# ==========================================
# Raspberry Pi 3 Voluntas entrypoint.sh 
# ==========================================

# This script is started (in the container) when the container is started
#

# default message
echo "Running Raspberry Pi 3 Voluntas entrypoint.sh"
echo "============================================="
sudo apache2 -v
echo "============================================="
sudo mysql -v
echo "============================================="

#   help set
#   -e  Exit immediately if a command exits with a non-zero status.
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- mysqld "$@"
fi

if [ "$1" = 'mysqld' ]; then
	# read DATADIR from the MySQL config
	DATADIR="$("$@" --verbose --help 2>/dev/null | awk '$1 == "datadir" { print $2; exit }')"

	if [ ! -d "$DATADIR/mysql" ]; then
		if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
			echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
			echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
			exit 1
		fi

		echo 'Initializing database'
                mysql_install_db --datadir="$DATADIR"
		echo 'Database initialized'

		# These statements _must_ be on individual lines, and _must_ end with
		# semicolons (no line breaks or comments are permitted).
		# TODO proper SQL escaping on ALL the things D:

		tempSqlFile='/tmp/mysql-first-time.sql'
		cat > "$tempSqlFile" <<-EOSQL
			DELETE FROM mysql.user ;
			CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
			GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
			DROP DATABASE IF EXISTS test ;
		EOSQL

		if [ "$MYSQL_DATABASE" ]; then
			echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" >> "$tempSqlFile"
		fi

		if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
			echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> "$tempSqlFile"

			if [ "$MYSQL_DATABASE" ]; then
				echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" >> "$tempSqlFile"
			fi
		fi

		echo 'FLUSH PRIVILEGES ;' >> "$tempSqlFile"

		set -- "$@" --init-file="$tempSqlFile"
	fi

	chown -R mysql:mysql "$DATADIR"
fi

# Start apache 2 server
#
#
/usr/sbin/apachectl -k start
#
# Do not start apache2 in foreground mode. Script then waits  
#/usr/sbin/apachectl -D FOREGROUND
#
#
exec "$@"
#
