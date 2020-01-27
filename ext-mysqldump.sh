#!/bin/bash

ENV_BACKUP_DIR="${ENV_BACKUP_DIR}"
ENV_MYSQL_USER="${ENV_MYSQL_USER}"
ENV_MYSQL=/usr/bin/mysql
ENV_MYSQL_PASSWORD="${ENV_MYSQL_PASSWORD}"
ENV_MYSQLDUMP=/usr/bin/mysqldump
ENV_MYSQL_HOST="${ENV_MYSQL_HOST}"
ENV_MYSQL_PORT="${ENV_MYSQL_PORT}"

databases=`${ENV_MYSQL} --user=${ENV_MYSQL_USER} -p${ENV_MYSQL_PASSWORD} --host=${ENV_MYSQL_HOST} --port=${ENV_MYSQL_PORT} -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
	if [[ ! $db = "mysql" && ! $db = "sys" ]]; then
		${ENV_MYSQLDUMP} --force --opt --user=${ENV_MYSQL_USER} -p${ENV_MYSQL_PASSWORD} --quote-names --host=${ENV_MYSQL_HOST} \
		--port=${ENV_MYSQL_PORT} --single-transaction --ignore-table=mysql.event --quick --max_allowed_packet=512M --databases $db \
		| bzip2 > "${ENV_BACKUP_DIR}/$db.bz2"
	fi
done
