#!/bin/bash
sudo apt update 
sudo apt upgrade -y

sudo apt-get install software-properties-common -y
sudo apt update

echo "Install Git"
sudo install git -y

echo "Install Nginx"
sudo install nginx -y

curl -s https://deb.nodesource.com/setup_18.x | sudo bash
sudo apt-get install nodejs -y

node -v

sudo npm install pm2 -g

sudo npm install yarn -g
