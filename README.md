# docker nginx with logrotate

1. Pull image from [docker hub](https://hub.docker.com/r/grischuksasha/nginx/)

`docker pull grischuksasha/nginx`

2. Now you can run image

`docker run -it grischuksasha/nginx sh`

## Example docker-compose.yml
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