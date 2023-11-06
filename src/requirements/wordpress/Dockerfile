FROM debian:buster

# Update and upgrade packages, and install PHP 7.3 and extensions
RUN apt-get update && apt-get upgrade -y && \
    # apt-get install -y apt-utils &&\
    apt-get install -y \
    # mariadb-client \
    curl \
    php7.3 \
    php7.3-fpm \
    php7.3-opcache \
    php7.3-mysql \
    php7.3-curl \
    php7.3-xml \
    php7.3-gd \
    php7.3-redis \
    php7.3-ldap \
    php7.3-json \
    php7.3-imap \
    php7.3-mbstring \
    php7.3-zip \
    dumb-init 

# Copy your PHP-FPM configuration file (www.conf)
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

# Create necessary directories for PHP-FPM and set permissions
RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

# Install WP-CLI
RUN curl -o /usr/local/bin/wp -fL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x /usr/local/bin/wp; \
    wp --allow-root --version

# Create the directory for your web application
RUN set -ex; \
	mkdir -p /var/www/html; \
	chown -R www-data:www-data /var/www/html

# Copy your Docker entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html

# ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "-c", "/usr/local/bin/docker-entrypoint.sh && exec php-fpm7.3 -F -R"]
