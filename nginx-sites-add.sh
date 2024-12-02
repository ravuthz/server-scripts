#!/bin/bash

# Output file name
OUTPUT_FILE=${1}

PHP_VERSION=$(php -v | awk '/^PHP/{print $2}' | cut -d. -f1,2)

NGINX_SERVER_PORT=${2:-80}
NGINX_SERVER_ROOT=${3:-"/var/www/html"}
PHP_FPM="php$PHP_VERSION-fpm"
PHP_FPM_SOCK=${PHP_FPM_SOCK:-"unix:/var/run/php/php$PHP_VERSION-fpm.sock"}

# Generate the site.conf file
cat <<EOF > "/etc/nginx/sites-enabled/$OUTPUT_FILE"
server {
    listen $NGINX_SERVER_PORT;

    root "$NGINX_SERVER_ROOT/public";
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";
    index index.php;
    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    error_page 404 /index.php;

    location ~ \.php\$ {
        include fastcgi_params;
        fastcgi_pass $PHP_FPM_SOCK;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_read_timeout 1200;
        proxy_connect_timeout 1200;
        proxy_send_timeout 60;
        proxy_read_timeout  60;
    }

    location /fpm_status {
        fastcgi_pass $PHP_FPM_SOCK;
        fastcgi_index /fpm_status;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location /nginx_status {
        stub_status on;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

echo "Configuration file '$OUTPUT_FILE' generated successfully."


# Update the PHP-FPM configuration
sed -i \
    -e 's/^pm = .*/pm = dynamic/' \
    -e 's/^pm.max_children = .*/pm.max_children = 50/' \
    -e 's/^pm.start_servers = .*/pm.start_servers = 10/' \
    -e 's/^pm.min_spare_servers = .*/pm.min_spare_servers = 5/' \
    -e 's/^pm.max_spare_servers = .*/pm.max_spare_servers = 15/' \
    -e 's/^pm.max_requests = .*/pm.max_requests = 500/' \
    "$PHP_FPM_POOL"

# Update the permissions
chown -R www-data:www-data "$NGINX_SERVER_ROOT"
chmod -R 750 "$NGINX_SERVER_ROOT"

nginx -t
"$PHP_FPM" -t
systemctl restart nginx
systemctl restart "$PHP_FPM"

cat /etc/php/$PHP_FPM/fpm/pool.d/www.conf | grep 'pm ='
cat /etc/php/$PHP_FPM/fpm/pool.d/www.conf | grep 'pm.'
