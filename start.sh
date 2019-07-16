#!/bin/bash

REMOTE_DIRECTOR_NAME=${REMOTE_DIRECTOR_NAME:-'backup-dir'}
REMOTE_DIRECTOR_PW=${REMOTE_DIRECTOR_NAME:-'PLS_CHANGE_ME'}
LOCAL_DIRECTOR_NAME=${LOCAL_DIRECTOR_NAME:-'backup-mon'}
LOCAL_DIRECTOR_PW=${LOCAL_DIRECTOR_PW:-'PLS_CHANGE_ME'}
LOCAL_FILE_NAME=${LOCAL_FILE_NAME:-'backup-fd'}
LOCAL_FILE_PORT=${LOCAL_FILE_PORT:-'9102'}
LOCAL_FILE_WD=${LOCAL_FILE_WD:-'/var/lib/bacula'}
LOCAL_FILE_PID=${LOCAL_FILE_PID:-'/var/run/bacula'}
LOCAL_FILE_FQDN=${LOCAL_FILE_FQDN:-'0.0.0.0'}
LOCAL_MESSAGES_NAME=${LOCAL_MESSAGES_NAME:-'Standard'}
LOCAL_MESSAGES_DIRECTOR=${LOCAL_MESSAGES_DIRECTOR:-'backup-dir = all, !skipped, !restored'}

cd /etc/bacula/
sed -i "s/{{remote_director_name}}/${REMOTE_DIRECTOR_NAME}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{remote_director_pw}}/${REMOTE_DIRECTOR_PW}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_director_name}}/${LOCAL_DIRECTOR_NAME}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_director_pw}}/${LOCAL_DIRECTOR_PW}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_file_name}}/${LOCAL_FILE_NAME}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_file_port}}/${LOCAL_FILE_PORT}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_file_wd}}/${LOCAL_FILE_WD}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_file_pid}}/${LOCAL_FILE_PID}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_file_fqdn}}/${LOCAL_FILE_FQDN}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_messages_name}}/${LOCAL_MESSAGES_NAME}/g" /etc/bacula/bacula-fd.conf
sed -i "s/{{local_messages_director}}/${LOCAL_MESSAGES_DIRECTOR}/g" /etc/bacula/bacula-fd.conf

exec "/usr/sbin/bacula-fd -f"
