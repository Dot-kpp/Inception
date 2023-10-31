FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt-get install mariadb mariadb-client -y

RUN rm -rf /etc/inception.cnf

COPY config/my.cnf /etc/my.cnf

RUN mkdir -p /run/mysqld; \
	chown -R mysql:mysql /run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql; \
	mysql_install_db --basedir=/usr --user=$MYSQL_USER --datadir=/var/lib/mysql

COPY docker-entrypoint.sh /tmp/docker-entrypoint.sh

ENTRYPOINT [ "sh", "/tmp/docker-entrypoint.sh" ]

CMD [ "mysqld" ]
