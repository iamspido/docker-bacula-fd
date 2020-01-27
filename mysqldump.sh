#!/bin/bash

ENV_BACKUP_DIR="/mount/var/backups/mysql/"
ENV_MYSQL_USER="${ENV_MYSQL_USER}"
ENV_MYSQL=/usr/bin/mysql
ENV_MYSQL_PASSWORD="${ENV_MYSQL_PASSWORD}"
ENV_MYSQLDUMP=/usr/bin/mysqldump

databases=`$ENV_MYSQL --user=$ENV_MYSQL_USER -p$ENV_MYSQL_PASSWORD --protocol=socket -S /var/run/mysqld/mysqld.sock -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
$ENV_MYSQLDUMP --force --opt --user=$ENV_MYSQL_USER -p$ENV_MYSQL_PASSWORD --quote-names --protocol=socket -S /var/run/mysqld/mysqld.sock --single-transaction --ignore-table=mysql.event --quick --max_allowed_packet=512M --databases $db | bzip2 > "$ENV_BACKUP_DIR/$db.bz2"
done
