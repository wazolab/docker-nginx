FROM debian:buster-slim
LABEL maintainer="Noé Viricel <noe.viricel@wazo-lab.io>"
LABEL description="Custom NGINX Server"

ENV NGINX_VERSION   1.17.6
ENV NJS_VERSION     0.3.3
ENV PKG_RELEASE     1~buster

RUN apt-get update \
    && apt-get install -y curl build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev \
    && apt-get clean

RUN cd /usr/local/lib && curl -L https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar zx \
    && cd nginx-${NGINX_VERSION}/ \
    && ./configure --prefix=/etc/nginx --sbin-path=/usr/bin/nginx \
    --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log \
    --with-pcre --pid-path=/var/run/nginx.pid \
    --with-http_ssl_module --modules-path=/etc/nginx/modules \
    --with-http_v2_module \
    && make \
    && make install

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx/ /etc/nginx
COPY src/ /var/www/html

VOLUME /etc/nginx

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
