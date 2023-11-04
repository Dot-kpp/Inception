# FROM debian:buster

# RUN apt-get update && apt-get upgrade -y 

# RUN apt-get install nginx -y

# RUN apt install vim -y

# RUN apt install curl -y

# RUN mkdir -p /etc/nginx/ssl

# RUN apt install openssl -y

# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Quebec/O=42/OU=42/CN=login.42.fr/UID=jpilotte"

# RUN mkdir -p /var/www/html /etc/nginx/ssl /run/nginx

# COPY conf/nginx.conf /etc/nginx/nginx.conf

# RUN chmod 755 /var/www/html

# RUN chown -R www-data:www-data /var/www/html

# # CMD [ "nginx", "-g", "daemon off;" ]

FROM debian:buster

RUN apt-get update && apt-get install nginx openssl

RUN mkdir -p /var/www/html /etc/nginx/ssl /run/nginx

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

# nginx ssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/sslcert.crt \
        -keyout /etc/nginx/ssl/sslcert.key \
        -subj "/C=CA/ST=Quebec/L=Quebec City/O=42School/OU=42Quebec/CN=jpilotte.42.fr"

# start nginx
CMD [ "nginx", "-g", "daemon off;" ]