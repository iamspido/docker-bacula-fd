#!/bin/bash

BACKUP_DIR="/mount/var/backups/mysql/"
MYSQL_USER="${2:-root}"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="${1}"
MYSQLDUMP=/usr/bin/mysqldump

databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD --protocol=socket -S /var/run/mysqld/mysqld.sock -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
$MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --quote-names --single-transaction --ignore-table=mysql.event --quick --max_allowed_packet=512M --databases $db | bzip2 > "$BACKUP_DIR/$db.bz2"
done
