#!/usr/bin/env bash

cp /usr/local/api_service/config/nginx.conf /etc/nginx/sites-enabled/
cp /usr/local/api_service/config/supervisor.conf /etc/supervisor/conf.d/
supervisord -n -c /usr/local/api_service/config/supervisor.conf