# استخدام صورة PHP الأساسية مع Apache والإصدار 8.1
FROM php:8.1-apache

# تثبيت المتطلبات الأساسية
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    git \
    unzip \
    zip \
    p7zip-full \
    libzip-dev

# تثبيت الامتداد zip لـ PHP
RUN docker-php-ext-install zip

# تثبيت Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# تثبيت Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# نسخ محتويات المشروع
COPY . /var/www/html

WORKDIR /var/www/html

# تثبيت حزم PHP و npm
RUN composer install
RUN npm install
RUN npm run build

# تعريض المنفذ 80
EXPOSE 80

# أمر تشغيل التطبيق
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]
