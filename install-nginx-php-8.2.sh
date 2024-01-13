#!/bin/bash

sudo -s
sudo NEEDRESTART_MODE=a apt-get dist-upgrade --yes

sudo apt update 
sudo apt upgrade -y

sudo apt-get install software-properties-common -y
sudo apt update

# Install NGINX
echo "Installing Nginx"
sudo apt install nginx -y

# Install PHP 8.2
echo "Installing PHP 8.2 with extensions"
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get install -y php8.2 php8.2-mbstring php8.2-cli php8.2-common php8.2-fpm php8.2-zip php8.2-gd  php8.2-curl php8.2-xml php8.2-bcmath
sudo apt-get install -y php8.2-mysql php8.2-pgsql php8.2-redis php8.2-sqlite3 php8.2-imagick php8.2-intl

echo "Checking PHP version"
php --version
# php --modules

# Install Git
echo "Installing Git"
sudo apt-get install git

# Install Composer
echo "Installing Composer"
sudo apt-get install composer -y
