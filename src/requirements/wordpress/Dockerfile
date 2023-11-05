# FROM debian:buster

# RUN apt-get update && apt-get upgrade -y

# # Install PHP 7.3 and extensions
# RUN apt-get install -y \
#     curl \
#     php7.3 \
#     php7.3-fpm \
#     php7.3-opcache \
#     php7.3-mysql \
#     php7.3-curl \
#     php7.3-xml \
#     php7.3-gd \
#     php7.3-redis \
#     php7.3-ldap \
#     php7.3-json \
#     php7.3-imap \
#     php7.3-mbstring \
#     php7.3-zip

# # Copy your PHP-FPM configuration file (www.conf)
# COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

# # Install WP-CLI
# RUN curl -o /usr/local/bin/wp -fL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
#     chmod +x /usr/local/bin/wp; \
#     wp --allow-root --version

# # Create the directory for your web application
# RUN mkdir -p /var/www/html; \
#     chown -R www-data:www-data /var/www/html

# # Copy your Docker entrypoint script
# COPY docker-entrypoint.sh /usr/local/bin/

# WORKDIR /var/www/html

# ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]
# CMD [ "php-fpm7.3", "-F", "-R"]


FROM debian:buster

# Update and upgrade packages, and install PHP 7.4 and extensions
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    curl \
    php7.4 \
    php7.4-fpm \
    php7.4-opcache \
    php7.4-mysql \
    php7.4-curl \
    php7.4-xml \
    php7.4-gd \
    php7.4-redis \
    php7.4-ldap \
    php7.4-json \
    php7.4-imap \
    php7.4-mbstring \
    php7.4-zip

# Copy your PHP-FPM configuration file (www.conf)
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

# Install WP-CLI
RUN curl -o /usr/local/bin/wp -fL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x /usr/local/bin/wp; \
    wp --allow-root --version

# Create the directory for your web application
RUN mkdir -p /var/www/html; \
    chown -R www-data:www-data /var/www/html

# Install WordPress (you'll need to have the WordPress files available in your context)
# For example, if you have a 'wordpress' directory containing WordPress files, you can copy it like this:
# COPY wordpress /var/www/html

# Copy your Docker entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

WORKDIR /var/www/html

ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]
CMD [ "php-fpm7.4", "-F", "-R"]
