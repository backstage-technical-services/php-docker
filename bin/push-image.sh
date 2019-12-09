#!/usr/bin/env bash
docker tag bts/php:7.4 registry.gitlab.com/backstage-technical-services/infra/php:7.4
docker push registry.gitlab.com/backstage-technical-services/infra/php:7.4