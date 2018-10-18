# Selenium + Selenese.
FROM selenium/standalone-chrome:latest

LABEL maintainer "Michael Molchanov <mmolchanov@adyax.com>"

USER root

# SSH config.
RUN mkdir -p /root/.ssh
ADD config/ssh /root/.ssh/config
RUN chown root:root /root/.ssh/config && chmod 600 /root/.ssh/config

# Install base.
RUN apt-get update \
  && apt-get -y install \
  bash \
  build-essential \
  curl \
  git-core \
  language-pack-en-base \
  openssl \
  procps \
  software-properties-common \
  wget \
  && locale-gen en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN add-apt-repository ppa:ondrej/php \
  && apt-get update \
  && apt-get -y install \
  php-cli \
  php-bcmath \
  php-bz2 \
  php-curl \
  php-dev \
  php-gd \
  php-gettext \
  php-gmp \
  php-imagick \
  php-intl \
  php-json \
  php-mbstring \
  php-pear \
  php-pspell \
  php-readline \
  php-recode \
  php-tidy \
  php-xml \
  php-xmlrpc \
  php-zip \
  && rm -rf /var/lib/apt/lists/*

# Add composer.
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer \
  && chmod +x /usr/local/bin/composer

# Add composer downloads optimisation.
RUN composer global require hirak/prestissimo

RUN composer global require drush/drush:^8.1.0

COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

