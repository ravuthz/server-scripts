#!/bin/bash

sudo NEEDRESTART_MODE=a apt-get dist-upgrade --yes

sudo apt update 
sudo apt upgrade --yes

sudo apt-get install --yes software-properties-common
sudo apt update

echo "Installing Git"
sudo apt-get install --yes git

echo "Installing Nginx"
sudo apt-get install --yes nginx

curl -s https://deb.nodesource.com/setup_18.x | sudo bash
sudo apt-get install --yes nodejs

echo "Node version"
node -v

echo "Installing PM2"
sudo npm install pm2 -g

echo "Installing YARN"
sudo npm install yarn -g
