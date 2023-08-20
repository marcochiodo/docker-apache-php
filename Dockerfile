ARG VERSION

FROM php:$VERSION-apache-bullseye as light

RUN echo 'Acquire::http::Timeout "10";' >> /etc/apt/apt.conf.d/80-custom-options
RUN echo 'Acquire::Retries "5";' >> /etc/apt/apt.conf.d/80-custom-options
RUN echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf.d/80-custom-options

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && apt-get update --fix-missing

RUN apt-get install --fix-missing -y apt-utils

RUN apt-get upgrade -y

RUN apt-get install --fix-missing -y \
	curl wget git zip unzip g++ \
	libzip-dev libicu-dev libssl-dev

RUN pecl install protobuf
RUN pecl install mongodb
RUN pecl install apcu

RUN docker-php-ext-install \
	bcmath \
	calendar \
	intl \
	opcache \
	zip

##
# Common Apache config
##
COPY ./apache /etc/apache2/sites-available/000-default.conf
	
RUN sed -i 's/80/${PORT}/g' /etc/apache2/ports.conf && \
	cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
	a2enmod rewrite headers mime

RUN useradd -u 1000 -g www-data -m -s /bin/bash developer

COPY ./composer-installer.sh /var/www/

RUN chown www-data:www-data /var/www

WORKDIR /var/www/html

ENV PORT=80

##
# END Common Apache config
##

FROM light as standard

RUN apt-get install --fix-missing -y \
		libbz2-dev libpq-dev libpng-dev

RUN pecl install grpc
RUN pecl install redis

RUN docker-php-ext-install \
	bz2 \
	pdo_pgsql \
	pdo_mysql \
	gd

FROM standard as full

RUN apt-get install --fix-missing -y \
		procps pkg-config \
		libc-dev zlib1g-dev libgmp-dev \
		libldb-dev libldap2-dev libmemcached-dev libtidy-dev libxslt-dev libmagickwand-dev libxml2-dev

RUN pecl install memcached
RUN pecl install imagick
#RUN pecl install opencensus

RUN docker-php-ext-install \
	dba \
	gettext \
	gmp \
	ldap \
	mysqli \
	pcntl \
	pgsql \
	shmop \
	soap \
	sockets \
	sysvshm \
	tidy \
	xsl \
	zend_test
	
# RUN docker-php-ext-install xmlrpc
# RUN pecl install stackdriver_debugger-0.2.0



