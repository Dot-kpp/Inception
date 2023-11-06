#!/bin/sh

# Start the MariaDB server
mysqld_safe &

# Wait for MariaDB server to start (max 30 seconds)
echo "Waiting for MariaDB server to accept connections"
sleep 6
timeout=30
while ! mysqladmin ping &>/dev/null
do
    timeout=$(expr $timeout - 1)
    if [ $timeout -eq 0 ]; then
        echo "Could not connect to MariaDB server. Aborting..."
        exit 1
    fi
    sleep 1
done

mysql -e "FLUSH PRIVILEGES;"
mysql -e "DELETE FROM	mysql.user WHERE User='';"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test';"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"



# Flush privileges
mysql -e "FLUSH PRIVILEGES;"

# Stop the MariaDB server
# mysqladmin shutdown