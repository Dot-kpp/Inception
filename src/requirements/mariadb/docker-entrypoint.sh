#!/bin/sh

# Start the MariaDB server

# Wait for MariaDB server to start (max 30 seconds)
timeout=30
while ! mysqladmin ping -h localhost --silent; do
    timeout=$(expr $timeout - 1)
    if [ $timeout -eq 0 ]; then
        echo "Could not connect to MariaDB server. Aborting..."
        exit 1
    fi
    sleep 1
done


# Wait for MariaDB server to start (max 30 seconds)
echo "Waiting for MariaDB server to accept connections"
sleep 5

mysql -e "FLUSH PRIVILEGES;"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test';"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"

# Flush privileges
mysql -e "FLUSH PRIVILEGES;"

# Stop the MariaDB server
# mysqladmin shutdown


# if [ -f ".a" ]; then
# 	echo "DB is already set up"
# else
# 	echo "Setting up the DB"
# 	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# 	mysqld --user=mysql --datadir=/var/lib/mysql &
# 	sleep 5

# 	mysql -e "create database if not exists ${MYSQL_DATABASE};"
# 	echo "DB is created"

# 	mysql -e "create user if not exists '${MYSQL_USER}'@'localhost' identified by '${MYSQL_PASSWORD}';"
# 	echo "User ${MYSQL_USER} created"

# 	mysql -e "grant all privileges on \`${MYSQL_DATABASE}\`.* to \`${MYSQL_USER}\`@'%' identified by '${MYSQL_PASSWORD}';"
# 	echo "Privileges have been granted"

# 	mysql -e "alter user 'root'@'localhost' identified by '${MYSQL_ROOT_PASSWORD}';"
# 	echo "Root password is now set"

# 	mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "flush privileges;"
# 	echo "Privileges have been flushed"

# 	touch ".a"
# 	pkill mysqld

# fi