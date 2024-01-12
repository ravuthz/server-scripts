#!/bin/bash
echo "Install Git"
sudo install git -y

echo "Install Nginx"
sudo install nginx -y

curl -s https://deb.nodesource.com/setup_18.x | sudo bash
sudo apt install nodejs -y

node -v

# pm2
curl -sL https://raw.githubusercontent.com/Unitech/pm2/master/packager/setup.deb.sh | sudo -E bash -
