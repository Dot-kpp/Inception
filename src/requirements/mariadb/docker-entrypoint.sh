#!/bin/sh
set -e

# mysqld_safe --console &

# service mysql start;
# service mysql start;
# mysqld -u mysql -p &

# Wait for the server to start
# while ! mysqladmin ping -hlocalhost --silent; do
#     sleep 1
# done

mysql -e "CREATE DATABASE IF NOT EXISTS wordpress_db;"
mysql -e "CREATE USER IF NOT EXISTS 'mysql'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'mysql'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' WITH GRANT OPTION;"
mysql -e "ALTER USER root@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
exec mysqld_safe
