FROM php:8.1-apache
#FROM php:7.3-cli

WORKDIR /opt/app
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

USER root

RUN apt-get update -qq && apt-get install -y wget
RUN apt-get update && apt-get install -y tmux

RUN chmod +x /usr/local/bin/install-php-extensions && sync && install-php-extensions gd xdebug zip pdo_mysql

RUN docker-php-source extract && docker-php-source delete

RUN cd /usr/local/etc/php/conf.d/ && \
  echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-ram-limit.ini

#composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN alias composer='php /usr/bin/composer'
#composer

#node and yarn
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get install -y nodejs
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

#RUN apt-get install -y \
#  dirmngr \
#  gnupg

#RUN #apt-key adv --keyserver pgp.mit.edu --recv D101F7899D41F3C3
RUN apt-get update -qq && apt-get install -y -qq yarn
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/
#node and yarn



#RUN apt-get update -qq && apt-get install -y wkhtmltopdf xvfb
#RUN echo '#!/bin/bash\nxvfb-run -a --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf -q $*' >/usr/bin/wkhtmltopdf.sh
#RUN chmod a+x /usr/bin/wkhtmltopdf.sh
#RUN symfony self:update
#RUN ln -s /usr/bin/wkhtmltopdf.sh /usr/local/bin/wkhtmltopdf



#
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
#


#RUN useradd -u 1000 metheuser
#USER metheuser

#RUN yarn add vue vue-loader vue-template-compiler --dev
