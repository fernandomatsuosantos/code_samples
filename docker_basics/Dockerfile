FROM ubuntu:20.04

# Update the repository sources list
RUN apt-get update

# Install and run apache
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y php libapache2-mod-php php-mysql
RUN apt-get clean

#ENTRYPOINT ["/usr/sbin/apache2", "-k", "start"]
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
COPY public-php /var/www/site/app
COPY apache-config.conf /etc/apache2/sites-enabled/000-default.conf
WORKDIR /var/www/site/app

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]