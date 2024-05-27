
FROM richarvey/nginx-php-fpm:latest

COPY . /var/www/html

WORKDIR /var/www/html

RUN composer install
RUN npm install
RUN npm run prod
RUN php artisan migrate --force

EXPOSE 80
