#! /bin/bash
envsubst < $SERVER_HOME/config/nginx.conf.tmpl > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'