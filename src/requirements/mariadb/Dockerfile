FROM debian:buster

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y

# Install MariaDB server
RUN apt-get install -y mariadb
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client

# Remove the existing MariaDB configuration (if needed)
RUN rm -f /etc/mysql/my.cnf

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

# Define the command to run MariaDB
CMD [ "mysqld" ]
