#!/usr/bin/env bash
docker tag bts/php:8.0 docker.pkg.github.com/backstage-technical-services/php-docker/php:8.0
docker push docker.pkg.github.com/backstage-technical-services/php-docker/php:8.0
