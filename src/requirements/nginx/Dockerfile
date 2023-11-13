FROM debian:buster

# Update and install required packages in a single RUN command
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

# Create necessary directories
RUN mkdir -p /var/www/html /etc/nginx/ssl /run/nginx

# Copy your Nginx configuration
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 443

# Generate an SSL certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/sslcert.crt -keyout /etc/nginx/ssl/sslcert.key -subj "/C=CA/ST=Quebec/L=Quebec City/O=42School/OU=42Quebec/CN=jpilotte.42.fr"

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
