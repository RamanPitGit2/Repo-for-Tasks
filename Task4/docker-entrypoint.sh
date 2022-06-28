#!/bin/bash
set -e
defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
envsubst "$defined_envs" < /etc/nginx/site_template.tpl > /var/www/hello/index.html
exec "$@"