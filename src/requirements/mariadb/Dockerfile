FROM debian:buster

# Update and upgrade packages, and install MariaDB server and client
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    apt-get install -y mariadb-client && \
    apt-get install -y dumb-init 
# Copy your custom MariaDB configuration
RUN rm -rf /etc/my.cnf
COPY conf/my.cnf /etc/my.cnf

# Create necessary directories and initialize MariaDB
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    mysql_install_db --basedir=/usr --user=$MYSQL_USER --datadir=/var/lib/mysql 

# Copy your custom entrypoint script
COPY docker-entrypoint.sh /tmp/docker-entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /tmp/docker-entrypoint.sh

# Define the command to run MariaDB (not the entrypoint script)
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "-c", "/tmp/docker-entrypoint.sh"]


# ENTRYPOINT [ "sh", "/tmp/docker-entrypoint.sh" ]

# # Loads mysqld as PID 1
# CMD [ "mysqld_safe --console" ]