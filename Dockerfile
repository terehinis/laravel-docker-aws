FROM php:7.2-fpm

RUN apt-get update

RUN apt-get update \
    && apt-get install -y libpq-dev git \
    zip unzip libzip-dev \
    supervisor cron \
    nginx wget vim bzip2 \
    gnupg2 apt-transport-https \
    libpng-dev libxml2 libxml2-dev npm

RUN docker-php-ext-install exif



RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg \ 
    | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" \ 
    | tee /etc/apt/sources.list.d/yarn.list | apt-get update && apt-get -y install yarn

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs && npm install npm -g

RUN docker-php-ext-install bcmath \
    && docker-php-ext-install pdo_mysql pcntl \
    && docker-php-ext-install zip mbstring gd xml

RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN apt-get update && apt-get install -y newrelic-php5



RUN mkdir -p /var/www/html
RUN mkdir -p /var/www/app
WORKDIR /var/www


RUN export COMPOSER_CACHE_DIR=/var/www/html/composer-cache/; \
    php -d zend.enable_gc=0

#RUN composer install --no-dev --no-interaction --no-scripts --optimize-autoloader

RUN apt install mc -y

ADD www.conf /usr/local/etc/php-fpm.d/www.conf
ADD php-newrelic.ini /usr/local/etc/php/conf.d/php-newrelic.ini

#SUPRVISOR
ADD supervisor/supervisord.conf /etc/supervisord.conf
ADD supervisor/*conf /etc/supervisor/conf.d/

ADD start.sh /var/www/start.sh
ENTRYPOINT /var/www/start.sh 




