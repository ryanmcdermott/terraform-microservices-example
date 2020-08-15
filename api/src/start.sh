#!/usr/bin/env bash

cp /usr/local/api/config/nginx.conf /etc/nginx/sites-enabled/
cp /usr/local/api/config/supervisor.conf /etc/supervisor/conf.d/
supervisord -n -c /usr/local/api/config/supervisor.conf