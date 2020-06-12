#!/usr/bin/env bash
docker tag bts/php:7.2 docker.pkg.github.com/backstage-technical-services/php-docker/php:7.2
docker push docker.pkg.github.com/backstage-technical-services/php-docker/php:7.2
