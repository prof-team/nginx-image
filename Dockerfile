FROM nginx:1.13

ADD ./nginx.conf /etc/nginx/
ADD ./expires.conf /etc/nginx/
ADD ./cross-domain-fonts.conf /etc/nginx/

ADD ./conf.d/gzip.conf /etc/nginx/conf.d/

RUN rm /etc/nginx/conf.d/default.conf

RUN rm -rf /var/www/* && chown -R www-data:www-data /var/www

WORKDIR /var/www

EXPOSE 80
EXPOSE 443