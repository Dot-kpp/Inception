#!/bin/bash


mkdir -p /etc/nginx/ssl

chmod 777 /etc/nginx/ssl

openssl req -newkey rsa:4096 -sha256 -x509 -nodes -days 365 -out /etc/nginx/ssl/sslcert.crt -keyout /etc/nginx/ssl/sslcert.key -subj "/C=CA/ST=Quebec/L=Quebec City/O=42School/OU=42Quebec/CN=jpilotte.42.fr"


echo "
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    #server_name www.$DOMAIN_NAME $DOMAIN_NAME;

    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" > /etc/nginx/sites-available/default


echo '
    ssl_protocols TLSv1.3;

    index index.php;
    root /var/www/html;

    location ~ [^/]\.php(/|$) { 
            try_files $uri =404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
} ' >>  /etc/nginx/sites-available/default


nginx -g "daemon off;"