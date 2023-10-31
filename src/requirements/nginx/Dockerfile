FROM debian:buster

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install nginx -y

RUN apt install vim -y

RUN apt install curl -y

RUN mkdir -p /etc/nginx/ssl

RUN apt install OpenSSL -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Quebec/O=42/OU=42/CN=login.42.fr/UID=jpilotte"

RUN mkdir -p /var/www/html /etc/nginx/ssl /run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf


