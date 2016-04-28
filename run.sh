#!/bin/sh
nginx
php-fpm --fpm-config /etc/php/php-fpm.conf -c /etc/php/php.ini
