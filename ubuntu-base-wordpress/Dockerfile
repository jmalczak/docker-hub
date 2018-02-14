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

RUN a2enmod rewrite
RUN awk '{ gsub("DocumentRoot /var/www/html", "DocumentRoot /var/www/html\n\t<Directory /var/www/html>\n\t\tAllowOverride All\n\t</Directory>") } 1' /etc/apache2/sites-available/000-default.conf > tmp.conf && mv tmp.conf /etc/apache2/sites-available/000-default.conf

RUN mkdir /infrastructure
COPY docker-entrypoint.sh /infrastructure/

CMD ["/infrastructure/docker-entrypoint.sh"]
