FROM ubuntu:17.10

ENV DB_PWD root

RUN apt-get update && apt-get upgrade
RUN apt-get install -y vim curl less

RUN echo "mysql-server mysql-server/root_password password $DB_PWD" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password $DB_PWD" | debconf-set-selections 

RUN apt-get install -y apache2 php mysql-server mysql-client 

RUN echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections && \
    echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections && \
    echo "phpmyadmin phpmyadmin/app-password-confirm password $DB_PWD" | debconf-set-selections && \
    echo "phpmyadmin phpmyadmin/mysql/admin-pass password $DB_PWD" | debconf-set-selections && \
    echo "phpmyadmin phpmyadmin/mysql/app-pass password $DB_PWD" | debconf-set-selections

RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start && apt-get install -y phpmyadmin && service mysql stop
