FROM php:7.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Set the console output
ENV LOG_STREAM /tmp/stdout
RUN mkfifo ${LOG_STREAM} && chmod a+rwx ${LOG_STREAM}

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash \
      && apt-get update \
      && apt-get install -y nodejs

# Install yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get update && apt-get install yarn

# Clear cache
RUN apt-get -y autoremove \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install yarn
RUN npm install -g yarn

# Set the working directory to /var/www
RUN mkdir -p /var/www
WORKDIR /var/www

# Copy over the binary to run PHP
COPY bin/docker-php.sh /usr/bin/docker-php

# Copy over the config
COPY conf/php.ini /usr/local/etc/php/conf.d/zz-php.ini
COPY conf/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY conf/php-fpm-pool.conf /usr/local/etc/php-fpm.d/zz-pool.conf

EXPOSE 9000
CMD ["docker-php"]
