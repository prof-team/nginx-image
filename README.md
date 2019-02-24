# docker nginx with logrotate

1. Pull image from [docker hub](https://hub.docker.com/r/profteam/nginx)

`docker pull profteam/nginx`

2. Now you can run image

`docker run -it profteam/nginx sh`

## Example docker-compose.yml for nginx
```
version: '3'

services:
  nginx:
    container_name: nginx
    image: grischuksasha/nginx
    environment:
      WORKER_PROCESSES: 1 # default value 2
      WORKER_CONNECTIONS: 768 # default value 1024
      CLIENT_MAX_BODY_SIZE: 20m # default value 1024
      FASTCGI_PASS: 'php-fpm:9000' # default value php:9000
      FASTCGI_CONNECT_TIMEOUT: 30s # default value 60s
      FASTCGI_READ_TIMEOUT: 60s # default value 150s
      FASTCGI_SEND_TIMEOUT: 90s # default value 180s
      GZIP_STATUS: 'off' # default value on
    volumes:
      - /var/log/nginx:/var/log/nginx
      - .:/var/www/
      - ./sites-enabled:/etc/nginx/sites-enabled
    ports:
      - "80:80"
      - "443:443"
    restart: "always"
```
## Example site conf

```
server {
    listen 80;
    server_name  domain.local;
    root /var/www;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    include php-fpm.conf;
    include cross-domain-fonts.conf;
    include expires.conf;
    
    # if you use cloudflare
    # include cloudflare.conf;
}
```