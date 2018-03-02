FROM nginx:1.13-alpine

RUN addgroup -g 1000 -S www-data \
 && adduser -u 1000 -D -S -G www-data www-data

RUN apk add --update nano git logrotate && rm -rf /var/cache/apk/*

ADD ./logrotate/nginx /etc/logrotate.d/nginx

ADD ./nginx.conf /etc/nginx/
ADD ./expires.conf /etc/nginx/
ADD ./cross-domain-fonts.conf /etc/nginx/
ADD ./cloudflare.conf /etc/nginx/
ADD ./php-fpm.conf /etc/nginx/

ADD ./conf.d/*.conf /etc/nginx/conf.d/

RUN rm /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

WORKDIR /var/www

EXPOSE 80
EXPOSE 443

CMD service cron start && nginx -g 'daemon off;'