#!/bin/bash

trap "echo 'Closing...' && service mysql stop && service apache2 stop" EXIT 

find /var/lib/mysql -type f -exec touch {} \; 

service mysql start 

if [ ! -f /var/www/html/wp-config.php ]
then
    echo "Configuring wordpress"
    cd /var/www/html
    wp --allow-root config create --dbname=wordpress --dbuser=$DB_USER --dbpass=$DB_PWD && \
    wp --allow-root db create && \
    wp --allow-root core install --url=localhost:$WP_PORT --title=WP --admin_user=$WP_USER --admin_password=$WP_PWD --admin_email=$WP_EMAIL --skip-email
    wp --allow-root plugin install all-in-one-wp-migration --activate

    if [ -f /infrastructure/data/additional-config.sh ]
    then
        echo "Running additional config"
        /infrastructure/data/additional-config.sh
    fi
fi

service apache2 start

echo "Set web root owner"
chown -R www-data:www-data /var/www/html

echo "Started"

while /bin/true; do
  sleep 1
done
