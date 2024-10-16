FROM php:8.4.0RC2-fpm-alpine

ENV PHPGROUP=laravel
ENV PHPUSER=laravel

RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}
RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf
RUN mkdir -p /var/www/html/public
RUN apk add --no-cache postgresql-dev
RUN docker-php-ext-install pdo pdo_pgsql

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.d/www.conf", "-R"]
