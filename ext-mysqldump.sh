#!/bin/bash

BACKUP_DIR="${BACKUP_DIR}"
MYSQL_USER="${MYSQL_USER}"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="${MYSQL_PASSWORD}"
MYSQLDUMP=/usr/bin/mysqldump
MYSQL_HOST="${MYSQL_HOST}"
MYSQL_PORT="${MYSQL_PORT}"

databases=`${MYSQL} --user=${MYSQL_USER} -p${MYSQL_PASSWORD} --host=${MYSQL_HOST} --port=${MYSQL_PORT} -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
	if [ ! [ $db = "mysql" && $db = "sys" ]]; then
		${MYSQLDUMP} --force --opt --user=${MYSQL_USER} -p${MYSQL_PASSWORD} --quote-names --host=${MYSQL_HOST} \
		--port=${MYSQL_PORT} --single-transaction --ignore-table=mysql.event --quick --max_allowed_packet=512M --databases $db \
		| bzip2 > "${BACKUP_DIR}/$db.bz2"
	fi
done
