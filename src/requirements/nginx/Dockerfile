FROM debian:buster

RUN apt-get update && apt-get install -y nginx

RUN mkdir -p /var/www/html /etc/nginx/ssl /run/nginx

COPY ./nginx.conf /etc/nginx/nginx.conf


RUN mkdir -p /etc/nginx/ssl
