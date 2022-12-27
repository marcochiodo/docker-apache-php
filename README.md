# Docker Apache PHP

[GitHub Project](https://github.com/marcochiodo/docker-apache-php)

[DockerHub Image](https://hub.docker.com/r/sigblue/apache-php)

Developed by [Marco Chiodo](https://www.marcochiodo.it/)

## Usage

This image extend `php:*-apache`, and install all most common extension packaged in 3 versions:
- light
- standard
- full

Only the following extensions need to be manually enabled via `docker-php-ext-enable` in your Dockerfile or via php.ini file. Note that you can also put a php.ini file in `/var/www/html`.
``` ini
extension=grpc.so
extension=imagick.so
extension=memcached.so
extension=mongodb.so
extension=protobuf.so
extension=redis.so
```

This image replace port 80 in `/etc/apache2/ports.conf` with `${PORT}` and load this file as default apache file:

```
<VirtualHost *:${PORT}>

  DocumentRoot /var/www/html/public

  RewriteEngine On

  RewriteCond %{HTTP:Authorization} ^(.*)
  RewriteRule .* - [e=HTTP_AUTHORIZATION:%1]

  <Directory /var/www/html/public > 
    RewriteCond %{REQUEST_FILENAME} -s [OR]
    RewriteCond %{REQUEST_FILENAME} -l [OR]
    RewriteCond %{REQUEST_FILENAME} -d
    RewriteRule ^.*$ - [NC,L]

    RewriteCond %{REQUEST_URI}::$1 ^(/.+)(.+)::\2$
    RewriteRule ^(.*) - [E=BASE:%1]
    RewriteRule ^(.*)$ %{ENV:BASE}index.php [NC,L]
  </Directory>

  <Directory /var/www/html > 
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
  </Directory>

  LogLevel notice

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
```
