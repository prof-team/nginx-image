FROM nginx:1.13

RUN apt-get update \
	&& apt-get install -y htop nano git logrotate supervisor

ADD ./logrotate/nginx /etc/logrotate.d/nginx

ADD ./nginx.conf /etc/nginx/
ADD ./expires.conf /etc/nginx/
ADD ./cross-domain-fonts.conf /etc/nginx/
ADD ./cloudflare.conf /etc/nginx/
ADD ./php-fpm.conf /etc/nginx/

ADD ./conf.d/*.conf /etc/nginx/conf.d/

ADD ./supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN rm /etc/nginx/conf.d/default.conf

RUN rm /etc/cron.daily/logrotate
ADD ./cron/logrotate /etc/cron.d/logrotate

RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

RUN apt-get clean && apt-get autoclean && apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

WORKDIR /var/www

EXPOSE 80
EXPOSE 443