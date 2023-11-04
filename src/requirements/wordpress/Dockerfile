FROM debian:buster

RUN apt-get update && apt-get upgrade -y

# Add the repository for PHP 8.0
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php

# Update the package list after adding the repository
RUN apt-get update

# Install PHP 8.0 and its extensions
RUN apt-get install -y \
    php8.0 \
    php8.0-fpm \
    php8.0-opcache \
    php8.0-mysql \
    php8.0-curl \
    php8.0-xml \
    php8.0-gd \
    php8.0-redis \
    php8.0-ldap \
    php8.0-json \
    php8.0-imap \
    php8.0-mbstring \
    php8.0-zip

COPY conf/www.conf /etc/php8/php-fpm.d/

RUN curl -o /usr/local/bin/wp -fL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x /usr/local/bin/wp; \
	wp --allow-root --version

RUN set -ex; \
	mkdir -p /var/www/html; \
	chown -R www-data:www-data /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
WORKDIR /var/www/html
ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]

CMD [ "php-fpm8", "-F", "-R"]

# RUN apt-get install wget -y

# RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

# RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# RUN chown -R root:root /var/www/wordpress
