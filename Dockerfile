FROM richarvey/nginx-php-fpm:latest

LABEL maintainer="Noé Viricel <noe.viricel@wazo-lab.io>"
LABEL description="Custom NGINX Server"

COPY nginx.conf /etc/nginx/
COPY ./src/ /var/www/html