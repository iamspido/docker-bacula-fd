#!/bin/bash

ENV_BACKUP_DIR="/mount/var/backups/mysql/"
ENV_MYSQL_USER="${ENV_MYSQL_USER}"
ENV_MYSQL=/usr/bin/mysql
ENV_MYSQL_PASSWORD="${ENV_MYSQL_PASSWORD}"
ENV_MYSQLDUMP=/usr/bin/mysqldump

databases=`$ENV_MYSQL --user=$ENV_MYSQL_USER -p$ENV_MYSQL_PASSWORD --protocol=socket -S /var/run/mysqld/mysqld.sock -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
  $ENV_MYSQLDUMP --force --opt --user=$ENV_MYSQL_USER -p$ENV_MYSQL_PASSWORD --quote-names --protocol=socket -S /var/run/mysqld/mysqld.sock --single-transaction --ignore-table=mysql.event --quick --max_allowed_packet=512M --databases $db | bzip2 > "$ENV_BACKUP_DIR/$db.bz2"
  if [ ! $PIPESTATUS -eq 0 ]; then
    failed=1
  fi
done
if [ "$failed" = "1" ]; then
  echo "Backup failed!"
  exit 1
fi
LEN=$(echo "$databases" | wc -l)
if (( $LEN > 1 )); then
  echo "All $LEN backups were successful."
else
  echo "$LEN backup was successful."
fi
