FROM ubuntu:latest

RUN apt update
RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y install \
    apache2 \
    php \
    php-mysql \
    libapache2-mod-php \
    php-xml \
    php-mbstring \
    php-apcu \
    php-intl \
    imagemagick \
    inkscape \
    php-gd \
    php-cli \
    php-curl \
    php-bcmath \
    git

COPY src /var/lib/mediawiki
COPY LocalSettings.php /var/lib/mediawiki/LocalSettings.php

RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php/8.1/apache2/php.ini
RUN ln -s /var/lib/mediawiki /var/www/html/mediawiki

EXPOSE 80
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]