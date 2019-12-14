FROM nginx:latest

LABEL maintainer="Noé Viricel <noe.viricel@wazo-lab.io>"
LABEL description="Custom NGINX Server"

COPY nginx.conf /etc/nginx/
RUN mkdir -p /home/www
COPY ./src/ /home/www/