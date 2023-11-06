until mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" &> /dev/null; do
    echo "MariaDB is unavailable - sleeping"
    sleep 5
done


if [ ! -f /tmp/done_config ]; then
	touch /tmp/done_config

	mkdir -p /var/www/html
    chmod 777 /var/www/html


	wp core download --path="/var/www/html" --allow-root
    wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOST" --dbcharset="utf8mb4" \
		--dbcollate="utf8mb4_general_ci" --path="/var/www/html" --allow-root
    wp core install --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN" --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" --skip-email --allow-root
	echo "Configuring Wordpress!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    wp user create "$WORDPRESS_USER" "$WORDPRESS_EMAIL" --role=author \
		--user_pass="$WORDPRESS_PASSWORD" --allow-root
fi

exec "$@"