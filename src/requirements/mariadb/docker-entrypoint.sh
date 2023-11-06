#!/bin/bash

set -e

# Start the MariaDB server
/usr/bin/mysqld_safe &

# Wait for the MariaDB server to start
until mysqladmin ping >/dev/null 2>&1; do
  sleep 1
done

# Run your SQL commands
mysql << EOF
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'trusted_host' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'trusted_host' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Stop the MariaDB server
killall mysqld

# Wait for the MariaDB server to stop
until ! mysqladmin ping >/dev/null 2>&1; do
  sleep 1
done

exec "$@"