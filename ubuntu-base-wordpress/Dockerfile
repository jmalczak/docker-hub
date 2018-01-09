FROM malczu/ubuntu-base-php:1.0.0

ENV DB_USER root
ENV DB_PWD root
ENV WP_PORT 8080
ENV WP_USER admin
ENV WP_PWD admin
ENV WP_EMAIL test@doesntextist.invaliddomain

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod a+x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN cd /var/www/html && \
    rm index.html && \ 
    wp --allow-root core download

RUN mkdir /infrastructure

COPY docker-entrypoint.sh /infrastructure/

CMD ["/infrastructure/docker-entrypoint.sh"]
