FROM wordpress:php7.4

RUN apt-get update && \
    apt-get -y install msmtp

COPY sendmail.ini /usr/local/etc/php/conf.d/sendmail.ini

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
