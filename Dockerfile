FROM richarvey/nginx-php-fpm:latest

LABEL maintainer="Noé Viricel <noe.viricel@wazo-lab.io>"
LABEL description="Custom NGINX Server"

COPY nginx/ /etc/nginx
COPY src/ /var/www/html

VOLUME /etc/nginx

EXPOSE 80 443