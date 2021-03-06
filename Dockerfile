FROM php:8.0-fpm-alpine

# Install dependencies
RUN apk update && apk upgrade && apk add --update \
    zip \
    unzip \
    bash \
    curl \
    procps \
    git \
    vim \
    zlib-dev \
    jpeg-dev \
    libpng-dev \
    libzip-dev \
    oniguruma-dev \
    nginx \
    nodejs \
    npm \
    mysql-client \
    httpie

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install yarn
RUN npm install -g yarn

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl gd

# Set the working directory to /var/www
RUN mkdir -p /var/www
RUN mkdir -p /run/nginx
WORKDIR /var/www

# Clear any existing config
RUN rm /etc/nginx/conf.d/*
RUN rm /usr/local/etc/php-fpm.d/*.conf

# Copy over the config
COPY php/php.ini /usr/local/etc/php/php.ini
COPY php/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY php/php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/server.conf /etc/nginx/conf.d/server.conf

# Copy over the entrypoint
COPY bin/start.sh /usr/bin/start
RUN chmod +x /usr/bin/start

STOPSIGNAL SIGTERM
EXPOSE 8080
CMD ["start"]
