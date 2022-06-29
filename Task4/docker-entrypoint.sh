#!/bin/bash
set -e
defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
envsubst "$defined_envs" < /etc/nginx/tempalates/site_template.tpl > /var/www/hello/index.html
envsubst "$defined_envs" < /etc/nginx/tempalates/hello.conf.tpl > /etc/nginx/conf.d/hello.conf  
exec "$@"