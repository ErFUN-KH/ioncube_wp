ARG PHP_VER=7.3
FROM wordpress:php${PHP_VER}-apache
MAINTAINER Erfun KH <erfun.kh@gmail.com>

ARG PHP_VER

# Install ioncube
ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/
RUN tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ && \
	php_ext_dir="$(php -i | grep extension_dir | head -n1 | awk '{print $3}')" && \
	mv /tmp/ioncube/ioncube_loader_lin_${PHP_VER}.so "${php_ext_dir}/" && \
    echo "zend_extension = $php_ext_dir/ioncube_loader_lin_${PHP_VER}.so" \
        > /usr/local/etc/php/conf.d/00-ioncube.ini && \
	rm /tmp/ioncube_loaders_lin_x86-64.tar.gz && \
	rm -rf /tmp/ioncube

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
