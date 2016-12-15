FROM phusion/baseimage:0.9.15
MAINTAINER Richard Fullmer <richardfullmer@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_PID_FILE     /var/run/apache2.pid
ENV APACHE_RUN_DIR      /var/run/apache2
ENV APACHE_LOCK_DIR     /var/lock/apache2
ENV APACHE_LOG_DIR      /var/log/apache2

# Upgrade for PHP 5.6
# note: triggers non-fatal error due to non-ASCII characters in repo name
#       (gpg: key E5267A6C: public key "Launchpad PPA for Ond\xc5\x99ej Sur�" imported)
# You can safely ignore that error
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
 && add-apt-repository -y ppa:ondrej/php \
 && apt-key update \
 && apt-get update -y

# install curl
RUN apt-get install -y curl

# install PHP
RUN apt-get install -y --force-yes \
    php5 apache2 libapache2-mod-php5 php5-pgsql php5-json php5-xsl \
	php5-intl php5-mcrypt php5-gd php5-curl php5-memcached

# apt clean
RUN apt-get clean & rm -rf /var/lib/apt/lists/*

# enable apache modules
RUN a2enmod rewrite ssl headers php5

# install composer
RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

ADD 000-default.conf /etc/apache2/sites-available/default
ADD phpinfo.php /var/www/html/phpinfo.php


EXPOSE 80 443

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
