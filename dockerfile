FROM php:8.4-fpm

# Install fish shell and other dependencies
RUN apt-get update && apt-get install -y fish \
    build-essential libpng-dev libjpeg-dev libonig-dev libxml2-dev libpq-dev zip unzip curl git libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring zip exif pcntl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create 'fish' user with fish shell as default shell
RUN useradd -ms /usr/bin/fish fish

WORKDIR /var/www
COPY . .

#install fish terminal
RUN chown -R fish:fish /var/www

USER fish
RUN composer install

USER root

# Server identity mensaje
RUN echo "    _    __     __    _   _                     _           \n\
   / \\   \\ \\   / /   | |_| |__   ___ _ __ ___  | |__  _   _ \n\
  / _ \\   \\ \\ / /____| __| '_ \\ / _ \\ '__/ _ \\ | '_ \\| | | |\n\
 / ___ \\   \\ V /_____| |_| | | |  __/ | | (_) || |_) | |_| |\n\
/_/   \\_\\   \\_/       \\__|_| |_|\\___|_|  \\___(_)_.__/ \\__, |\n\
                                                      |___/ " > /etc/motd

#execure php fpm a service that allow to Nginx to execute php commadns
CMD ["php-fpm"]
# Exponer el puerto que Render usará
EXPOSE 8080

# Comando de inicio compatible con Render (usa el servidor embebido de Laravel)
#CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
