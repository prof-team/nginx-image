#!/bin/bash
set -e

if [ -n "$WORKER_PROCESSES" ]; then
    sed -i "s/worker_processes.*/worker_processes $WORKER_PROCESSES;/" /etc/nginx/nginx.conf
fi
if [ -n "$WORKER_CONNECTIONS" ]; then
    sed -i "s/worker_connections.*/worker_connections $WORKER_CONNECTIONS;/" /etc/nginx/nginx.conf
fi
if [ -n "$CLIENT_MAX_BODY_SIZE" ]; then
    sed -i "s/client_max_body_size.*/client_max_body_size $CLIENT_MAX_BODY_SIZE;/" /etc/nginx/nginx.conf
fi
if [ -n "$FASTCGI_PASS" ]; then
    sed -i "s/fastcgi_pass .*/fastcgi_pass $FASTCGI_PASS;/" /etc/nginx/php-fpm.conf
    sed -i "s/fastcgi_pass .*/fastcgi_pass $FASTCGI_PASS;/" /etc/nginx/php-fpm-index.conf
fi
if [ -n "$FASTCGI_CONNECT_TIMEOUT" ]; then
    sed -i "s/fastcgi_connect_timeout.*/fastcgi_connect_timeout $FASTCGI_CONNECT_TIMEOUT;/" /etc/nginx/php-fpm.conf
    sed -i "s/fastcgi_connect_timeout.*/fastcgi_connect_timeout $FASTCGI_CONNECT_TIMEOUT;/" /etc/nginx/php-fpm-index.conf
fi
if [ -n "$FASTCGI_READ_TIMEOUT" ]; then
    sed -i "s/fastcgi_read_timeout.*/fastcgi_read_timeout $FASTCGI_READ_TIMEOUT;/" /etc/nginx/php-fpm.conf
    sed -i "s/fastcgi_read_timeout.*/fastcgi_read_timeout $FASTCGI_READ_TIMEOUT;/" /etc/nginx/php-fpm-index.conf
fi
if [ -n "$FASTCGI_SEND_TIMEOUT" ]; then
    sed -i "s/fastcgi_send_timeout.*/fastcgi_send_timeout $FASTCGI_SEND_TIMEOUT;/" /etc/nginx/php-fpm.conf
    sed -i "s/fastcgi_send_timeout.*/fastcgi_send_timeout $FASTCGI_SEND_TIMEOUT;/" /etc/nginx/php-fpm-index.conf
fi
if [ -n "$GZIP_STATUS" ]; then
    sed -i "s/gzip .*/gzip $GZIP_STATUS;/" /etc/nginx/conf.d/gzip.conf
    sed -i "s/gzip_vary .*/gzip_vary $GZIP_STATUS;/" /etc/nginx/conf.d/gzip.conf
fi

if [ -n "$ENABLE_GEOIP_MODULE" ] && [ "$ENABLE_GEOIP_MODULE" -eq 1 ]; then
    sed -i "s/#GEOIP_MODULE.*/load_module \"modules\/ngx_http_geoip_module.so\";/" /etc/nginx/nginx.conf
fi

exec "$@"