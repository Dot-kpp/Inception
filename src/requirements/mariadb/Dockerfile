FROM debian:buster

# Update and upgrade packages, and install MariaDB server and client
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    apt-get install -y dumb-init && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your custom MariaDB configuration
COPY conf/my.cnf /etc/mysql/my.cnf

# Create necessary directories and initialize MariaDB
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    mysql_install_db --basedir=/usr --user=mysql --datadir=/var/lib/mysql 

# Copy your custom entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Define the command to run MariaDB (not the entrypoint script)
ENTRYPOINT ["docker-entrypoint.sh"]

# Loads mysqld as PID 1
CMD ["mysqld"]
