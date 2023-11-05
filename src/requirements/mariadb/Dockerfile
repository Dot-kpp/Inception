FROM debian:buster

# Update and upgrade packages, and install MariaDB server and client
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    apt-get install -y mariadb-client

# Copy your custom MariaDB configuration
COPY conf/my.cnf /etc/mysql/my.cnf

# Create necessary directories and initialize MariaDB
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    mysql_install_db --basedir=/usr --user=mysql --datadir=/var/lib/mysql

# Copy your custom entrypoint script
COPY docker-entrypoint.sh /tmp/docker-entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /tmp/docker-entrypoint.sh

# Define the command to run MariaDB (not the entrypoint script)
CMD ["mysqld"]

