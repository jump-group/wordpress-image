FROM php:8.2-fpm

# Install persistent dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ghostscript \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libzip-dev \
    zlib1g-dev \
    libmagickwand-dev \
    imagemagick \
    libmemcached-dev \
    libssl-dev \
    mariadb-client \
    libxml2-dev \
    sudo less && \
    rm -rf /var/lib/apt/lists/*

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
    bcmath exif gd mysqli pdo_mysql soap zip

# Install imagick via PECL
RUN pecl install imagick && \
    docker-php-ext-enable imagick

# Install memcached extension
RUN pecl install memcached && \
    docker-php-ext-enable memcached

# Configure ZIP extension
RUN docker-php-ext-configure zip && \
    docker-php-ext-install zip

# Forward email to Mailhog
RUN curl -o /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
    chmod +x /usr/local/bin/mhsendmail && \
    echo 'sendmail_path="/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025 --from=no-reply@gbp.lo"' > /usr/local/etc/php/conf.d/mailhog.ini

# Set recommended PHP settings for opcache
RUN docker-php-ext-enable opcache && \
    echo 'opcache.memory_consumption=128' > /usr/local/etc/php/conf.d/opcache-recommended.ini && \
    echo 'opcache.interned_strings_buffer=8' >> /usr/local/etc/php/conf.d/opcache-recommended.ini && \
    echo 'opcache.max_accelerated_files=4000' >> /usr/local/etc/php/conf.d/opcache-recommended.ini && \
    echo 'opcache.revalidate_freq=2' >> /usr/local/etc/php/conf.d/opcache-recommended.ini && \
    echo 'opcache.fast_shutdown=1' >> /usr/local/etc/php/conf.d/opcache-recommended.ini

# Set up error logging
RUN echo 'error_reporting = E_ALL' > /usr/local/etc/php/conf.d/error-logging.ini && \
    echo 'display_errors = Off' >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo 'log_errors = On' >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo 'error_log = /dev/stderr' >> /usr/local/etc/php/conf.d/error-logging.ini

# Install wp-cli (as root)
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /bin/wp-cli.phar && \
    mv /bin/wp-cli.phar /usr/local/bin/wp && \
    mkdir -p /var/www/.wp-cli

# Add user 'web'
RUN adduser --disabled-password --gecos '' web && \
    chown -R web:web /var/www/.wp-cli

# Switch to non-root user
USER web

# Set working directory and ownership for wp-cli cache
WORKDIR /var/www/html