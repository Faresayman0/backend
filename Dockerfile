FROM richarvey/nginx-php-fpm:latest

# تثبيت npm
RUN apt-get update && apt-get install -y nodejs npm

# نسخ محتويات المشروع
COPY . /var/www/html

WORKDIR /var/www/html

# تثبيت حزم PHP و npm
RUN composer install
RUN npm install
RUN npm run prod

# تشغيل الترحيلات
RUN php artisan migrate --force

# تعرض المنفذ 80
EXPOSE 80
