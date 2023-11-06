#!/bin/sh

# Start the MariaDB server
mysqld --console &

# Wait for MariaDB server to start (max 30 seconds)
echo "Waiting for MariaDB server to accept connections"
sleep 20
# timeout=30
# while ! mysqladmin ping -h localhost -u root -p"$MYSQL_ROOT_PASSWORD" &>/dev/null
# do
#     timeout=$(expr $timeout - 1)
#     echo "look here 1"
#     if [ $timeout -eq 0 ]; then
#         echo "Could not connect to MariaDB server. Aborting..."
#         exit 1
#     fi
#     sleep 1
# done

mysql -u root -p"$MYSQL_ROOT_PASSWORD" "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'mariadb' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"

mysql -e "FLUSH PRIVILEGES;"
mysql -e "DELETE FROM	mysql.user WHERE User='';"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test';"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
echo "look here 2"




# Flush privileges
mysql -e "FLUSH PRIVILEGES;"

# Stop the MariaDB server
# mysqladmin shutdown