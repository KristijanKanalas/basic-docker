FROM php:7.2-fpm-alpine

# setup base
RUN apk add imap-dev openldap-dev krb5-dev zlib-dev wget git fcgi libpng-dev sudo \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install pdo_mysql pdo imap zip ldap mysqli mbstring bcmath opcache gd \
    && apk add nodejs nodejs-npm \
    && apk add autoconf \
        g++ \
        make \
    && pecl install apcu && docker-php-ext-enable apcu \
#cleanup
    && apk del autoconf g++ wget make \
    && rm -rf /tmp/* /var/cache/apk/* \
# composer
    && cd /usr/bin/ && wget -O composer https://getcomposer.org/download/1.6.3/composer.phar && chmod +x /usr/bin/composer \
# fix log path
    && sed -i "s/error_log.*/error_log = \/var\/log\/php7\.2\-fpm\.error.log/g" /usr/local/etc/php-fpm.d/docker.conf \
    && sed -i "s/access.log.*/access.log = \/var\/log\/php7\.2\-fpm\.access.log/g" /usr/local/etc/php-fpm.d/docker.conf \
    && ln -sf /proc/1/fd/1 /var/log/php7.2-fpm.access.log \
    && ln -sf /proc/1/fd/2 /var/log/php7.2-fpm.error.log
# change to www-data user
RUN rm -rf /var/www/* && chown www-data.www-data -R /var/www

# setup php.ini overrides
COPY services/configs/php/ /usr/local/etc/php/conf.d/

# install nginx
USER root
RUN apk add nginx \
    && mkdir /run/nginx
COPY services/configs/nginx.conf /etc/nginx/conf.d/default.conf
RUN ln -sf /proc/1/fd/1 /var/log/nginx/access.log \
    && ln -sf /proc/1/fd/2 /var/log/nginx/error.log

# supervisor
RUN apk add supervisor
RUN mkdir /etc/supervisor.d
COPY services/configs/supervisor.conf /etc/supervisor.d/supervisor.ini
COPY services/configs/supervisor-nginx.conf  /etc/supervisor.d/supervisor-nginx.ini
COPY services/configs/supervisor-php.conf  /etc/supervisor.d/supervisor-php.ini

USER www-data
# install app
COPY --chown=www-data:www-data ./ /var/www
RUN cd /var/www && composer install && composer clearcache \
    && cat /dev/null > /var/www/.env

USER root

WORKDIR /var/www

ENTRYPOINT ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
