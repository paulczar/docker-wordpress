# Creates wordpress install 
#
# Author: Paul Czarkowski
# Date: 08/11/2013


FROM paulczar/apache2-php
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN apt-get -y install php5-mysql

ADD wordpress /var/www
ADD start /wordpress/start
RUN chmod 700 /wordpress/start
ADD wordpress.sql /wordpress/wordpress.sql

CMD ["/wordpress/start"]