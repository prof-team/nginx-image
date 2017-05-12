FROM nginx:1.13.0-alpine

ADD ./nginx.conf /etc/nginx/

RUN rm /etc/nginx/conf.d/default.conf

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

WORKDIR /var/www

EXPOSE 80
EXPOSE 443