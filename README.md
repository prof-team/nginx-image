# docker nginx with logrotate

1. Pull image from [docker hub](https://hub.docker.com/r/grischuksasha/nginx/)

`docker pull grischuksasha/nginx`

2. Now you can run image

`docker run -it grischuksasha/nginx sh`

## Example docker-compose.yml for nginx
```
version: '3'

services:
  nginx:
    container_name: nginx
    image: grischuksasha/nginx
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