FROM debian:buster

# Update and upgrade packages, and install PHP 7.3 and extensions
RUN apt-get update && apt-get upgrade -y && \
	curl \
	openssl \
	bash \
	mariadb-client \
	php8 \
	php8-fpm \
	php8-opcache \
	php8-mysqli \
	php8-session \
	php8-iconv \
	php8-json \
	php8-gd \
	php8-curl \
	php8-xml \
	php8-common \
	php8-imap \
	php8-cgi \
	php8-pdo \
	php8-pdo_mysql \
	php8-soap \
	php8-posix \
	php8-redis \
	php8-gettext \
	php8-ldap \
	php8-ctype \
	php8-dom \
	php8-phar \
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

ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]
CMD [ "php-fpm8", "-F", "-R"]
# ENTRYPOINT ["/usr/bin/dumb-init", "--"]
# CMD ["sh", "-c", "/usr/local/bin/docker-entrypoint.sh"]
