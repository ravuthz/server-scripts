#!/bin/bash

sudo -s
sudo NEEDRESTART_MODE=a apt-get dist-upgrade --yes

composer install

php artisan key:generate

mv /var/www/html /var/www/html_$(date +"%Y%m%d_%H%M%S")
mkdir /var/www/html
ls -lah /var/www/html

sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default_

sudo cat >> /etc/nginx/sites-available/default << 'EOL'
server {
    listen 80;
    # server_name laravel-api.com;
    root /var/www/html/public;
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";
    index index.php;
    charset utf-8;
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    error_page 404 /index.php;
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }
    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOL

nginx -t

sudo systemctl restart nginx
