#!/usr/bin/env bash
docker tag bts/php:7.2 registry.gitlab.com/backstage-technical-services/website/php-docker:7.2
docker push registry.gitlab.com/backstage-technical-services/website/php-docker:7.2
