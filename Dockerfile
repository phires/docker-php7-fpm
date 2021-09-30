FROM php:7-fpm
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    libmcrypt-dev \
    libxslt-dev \
    libmagickwand-dev \
    && pecl install apcu imagick \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) xsl pdo_mysql gettext bcmath gd zip mbstring exif pcntl \
    && docker-php-ext-enable apcu imagick \
    && pecl clear-cache \
    && docker-php-source delete \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/