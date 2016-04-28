FROM nginx:1.9.14-alpine
MAINTAINER Eureka <subjectwa@gmail.com>

ENV TIMEZONE Asia/Shanghai
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

RUN apk --update add \
        bash \
        php-mcrypt \
	php-soap \
	php-openssl \
	php-gmp \
	php-pdo_odbc \
	php-json \
	php-dom \
	php-pdo \
	php-zip \
	php-mysql \
	php-sqlite3 \
	php-apcu \
	php-pdo_pgsql \
	php-bcmath \
	php-gd \
	php-xcache \
	php-odbc \
	php-pdo_mysql \
	php-pdo_sqlite \
	php-gettext \
	php-xmlreader \
	php-xmlrpc \
	php-bz2 \
	php-memcache \
	php-iconv \
	php-pdo_dblib \
	php-curl \
	php-ctype \
	php-pear \
	php-zlib \
	php-fpm \
        nodejs  && \
  sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/php-fpm.conf && \
  sed -i -e "s/listen\s*=\s*127.0.0.1:9000/listen = 9000/g" /etc/php/php-fpm.conf && \
  sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php/php.ini && \
  sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php/php.ini && \
  sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php/php.ini && \
  sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php/php.ini && \
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/php.ini && \
  mkdir /www && \
  apk del tzdata && \
  rm -rf /var/cache/apk/*

COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf
ADD run.sh /
RUN chmod +x /run.sh

WORKDIR /www
ADD . /www

CMD ["/run.sh"]
