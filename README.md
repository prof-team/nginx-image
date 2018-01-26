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
    index index.php;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;

        fastcgi_pass php:9000;
        fastcgi_index index.php;

        include fastcgi_params;

        fastcgi_connect_timeout     60s;
        fastcgi_read_timeout        120s;
        fastcgi_send_timeout        120s;
        fastcgi_ignore_client_abort on;
        fastcgi_pass_header         "X-Accel-Expires";

        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        fastcgi_param  PATH_INFO        $fastcgi_path_info;
        fastcgi_param  HTTP_REFERER     $http_referer;
    }
    
    include expires.conf;
    
    include cross-domain-fonts.conf;
    
    # if you use cloudflare
    # include cloudflare.conf;
}
```