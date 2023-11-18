# FROM debian:buster

# # Update and install required packages in a single RUN command
# RUN apt-get update && apt-get upgrade -y && \
#     apt-get install -y nginx  && \
#     apt-get install -y openssl

# # Create necessary directories
# RUN mkdir -p /var/www/html /etc/nginx/ssl /var/run/nginx

# # Copy your Nginx configuration
# COPY conf/nginx.conf /etc/nginx/http.d/default.conf

# EXPOSE 443

# # Generate an SSL certificate
# RUN openssl req -newkey rsa:4096 -sha256 -x509 -nodes -days 365 -out /etc/nginx/ssl/sslcert.crt -keyout /etc/nginx/ssl/sslcert.key -subj "/C=CA/ST=Quebec/L=Quebec City/O=42School/OU=42Quebec/CN=jpilotte.42.fr"

# # Start Nginx in the foreground
# CMD ["nginx", "-g", "daemon off;"]



FROM debian:buster


RUN apt -y update && apt install -y nginx && apt install openssl -y




COPY ./conf/default /etc/nginx/sites-available/

COPY ./tools/execute.sh /


CMD [ "/execute.sh" ]