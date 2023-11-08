#!/bin/sh
set -e

# mysqld_safe --console &

service mysql start;
mysqld --user=mysql &

# Wait for the server to start
while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
exec mysqld_safe



#!/bin/bash
set -e

# Start the database server
mysqld --user=mysql &

# Wait for the server to start
while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

# Run the init.sql script
mysql -hlocalhost -uroot -p"$MYSQL_ROOT_PASSWORD" < /path/to/init.sql

# Stop the database server
mysqladmin -hlocalhost -uroot -p"$MYSQL_ROOT_PASSWORD" shutdown

# Start the database server again
mysqld --user=mysql
