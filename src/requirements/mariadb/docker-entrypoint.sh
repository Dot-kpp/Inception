# #!/bin/bash

# set -e

# # Start the MariaDB server
# /usr/bin/mysqld_safe &

# # Wait for the MariaDB server to start
# until mysqladmin ping >/dev/null 2>&1; do
#   sleep 1
# done

# # Run your SQL commands
# mysql << EOF
# USE mysql;
# FLUSH PRIVILEGES;
# DELETE FROM mysql.user WHERE User='';
# DROP DATABASE IF EXISTS test;
# DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
# CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
# CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON *.* TO '%'@'%' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# EOF

# # Stop the MariaDB server
# killall mysqld

# # Wait for the MariaDB server to stop
# until ! mysqladmin ping >/dev/null 2>&1; do
#   sleep 1
# done

# exec "$@"



# #!/bin/bash

# set -e

# # Start the MariaDB server
# /usr/bin/mysqld_safe &

# # Wait for the MariaDB server to start
# until mysqladmin ping >/dev/null 2>&1; do
#   sleep 1
# done

# # Run your SQL commands
# mysql << EOF
# USE mysql;
# FLUSH PRIVILEGES;
# DELETE FROM mysql.user WHERE User='';
# DROP DATABASE IF EXISTS test;
# DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
# CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
# CREATE USER IF NOT EXISTS '$MYSQL_USER1'@'%' IDENTIFIED BY '$MYSQL_PASSWORD1';
# GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER1'@'%';
# CREATE USER IF NOT EXISTS '$MYSQL_USER2'@'%' IDENTIFIED BY '$MYSQL_PASSWORD2';
# GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER2'@'%' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# EOF

# # Stop the MariaDB server
# killall mysqld

# # Wait for the MariaDB server to stop
# until ! mysqladmin ping >/dev/null 2>&1; do
#   sleep 1
# done

# exec "$@"







#!/bin/sh

# Start the MariaDB server
mysqld_safe &

# Wait for MariaDB server to start (max 30 seconds)
sleep 10
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

# Create the WordPress database
mysql -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB};"

# Create the first user
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER1}'@'%' IDENTIFIED BY '${DB_USERPASS1}';"
mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'inception_backend' IDENTIFIED BY '${DB_USERPASS1}';"
mysql -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB}.* TO '${DB_USER1}'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB}.* TO 'wordpress'@'inception_backend';"

# Create the second user (administrator)
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER2}'@'%' IDENTIFIED BY '${DB_USERPASS2}';"
mysql -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB}.* TO '${DB_USER2}'@'%' WITH GRANT OPTION;"

# Flush privileges
mysql -e "FLUSH PRIVILEGES;"

# Stop the MariaDB server
# mysqladmin shutdown