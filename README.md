# PHP Docker

This repository creates Docker images that can be used to run PHP Laravel applications, using nginx and supervisord:

- Nginx is configured to listen on port 8080, for both IPv4 and IPv6, and serves files in the `/var/www/public`
  directory. PHP files are automatically passed onto PHP-FPM using FastGGI.

- PHP-FPM is configured to listen on port 9000, and only accepts local connections (ie, you can't connect to PHP-FPM
  from outside the container). It runs as user `www-data`.

- Supervisord is used to run both nginx and php-fpm in daemonless mode. You can interact with nginx and php-fpm
  using `supervisorctl`.
