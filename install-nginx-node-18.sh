#!/bin/bash
echo "Install Git"
sudo install git -y

echo "Install Nginx"
sudo install nginx -y

curl -s https://deb.nodesource.com/setup_18.x | sudo bash
sudo apt install nodejs -y

node -v

sudo npm install pm2 -g

sudo npm install yarn -g
